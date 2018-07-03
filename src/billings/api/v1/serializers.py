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


class ChargeCreateSerializer(serializers.Serializer):
    billing_profile = serializers.IntegerField()
    amount = serializers.CharField()
    order_id = serializers.CharField()
    currency = serializers.CharField()
    card = serializers.CharField()

    class Meta:
        fields = (
            'billing_profile',
            'amount',
            'order_id',
            'currency',
            'card',
        )

    def create(self, validated_data):
        charge = Charge.objects.do(
            billing_profile=validated_data['billing_profile'],
            amount=validated_data['amount'],
            order_id=validated_data['order_id'],
            currency=validated_data['currency'],
            card=validated_data['card']
        )
        return validated_data


class ChargeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Charge
        fields = (
            'billing_profile',
            'stripe_id',
            'currency',
            'source',
            'captured',
            'paid',
            'amount',
            'refunded',
            'amount_refunded',
            'outcome',
            'outcome_type',
            'seller_message',
            'risk_level',
            'order_id',
            'failure_code',
            'failure_message',
            'created_at',
        )
