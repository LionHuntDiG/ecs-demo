from flask import Flask, jsonify
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

app = Flask(__name__)

dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('MyNoSQLTable')

@app.route('/api')
def api():
    try:
        response = table.scan()
        items = response['Items']
        return jsonify(items)
    except (NoCredentialsError, PartialCredentialsError) as e:
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
