from django.contrib import admin
from django.urls import include, path
from django.conf import settings

from helpers.health_check import health_check

urlpatterns = [
    path("admin/", admin.site.urls),
    # Enables the DRF browsable API page
    path("api-auth/", include("rest_framework.urls", namespace="rest_framework")),
    path("health_check/", health_check, name="health_check"),
]

if settings.ENVIRONMENT == "development":
    import debug_toolbar

    urlpatterns = [path("__debug__/", include(debug_toolbar.urls))] + urlpatterns
