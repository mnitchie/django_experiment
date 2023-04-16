FROM python:3.10.0

WORKDIR /usr/src/app

COPY django_experiment/requirements/base.txt ./
COPY django_experiment/requirements/local.txt ./

RUN pip install --upgrade pip

# https://pythonspeed.com/articles/docker-cache-pip-downloads/
RUN --mount=type=cache,target=/root/.cache \
    pip install -r base.txt
RUN --mount=type=cache,target=/root/.cache \
    pip install -r local.txt

ENV DJANGO_SETTINGS_MODULE=config.settings.local