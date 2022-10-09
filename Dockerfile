FROM python:3.9

# install chrome driver
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list.d/google-chrome.list
RUN    apt-get update -qqy
RUN    # apt-utils is required.
RUN    apt-get -qqy install apt-utils
RUN    apt-get -qqy install google-chrome-stable
RUN    CHROME_VERSION=$(google-chrome-stable --version)
RUN    CHROME_FULL_VERSION=${CHROME_VERSION%%.*}
RUN    CHROME_MAJOR_VERSION=${CHROME_FULL_VERSION//[!0-9]}
RUN    rm /etc/apt/sources.list.d/google-chrome.list
RUN    export CHROMEDRIVER_VERSION=`curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION%%.*}`
RUN    curl -L -O "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip"
RUN    unzip chromedriver_linux64.zip && chmod +x chromedriver && mv chromedriver /usr/local/bin
RUN    chromedriver --version

# install nbdiff-web-exporter
RUN pip install git+https://github.com/kuromt/nbdiff-web-exporter

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]