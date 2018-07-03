from django.conf.urls import url, include

app_name = 'billings'


urlpatterns = [
    # Auth API endpoints
    url(r'^api/v1/billing/', include('billings.api.v1.urls')),
]
