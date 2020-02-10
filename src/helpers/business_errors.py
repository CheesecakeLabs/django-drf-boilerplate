from django.core.exceptions import ValidationError
from rest_framework.exceptions import APIException
from rest_framework.status import HTTP_422_UNPROCESSABLE_ENTITY


EXAMPLE_ERROR = 1


class BusinessException(APIException, ValidationError):
    status_code = HTTP_422_UNPROCESSABLE_ENTITY
    default_detail = "unmapped_error"
    default_code = 0

    BUSINESS_ERRORS = {
        EXAMPLE_ERROR: "example_error",
    }

    def __init__(self, error_code: int):
        try:
            detail = self.BUSINESS_ERRORS[error_code]
        except KeyError:
            error_code = self.default_code
            detail = self.default_detail

        # Django Rest Framework
        self.detail = {"code": error_code, "detail": detail}

        # Django
        self.message = f"Business error: {detail}"
        self.code = error_code
        self.params = None
        self.error_list = [self]
