from django.conf.urls import url, include
from allauth.account import views
from allauth.socialaccount import views as social_views
from django.conf import settings


app_name = "cklauth"


urlpatterns = [
    # Auth API endpoints
    url(r"^api/v1/", include("cklauth.api.v1.urls")),
    # Auth Template endpoints
    # Account
    url(r"^auth/signup/$", views.signup, name="account_signup"),
    url(r"^auth/login/$", views.login, name="account_login"),
    url(r"^auth/logout/$", views.logout, name="account_logout"),
    url(
        r"^auth/password/change/$",
        views.password_change,
        name="account_change_password",
    ),
    url(r"^auth/password/set/$", views.password_set, name="account_set_password"),
    url(r"^auth/inactive/$", views.account_inactive, name="account_inactive"),
    # E-mail
    url(r"^auth/email/$", views.email, name="account_email"),
    url(
        r"^auth/confirm-email/$",
        views.email_verification_sent,
        name="account_email_verification_sent",
    ),
    url(
        r"^auth/confirm-email/(?P<key>[-:\w]+)/$",
        views.confirm_email,
        name="account_confirm_email",
    ),
    # Password reset
    url(r"^auth/password/reset/$", views.password_reset, name="account_reset_password"),
    url(
        r"^auth/password/reset/done/$",
        views.password_reset_done,
        name="account_reset_password_done",
    ),
    url(
        r"^auth/password/reset/key/(?P<uidb36>[0-9A-Za-z]+)-(?P<key>.+)/$",
        views.password_reset_from_key,
        name="account_reset_password_from_key",
    ),
    url(
        r"^auth/password/reset/key/done/$",
        views.password_reset_from_key_done,
        name="account_reset_password_from_key_done",
    ),
]

if "allauth.socialaccount" in settings.INSTALLED_APPS:
    urlpatterns += [
        url(
            "^auth/social/login/cancelled/$",
            social_views.login_cancelled,
            name="socialaccount_login_cancelled",
        ),
        url(
            "^auth/social/login/error/$",
            social_views.login_error,
            name="socialaccount_login_error",
        ),
        url("^auth/social/signup/$", social_views.signup, name="socialaccount_signup"),
        url(
            "^auth/social/connections/$",
            social_views.connections,
            name="socialaccount_connections",
        ),
        # Facebook Social Auth endpoints
        url(r"^auth/social/", include("allauth.socialaccount.providers.facebook.urls")),
    ]
