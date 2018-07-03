from django.conf.urls import url
from .views import (
    BillingProfileListAPIView,
    BillingProfileCreateAPIView,
    BillingProfileDetailAPIView,


    CardListAPIView,
    CardDetailAPIView,
    CardCreateView,

    ChargeCreateView,
    ChargeListView,
)

urlpatterns = [
    url(r'^profile/$', BillingProfileListAPIView.as_view(), name='billing_profile'),
    url(r'^profile/create/$', BillingProfileCreateAPIView.as_view(), name='billing_profile_create'),
    url(r'^profile/(?P<pk>\d+)/$', BillingProfileDetailAPIView.as_view(), name='billing_profile_detail'),
]
