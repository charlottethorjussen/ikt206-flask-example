import os
import time

import pytest
import docker
from selenium import webdriver

@pytest.fixture
def site(request):
    driver = None
    chrome = None
    website = None

    try:
        client = docker.from_env()
        assert client, 'Failed to get Docker client'

        chrome = client.containers.run('selenium/standalone-chrome',
                                       ports={'4444/tcp': 4444},
                                       shm_size='2g', detach=True, init=True, auto_remove=True)
        assert chrome, 'Failed to start Chrome container'

        website = client.containers.run('registry.internal.uia.no/ikt206-g-23v-devops/labgroup30/exam:test',
                                        shm_size='2g', detach=True, init=True, auto_remove=True)
        assert website, 'Failed to start website container'

        website.reload()
        website_ip = website.attrs['NetworkSettings']['IPAddress']

        time.sleep(5)

        if os.getenv('CI') == 'true':
            chrome.reload()
            chrome_ip = website.attrs['NetworkSettings']['IPAddress']
            chrome_url = f'http://{chrome_ip}:4444/wd/hub'
        else:
            chrome_url = 'http://localhost:4444/wd/hub'
            
        driver = webdriver.Remote(
            chrome_url, webdriver.DesiredCapabilities.CHROME)
        assert driver, f'Failed to connect to Selenium. URL: {chrome_url}'

        driver.base_url = f'http://{website_ip}'

        yield driver
    finally:
        if driver:
            driver.close()

        if chrome:
            chrome.remove(force=True)

        if website:
            website.remove(force=True)
