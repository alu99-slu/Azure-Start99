from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route("/")
def index():
    return jsonify({
        "message": "Hello from Azure Cloud Starter - Day demo",
        "env": {
            "FLASK_ENV": os.getenv("FLASK_ENV", "production")
        }
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)