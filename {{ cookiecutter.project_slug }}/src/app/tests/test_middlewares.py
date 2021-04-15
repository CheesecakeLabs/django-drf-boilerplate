from app.middleware import AppMiddleware
import pytest


def test_middleware_without___call___not_implemented():
    class Test(AppMiddleware):
        pass

    with pytest.raises(NotImplementedError):
        Test(None)(None)


def test_middleware_with___call___implemented():
    class Test(AppMiddleware):
        def __call__(self, request):
            pass

    Test(None)(None)
