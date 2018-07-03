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
    url(r'^cards/$', CardListAPIView.as_view(), name='cards_list'),
    url(r'^cards/create/$', CardCreateView.as_view(), name='cards_create'),
    url(r'^cards/(?P<pk>\d+)/$', CardDetailAPIView.as_view(), name='cards_detail'),

]
