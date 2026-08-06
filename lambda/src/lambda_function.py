import os
import boto3

rds_client = boto3.client("rds")

DB_INSTANCE_IDENTIFIER = os.environ["DB_INSTANCE_IDENTIFIER"]


def lambda_handler(event, context):
    switch = event.get("switch")

    response = rds_client.describe_db_instances(
        DBInstanceIdentifier=DB_INSTANCE_IDENTIFIER
    )
    current_state = response["DBInstances"][0]["DBInstanceStatus"]

    print(f"Current state of {DB_INSTANCE_IDENTIFIER}: {current_state}")

    if switch == "off" and current_state == "available":
        rds_client.stop_db_instance(DBInstanceIdentifier=DB_INSTANCE_IDENTIFIER)
        print(f"Stopping {DB_INSTANCE_IDENTIFIER}")
    elif switch == "on" and current_state == "stopped":
        rds_client.start_db_instance(DBInstanceIdentifier=DB_INSTANCE_IDENTIFIER)
        print(f"Starting {DB_INSTANCE_IDENTIFIER}")
    else:
        print(f"No action taken. switch={switch}, state={current_state}")