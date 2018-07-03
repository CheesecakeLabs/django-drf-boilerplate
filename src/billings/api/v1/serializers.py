from rest_framework import serializers

from billings.models import BillingProfile, Card, Charge


class BillingProfileSerializer(serializers.ModelSerializer):
    lookup_field = 'pk'

    class Meta:
        model = BillingProfile
        fields = (
            'id',
            'email',
            'active',
        )
