from selenium.webdriver.common.by import By


def test_header(site):
    site.get(f'{site.base_url}')

    assert "Flask Example" in site.title
