FROM python:3.10

# ARG GIT_COMMIT_HASH
# ARG BUILD_ID

# Don't generate .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
# Proper logging
ENV PYTHONUNBUFFERED=1

WORKDIR /usr/src/app
COPY . /usr/src/app

# psycopg2 dependencies
RUN apt-get update
RUN apt-get install -y libpq-dev python3-dev

# https://pythonspeed.com/articles/docker-cache-pip-downloads/
RUN --mount=type=cache,target=/root/.cache \
    pip install --upgrade pip==21.0.1

RUN --mount=type=cache,target=/root/.cache \
    pip install -r requirements/base.txt

# ENV GIT_COMMIT_HASH=$GIT_COMMIT_HASH
# ENV BUILD_ID=$BUILD_ID
