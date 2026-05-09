import os
from flask import Flask, request, jsonify
from flask_cors import CORS
from openai import OpenAI

app = Flask(__name__)
CORS(app)
client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))

@app.route('/ask', methods=['POST'])
def ask():
    data = request.json
    if data.get('master_password') != os.getenv('MASTER_PASSWORD', 'master123'):
        return jsonify({'reply': 'Unauthorized'}), 403
    try:
        resp = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[{"role": "user", "content": data['message']}]
        )
        reply = resp.choices[0].message.content
    except Exception as e:
        reply = f"Error: {str(e)}"
    return jsonify({'reply': reply})

@app.route('/health')
def health():
    return jsonify({'status': 'ok'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
