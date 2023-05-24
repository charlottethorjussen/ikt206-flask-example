import unittest
import app as tested_app
import json


class FlaskAppTests(unittest.TestCase):

    def test_title(site):
        site.get(f'{site.base_url}')
        assert "Flask Example" in site.title


if __name__ == '__main__':
    unittest.main()