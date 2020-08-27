from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response


@csrf_exempt
@api_view(("GET",))
@permission_classes((AllowAny,))
def health_check(_request):
    return Response(status=status.HTTP_200_OK)
