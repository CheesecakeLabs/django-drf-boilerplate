from rest_framework import serializers

from billings.models import BillingProfile, Card


class BillingProfileSerializer(serializers.ModelSerializer):
    lookup_field = 'pk'

    class Meta:
        model = BillingProfile
        fields = (
            'id',
            'email',
            'active',
        )


class CardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Card
        fields = (
            'id',
            'billing_profile',
        )


class CardCreateSerializer(serializers.Serializer):
    token = serializers.CharField()
    billing_profile = serializers.IntegerField()

    class Meta:
        fields = (
            'token',
            'billing_profile',
        )

    def create(self, validated_data):
        card = Card.objects.add_new(
            billing_profile=validated_data['billing_profile'],
            token=validated_data['token']
        )
        return validated_data
