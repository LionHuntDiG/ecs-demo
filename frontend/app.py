from flask import Flask, render_template, request, jsonify
import requests
import os
import time

app = Flask(__name__)

# Get the backend URL from the environment variable
backend_url = os.getenv('BACKEND_URL', 'http://backend.myapp.local:5000/api')

@app.route('/')
def index():
    try:
        response = requests.get(backend_url)
        data = response.json()
        
        # Ensure all timestamps are integers and sort the entries by timestamp
        for entry in data:
            if 'timestamp' in entry:
                entry['timestamp'] = int(entry['timestamp'])
        
        sorted_data = sorted(data, key=lambda x: x.get('timestamp', 0), reverse=True)
        latest_data = sorted_data[:10]
        
        return render_template('index.html', data=latest_data)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/submit', methods=['POST'])
def submit():
    username = request.form['username']
    email = request.form['email']
    timestamp = int(time.time())  # Current timestamp
    
    response = requests.post(backend_url, json={'username': username, 'email': email, 'timestamp': timestamp})
    if response.status_code == 200:
        return jsonify({'message': 'Data has been saved successfully!'})
    else:
        return jsonify({'message': 'Failed to save data.'}), 400

@app.route('/health')
def health():
    return jsonify({'status': 'ok'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
