import os
import logging
import boto3
from botocore.config import Config
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(os.environ.get("LOG_LEVEL", "INFO"))

boto_config = Config(
    retries={
        "max_attempts": 5,
        "mode": "standard",
    }
)

rds_client = boto3.client("rds", config=boto_config)

DB_INSTANCE_IDENTIFIER = os.environ["DB_INSTANCE_IDENTIFIER"]
def lambda_handler(event, context):
    switch = event.get("switch")
    logger.info(f"Invocation started. switch={switch}, db={DB_INSTANCE_IDENTIFIER}")

    try:
        response = rds_client.describe_db_instances(
            DBInstanceIdentifier=DB_INSTANCE_IDENTIFIER
        )
        current_state = response["DBInstances"][0]["DBInstanceStatus"]
    except rds_client.exceptions.DBInstanceNotFoundFault:
        logger.error(f"DB instance not found: {DB_INSTANCE_IDENTIFIER}")
        return {"status": "error", "reason": "instance_not_found"}
    except ClientError as e:
        logger.error(f"Unexpected AWS error while describing {DB_INSTANCE_IDENTIFIER}: {e}")
        raise


    try:
        if switch == "off" and current_state == "available":
            rds_client.stop_db_instance(DBInstanceIdentifier=DB_INSTANCE_IDENTIFIER)
            logger.info(f"Stop initiated for {DB_INSTANCE_IDENTIFIER}")
        elif switch == "on" and current_state == "stopped":
            rds_client.start_db_instance(DBInstanceIdentifier=DB_INSTANCE_IDENTIFIER)
            logger.info(f"Start initiated for {DB_INSTANCE_IDENTIFIER}")
        else:
            # This branch is what makes duplicate/retried invocations safe:
            # if the instance is already mid-transition or in the target
            # state, we deliberately no-op instead of erroring or retrying.
            logger.warning(
                f"No action taken (idempotent no-op). "
                f"switch={switch}, current_state={current_state}"
            )
    except rds_client.exceptions.InvalidDBInstanceStateFault as e:
        logger.warning(f"DB instance in a non-actionable state: {e}")
        return {"status": "skipped", "reason": "invalid_state"}
    except ClientError as e:
        logger.error(f"Unexpected AWS error while acting on {DB_INSTANCE_IDENTIFIER}: {e}")
        raise

    return {"status": "success", "db": DB_INSTANCE_IDENTIFIER, "action": switch}