"""
WSGI config for taytay project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.8/howto/deployment/wsgi/
"""

import os
try:
    import dotenv
except ImportError:
    dotenv = None

from django.core.wsgi import get_wsgi_application

from whitenoise.django import DjangoWhiteNoise


if dotenv:
    dotenv.read_dotenv()
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'taytay.settings')
application = DjangoWhiteNoise(get_wsgi_application())
