# settings/production.py

from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

ALLOWED_HOSTS = ["your-domain.com"]

# Database
# https://docs.djangoproject.com/en/3.2/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "your-db-name",
        "USER": "your-db-user",
        "PASSWORD": "your-db-password",
        "HOST": "your-db-host",
        "PORT": "your-db-port",
    }
}

raise Exception("This isn't configured, yet")
