from flask import Flask
from hello_world.views import register_routes

app = Flask(__name__)

register_routes(app)
