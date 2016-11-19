#!/usr/bin/env python
import os
import sys

try:
    import dotenv
except ImportError:
    dotenv = None

if __name__ == '__main__':
    if dotenv:
        dotenv.dotenv.read_dotenv()
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'taytay.settings')

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
