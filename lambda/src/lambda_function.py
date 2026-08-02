import boto3

rds_client = boto3.client("rds")

def lambda_handler(event, context):
    db_identifier = ""  
    switch = event.get("switch")

    response = rds_client.describe_db_instances(DBInstanceIdentifier=db_identifier)
    current_state = response["DBInstances"][0]["DBInstanceStatus"]

    print(f"Current state of {db_identifier}: {current_state}")

    if switch == "off" and current_state == "available":
        rds_client.stop_db_instance(DBInstanceIdentifier=db_identifier)
        print(f"Stopping {db_identifier}")
    elif switch == "on" and current_state == "stopped":
        rds_client.start_db_instance(DBInstanceIdentifier=db_identifier)
        print(f"Starting {db_identifier}")
    else:
        print(f"No action taken. switch={switch}, state={current_state}")