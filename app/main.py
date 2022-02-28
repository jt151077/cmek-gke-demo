import os
import json
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy

dbuser = os.environ['POSTGRES_USER']
dbpass = os.environ['POSTGRES_PASSWORD']

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://{}:{}@postgres:5432/flaskapi'.format(dbuser, dbpass)
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db = SQLAlchemy(app)


class Users(db.Model):
    id = db.Column('user_id', db.Integer, primary_key = True)
    user_name = db.Column(db.String(255), nullable=False)
    user_email = db.Column(db.String(255), unique=True, nullable=False)
    user_password = db.Column(db.String(255), nullable=False)

    def __init__(self, uname, uemail, upass):
        self.user_name = uname
        self.user_email = uemail
        self.user_password = upass


@app.route("/")
def index():
    """Function to test the functionality of the API"""
    return "Hello, world!"


@app.route("/create", methods=["POST"])
def add_user():
    """Function to add a user to the Postgres database"""
    json = request.json
    name = json["name"]
    email = json["email"]
    pwd = json["pwd"]
    if name and email and pwd and request.method == "POST":
        user = Users(name, email, pwd)
        db.session.add(user)
        db.session.commit()

        return jsonify(str(user))
    else:
        return jsonify("Please provide name, email and pwd")


@app.route("/list", methods=["GET"])
def get_user():
    """Function to get all users to the Postgres database"""
    results = Users.query.order_by(Users.id).all()
    lst = [dict(row.items()) for row in results]

    return json.dumps(lst)



if __name__ == "__main__":
    db.create_all()
    app.run(debug=True, host="0.0.0.0", port=5000)
