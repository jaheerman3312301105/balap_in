"""
ASGI config for balap_in_project project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/5.1/howto/deployment/asgi/
"""

import os
from django.core.asgi import get_asgi_application
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from django.urls import re_path
from . import consumer

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'balap_in_project.settings')

application = ProtocolTypeRouter({
    "http": get_asgi_application(),  # Handle HTTP requests
    "websocket": AuthMiddlewareStack(  # Handle WebSocket requests
        URLRouter(
            [
                re_path(r"ws/notifications/", consumer.NotificationConsumer.as_asgi()),
            ]
        )
    ),
})

