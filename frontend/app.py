from flask import Flask, render_template, request, jsonify
import requests

app = Flask(__name__)

@app.route('/')
def index():
    response = requests.get('http://backend:5000/api')
    data = response.json()
    return render_template('index.html', data=data)

@app.route('/submit', methods=['POST'])
def submit():
    username = request.form['username']
    email = request.form['email']
    response = requests.post('http://backend:5000/api', json={'username': username, 'email': email})
    if response.status_code == 200:
        return jsonify({'message': 'Data has been saved successfully!'})
    else:
        return jsonify({'message': 'Failed to save data.'}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
