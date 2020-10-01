import boto3
import os

client = boto3.client('ec2')
sesClient = boto3.client('ses')

SOURCE_EMAIL = os.environ['SOURCE_EMAIL']
DEST_EMAIL = os.environ['DEST_EMAIL']

def lambda_handler(event, context):
    response = client.describe_addresses()["Addresses"]
    eips = []
    for eip in response:
        if 'InstanceId' not in eip:
            eips.append(eip['PublicIp'])
    # Print EIPs
    print(eips)

    # Send email using SES
    if eips:
        sesClient.send_email(
            Source = SOURCE_EMAIL
            Destination = {
                'ToAddresses':[DEST_EMAIL]
            },
            Message={
                'Subject':{
                    'Data': 'Unused EIPs',
                    'Charset':'utf-8'
                },
                'Body':{
                    'Text':{
                        'Data': str(eips),
                        'Charset':'utf-8'
                    }
                }
            }
        )
