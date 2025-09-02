import json
from datetime import datetime
import boto3

BUCKET_NAME = "lambda-output-files-sdf"
FILE_KEY = "lambda_output.json"

s3_client = boto3.client('s3')

def lambda_handler(event, context):

    now = datetime.now()
    
    # Format the date and time
    formatted_datetime = now.strftime("%Y-%m-%d %H:%M:%S")
    
    data = {
        'message': f"Hello! Have a Nice day! Today is {formatted_datetime}"
    }
    
    # Convert data to JSON string
    json_data = json.dumps(data)
    
    # Save to S3 (overwrites if the file already exists)
    s3_client.put_object(
        Bucket=BUCKET_NAME,
        Key=FILE_KEY,
        Body=json_data,
        ContentType='application/json'
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps(data)
    }

    # return {
    #     "statusCode": 200,
    #     "headers": {
    #         "Content-Type": "application/json"
    #     },
    #     "body": json.dumps(data)  # body must be a string
    # }
