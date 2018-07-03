from django.conf import settings
from django.db import models
from django.db.models.signals import pre_save, post_save

from .utils import create_customer, create_card, create_charge

User = settings.AUTH_USER_MODEL


class BillingProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    email = models.EmailField()
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    customer_id = models.CharField(max_length=120, null=True, blank=True)

    def __str__(self):
        return self.email

    def get_cards(self):
        return self.card_set.all()

    def charge(self, amount, order_id, currency, card=None):
        return Charge.objects.do(self, amount, order_id, currency, card)


def billing_profile_created_receiver(sender, instance, *args, **kwargs):
    if not instance.customer_id and instance.email:
        customer = create_customer(instance.email)
        instance.customer_id = customer.id


pre_save.connect(billing_profile_created_receiver, sender=BillingProfile)


def user_created_receiver(sender, instance, created, *args, **kwargs):
    if created and instance.email:
        BillingProfile.objects.get_or_create(
            user=instance,
            email=instance.email
        )


post_save.connect(user_created_receiver, sender=User)


class CardManager(models.Manager):
    def all(self, *args, **kwargs):
        return self.get_queryset().filter(active=True)

    def add_new(self, billing_profile, token):
        if token:
            billing_profile = BillingProfile.objects.get(pk=billing_profile)
            card = create_card(billing_profile.customer_id, token)
            new_card = self.model(
                billing_profile=billing_profile,
                stripe_id=card.id,
                brand=card.brand,
                country=card.country,
                exp_month=card.exp_month,
                exp_year=card.exp_year,
                last4=card.last4
            )
            new_card.save()
            return new_card
        return None


class Card(models.Model):
    billing_profile = models.ForeignKey(
        BillingProfile,
        on_delete=models.CASCADE
    )
    stripe_id = models.CharField(max_length=120)
    brand = models.CharField(max_length=120, null=True, blank=True)
    country = models.CharField(max_length=120, null=True, blank=True)
    exp_month = models.IntegerField(null=True, blank=True)
    exp_year = models.IntegerField(null=True, blank=True)
    last4 = models.CharField(max_length=4, null=True, blank=True)
    active = models.BooleanField(default=True)
    default = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    objects = CardManager()

    def __str__(self):
        return "{} {}".format(self.brand, self.last4)


def new_card_post_save_receiver(sender, instance, created, *args, **kwargs):
    if instance.default:
        billing_profile = instance.billing_profile
        qs = Card.objects.filter(
            billing_profile=billing_profile
        ).exclude(pk=instance.pk)

        qs.update(default=False)


post_save.connect(new_card_post_save_receiver, sender=Card)


class ChargeManager(models.Manager):
    def do(self, billing_profile, amount, order_id, currency, card=None):
        card_obj = Card.objects.get(pk=card)
        billing_profile = BillingProfile.objects.get(pk=billing_profile)

        if card_obj is None:
            cards = billing_profile.card_set.filter(default=True)
            if cards.exists():
                card_obj = cards.first()
        if card_obj is None:
            return False, "No, cards available"

        charge = create_charge(
            billing_profile,
            amount,
            order_id,
            currency,
            card_obj
        )
        new_charge_obj = self.model(
            billing_profile=billing_profile,
            stripe_id=charge.id,
            currency=currency,
            source=card_obj,
            captured=charge.captured,
            paid=charge.paid,
            amount=charge.amount,
            refunded=charge.refunded,
            amount_refunded=charge.amount_refunded,
            outcome=charge.outcome,
            outcome_type=charge.outcome['type'],
            seller_message=charge.outcome.get('seller_message'),
            risk_level=charge.outcome.get('risk_level'),
            order_id=order_id,
            failure_code=charge.failure_code,
            failure_message=charge.failure_message,
        )
        new_charge_obj.save()
        return new_charge_obj.paid, new_charge_obj.seller_message


class Charge(models.Model):
    billing_profile = models.ForeignKey(
        BillingProfile,
        on_delete=models.CASCADE
    )
    stripe_id = models.CharField(max_length=120)

    currency = models.CharField(max_length=3)
    source = models.CharField(max_length=120)

    captured = models.CharField(max_length=120, null=True, blank=True)
    paid = models.BooleanField(default=False)
    amount = models.IntegerField(null=True, blank=True)
    refunded = models.BooleanField(default=False)
    amount_refunded = models.IntegerField(null=True, blank=True)

    outcome = models.TextField(null=True, blank=True)
    outcome_type = models.CharField(max_length=120, null=True, blank=True)
    seller_message = models.CharField(max_length=120, null=True, blank=True)
    risk_level = models.CharField(max_length=120, null=True, blank=True)

    order_id = models.CharField(max_length=120, null=True, blank=True)

    failure_code = models.CharField(max_length=120, null=True, blank=True)
    failure_message = models.CharField(max_length=120, null=True, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)

    objects = ChargeManager()
