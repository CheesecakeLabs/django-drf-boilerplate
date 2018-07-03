from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView
from .serializers import BillingProfileSerializer
from billings.models import BillingProfile


class BillingProfileListAPIView(ListAPIView):
    queryset = BillingProfile.objects.all()
    serializer_class = BillingProfileSerializer


class BillingProfileCreateAPIView(CreateAPIView):
    queryset = BillingProfile.objects.all()
    serializer_class = BillingProfileSerializer


class BillingProfileDetailAPIView(RetrieveAPIView):
    queryset = BillingProfile.objects.all()
    serializer_class = BillingProfileSerializer
