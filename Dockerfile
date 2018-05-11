#
#  Heading Party
#    Dockerfile for Django web server.
#

# Base image.
FROM python:3.4

# Environment variable.
ENV REMOTE ${remote:-origin}
ENV BRANCH ${branch:-master}

# Load code and Install package.
RUN cd /root && \
	git clone https://www.github.com/heading-party/web-server.git && \
	cd /root/web-server && \
	pip install -r requirements.txt

# Set working dir.
WORKDIR /root/web-server

# Update code and Run server.
CMD	git checkout ${BRANCH} && \
	git pull ${REMOTE} ${BRANCH} && \
	pip install -r requirements.txt && \
	python src/manage.py migrate && \
	python src/manage.py runserver 0.0.0.0:3000

# Expose port.
EXPOSE 3000
