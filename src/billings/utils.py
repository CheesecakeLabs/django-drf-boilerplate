from django.conf import settings

import stripe

stripe.api_key = settings.STRIPE_SECRET_KEY
User = settings.AUTH_USER_MODEL


def create_customer(email):
    customer = stripe.Customer.create(
        email=email,
        description="Customer for {}".format(email),
    )
    return customer


def create_card(customer_id, token):
    customer = stripe.Customer.retrieve(customer_id)
    card = customer.sources.create(source=token)
    return card


def create_charge(billing_profile, amount, order_id, currency, card_obj):
    charge = stripe.Charge.create(
        amount=amount,
        currency=currency,
        customer=billing_profile.customer_id,
        source=card_obj,
        metadata={"order_id": order_id},
    )
    return charge
