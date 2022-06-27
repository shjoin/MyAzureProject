import boto3
def lambda_handler(event, context):
    file_name = event['Records'][0]['s3']['object']['key'];
    service_name='s3'
    region_name='us-east-2'
    aws_access_key_id='AKIA34DQQVF4ENGTXO6S'
    aws_secret_access_key='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'
    s3 = boto3.resource(
        service_name=service_name,
        region_name=region_name,
        aws_access_key_id=aws_access_key_id,
        aws_secret_access_key=aws_secret_access_key
        )
    copy_source = {
        'Bucket': 'shjos3',
        'Key': file_name
    }
    s3.meta.client.copy(copy_source, 'shjos3redshift',file_name)