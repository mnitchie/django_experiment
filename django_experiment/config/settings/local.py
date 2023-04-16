# settings/local.py

from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True
SECRET_KEY = SECRET_KEY or "c-61i@)_b36jt&69%4xc%nc6z4&60b=+mxl4ip1!!zyst0l!^&"  # noqa F401

INSTALLED_APPS += [
    "debug_toolbar",
]

MIDDLEWARE += [
    "debug_toolbar.middleware.DebugToolbarMiddleware",
]

# settings.py
DEBUG_TOOLBAR_CONFIG = {
    "SHOW_TOOLBAR_CALLBACK": lambda request: DEBUG,
}


INTERNAL_IPS = ["127.0.0.1", "localhost"]

# ------------------------------------------------------------------------------
# DATABASES
# ------------------------------------------------------------------------------
# Disable SSL
DATABASES[DATABASE_NAME_DEFAULT]["OPTIONS"] = {}
