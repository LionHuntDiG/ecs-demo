from flask import Flask, request, jsonify
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

app = Flask(__name__)

dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('MyNoSQLTable')

@app.route('/api', methods=['GET'])
def get_entries():
    try:
        response = table.scan(Limit=10)
        items = response.get('Items', [])
        return jsonify(items)
    except NoCredentialsError as e:
        app.logger.error("No credentials error: %s", str(e))
        return jsonify({"error": "No credentials error"}), 500
    except PartialCredentialsError as e:
        app.logger.error("Partial credentials error: %s", str(e))
        return jsonify({"error": "Partial credentials error"}), 500
    except Exception as e:
        app.logger.error("Unexpected error: %s", str(e))
        return jsonify({"error": "Unexpected error"}), 500

@app.route('/api', methods=['POST'])
def add_entry():
    data = request.get_json()
    try:
        table.put_item(Item={
            'username': data['username'],
            'email': data['email'],
            'ID': data.get('ID')  # Ensure you include the primary key attribute
        })
        return jsonify({"message": "Data has been saved successfully!"})
    except NoCredentialsError as e:
        app.logger.error("No credentials error: %s", str(e))
        return jsonify({"error": "No credentials error"}), 500
    except PartialCredentialsError as e:
        app.logger.error("Partial credentials error: %s", str(e))
        return jsonify({"error": "Partial credentials error"}), 500
    except Exception as e:
        app.logger.error("Unexpected error: %s", str(e))
        return jsonify({"error": "Unexpected error"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
