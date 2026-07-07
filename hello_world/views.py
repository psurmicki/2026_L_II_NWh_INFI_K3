from flask import request

from hello_world.formater import PLAIN, SUPPORTED, get_formatted


moje_imie = "Przemek"
msg = "Hello World!"


def register_routes(app):
    @app.route('/')
    def index():
        output = request.args.get('output')
        if not output:
            output = PLAIN

        return get_formatted(msg, moje_imie, output.lower())

    @app.route('/output')
    @app.route('/outputs')
    def supported_output():
        return ", ".join(SUPPORTED)
