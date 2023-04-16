FROM python:3.10.0

WORKDIR /usr/src/app

# psycopg2 dependencies
RUN apt-get install -y libpq-dev python3-dev

COPY django_experiment/requirements/base.txt ./
COPY django_experiment/requirements/local.txt ./

RUN pip install --upgrade pip

# https://pythonspeed.com/articles/docker-cache-pip-downloads/
RUN --mount=type=cache,target=/root/.cache \
    pip install -r base.txt
RUN --mount=type=cache,target=/root/.cache \
    pip install -r local.txt

ENV DJANGO_SETTINGS_MODULE=config.settings.local