from django.conf import settings
from abc import ABC


class AppMiddleware(ABC):
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        raise NotImplementedError("Subclass must override __call__(self, request)")


{%- if cookiecutter.enable_health_check == "y" %}
class HealthCheckMiddleware(AppMiddleware):
    def __call__(self, request):
        if request.path.replace("/", "") == "health_check":
            request.META["HTTP_HOST"] = (
                settings.ALLOWED_HOSTS[0]
                if settings.ALLOWED_HOSTS and settings.ALLOWED_HOSTS[0] != "*"
                else "localhost"
            )
        return self.get_response(request){%- endif %}
