from django.http import HttpResponse
from rest_framework import generics
from .models import MyModel
from .serializers import MyModelSerializer


class MyModelList(generics.ListCreateAPIView):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer


class MyModelDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = MyModel.objects.all()
    serializer_class = MyModelSerializer
