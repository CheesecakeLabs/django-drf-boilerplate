from django.contrib import admin
from django.urls import include, path
from django.conf import settings

{% if cookiecutter.enable_health_check == "y" %}
from helpers.health_check import health_check
{% endif %}

urlpatterns = [
    path("admin/", admin.site.urls),
    # Enables the DRF browsable API page
    path("api-auth/", include("rest_framework.urls", namespace="rest_framework")),
    {% if cookiecutter.enable_health_check == "y" %}
    path("health_check/", health_check, name="health_check"),
    {% endif %}
]

if settings.ENVIRONMENT == "development":
    import debug_toolbar

    urlpatterns = [path("__debug__/", include(debug_toolbar.urls))] + urlpatterns
