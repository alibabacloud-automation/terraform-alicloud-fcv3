import json
import os

def handler(event, context):
    env = os.environ.get('ENVIRONMENT', 'unknown')
    log_level = os.environ.get('LOG_LEVEL', 'info')
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Hello from Advanced Function!',
            'environment': env,
            'log_level': log_level
        })
    }
