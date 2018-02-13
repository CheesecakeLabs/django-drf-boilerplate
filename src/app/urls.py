from django.contrib import admin
from django.urls import include, path


urlpatterns = [
    path(r'^admin/', admin.site.urls),

    # Enables the DRF browsable API page
    path(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),

    path(r'', include('cklauth.urls', namespace='cklauth')),
]
