import boto3
import json
import os

s3 = boto3.client('s3')
translate = boto3.client('translate')

def lambda_handler(event, context):
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = event['Records'][0]['s3']['object']['key']

    obj = s3.get_object(Bucket=bucket_name, Key=object_key)
    body = json.loads(obj['Body'].read().decode('utf-8'))

    response = translate.translate_text(
        Text=body['text'],
        SourceLanguageCode='en',
        TargetLanguageCode=body['target_language']
    )

    result = {
        "original_text": body['text'],
        "translated_text": response['TranslatedText'],
        "target_language": body['target_language']
    }

    s3.put_object(
        Bucket=os.environ['RESPONSE_BUCKET'],
        Key=f"translated_{object_key}",
        Body=json.dumps(result).encode('utf-8')
    )

    return {"status": "success"}
