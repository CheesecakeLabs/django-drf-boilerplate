from django.test import override_settings, modify_settings
from django.urls import reverse


@override_settings(ALLOWED_HOSTS=[], DEBUG=True)
def test_http_status_code_200_when_debug_true_and_empty_allowed_hosts(client):
    url = reverse("health_check")
    response = client.get(url)
    assert response.status_code == 200
    response = client.get(url, HTTP_HOST="barfoo.com")
    assert response.status_code == 200


@override_settings(ALLOWED_HOSTS=["*", "foobar.com"], DEBUG=False)
def test_http_status_code_200_when_debug_false_and_given_allowed_hosts(client):
    url = reverse("health_check")
    response = client.get(url)
    assert response.status_code == 200
    response = client.get(url, HTTP_HOST="barfoo.com")
    assert response.status_code == 200


@override_settings(
    ALLOWED_HOSTS=[],
    DEBUG=True,
)
@modify_settings(
    MIDDLEWARE={"remove": ["app.middleware.HealthCheckMiddleware"]},
)
def test_status_code_200_when_removing_middleware_and_debug_true_and_empty_allowed_hosts(
    client,
):
    url = reverse("health_check")
    response = client.get(url, HTTP_HOST="localhost")
    assert response.status_code == 200


@override_settings(
    ALLOWED_HOSTS=["foobar.com"],
    DEBUG=True,
)
@modify_settings(
    MIDDLEWARE={"remove": ["app.middleware.HealthCheckMiddleware"]},
)
def test_status_code_400_when_removing_middleware_and_debug_true_and_given_allowed_hosts(
    client,
):
    url = reverse("health_check")
    response = client.get(url, HTTP_HOST="barfoo.com")
    assert response.status_code == 400


@override_settings(
    ALLOWED_HOSTS=["foobar.com"],
    DEBUG=False,
)
@modify_settings(
    MIDDLEWARE={"remove": ["app.middleware.HealthCheckMiddleware"]},
)
def test_status_code_400_when_removing_middleware_and_debug_false_and_given_allowed_hosts(
    client,
):
    url = reverse("health_check")
    response = client.get(url, HTTP_HOST="barfoo.com")
    assert response.status_code == 400
