from django.contrib import admin
from django.urls import include, path


urlpatterns = [
    path("admin/", admin.site.urls),
    # Enables the DRF browsable API page
    path("api-auth/", include("rest_framework.urls", namespace="rest_framework")),
]
