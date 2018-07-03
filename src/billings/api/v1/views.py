from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView
from .serializers import BillingProfileSerializer, CardSerializer, CardCreateSerializer
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


class CardListAPIView(ListAPIView):
    queryset = Card.objects.all()
    serializer_class = CardSerializer


class CardDetailAPIView(RetrieveAPIView):
    queryset = Card.objects.all()
    serializer_class = CardSerializer


class CardCreateView(CreateAPIView):
    queryset = Card.objects.all()
    serializer_class = CardCreateSerializer

# class CardCreateView(APIView):
#     queryset = Card.objects.all()
#
#     def post(self, request, format=None):
#         serializer = CardCreateSerializer(data=request.data)
#         serializer.is_valid(raise_exception=True)
#         data = serializer.data
#         try:
#             card = Card.objects.add_new(data)
#             return Response({"stripe_id": card.stripe_id, "id": card.pk}, status=status.HTTP_201_CREATED)
#         except Exception as e:
#             return Response(e.error, status=status.HTTP_400_BAD_REQUEST)
