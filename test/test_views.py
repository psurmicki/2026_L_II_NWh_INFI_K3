import unittest
from hello_world import app
from hello_world.formater import SUPPORTED
import json

class FlaskrTestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_outputs(self):
        rv = self.app.get('/output')
        s = str(rv.data)
        ','.join(SUPPORTED) in s

    def test_msg_with_output(self):
        rv = self.app.get('/?output=json')
        self.assertEqual({
            "imie": "Przemek",
            "msg": "Hello World!"
        },
            json.loads(rv.data)
        )
