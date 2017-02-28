from django.conf.urls import url, include
from django.contrib import admin

urlpatterns = [
    url(r'^admin/', admin.site.urls),

    # Enables the DRF browsable API page
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),

    url(r'', include('cklauth.urls')),
]
