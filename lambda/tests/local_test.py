from src.lambda_function import lambda_handler

test_event = {"switch": "off"}
lambda_handler(test_event, None)