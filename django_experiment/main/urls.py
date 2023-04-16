from django.urls import path
from .views import MyModelList, MyModelDetail

urlpatterns = [
    path("api/", MyModelList.as_view(), name="my_model_list"),
    path("api/<int:pk>/", MyModelDetail.as_view(), name="my_model_detail"),
]
