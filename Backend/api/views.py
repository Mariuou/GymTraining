from django.shortcuts import render
from rest_framework import viewsets
from .serializer import *

class rutinas_viewset(viewsets.ModelViewSet):
	queryset = rutinas.objects.all()
	serializer_class = rutinasserializer
 
class ejercicios_viewset(viewsets.ModelViewSet):
	queryset = ejercicios.objects.all()
	serializer_class = ejerciciosserializer
 
class ruitnas_ejercicios_viewset(viewsets.ModelViewSet):
	queryset = rutinas_ejercicios.objects.all()
	serializer_class = rutinas_ejerciciosserializer
 
class programa_saludable_viewset(viewsets.ModelViewSet):
	queryset = programas_saludables.objects.all()
	serializer_class = programa_saludablesserializer
 
class detalle_ps_viewset(viewsets.ModelViewSet):
	queryset = detalles_programas_saludables.objects.all()
	serializer_class = detalle_psserializer
 
class sesiones_rutinas_viewset(viewsets.ModelViewSet):
	queryset = sesiones_rutinas.objects.all()
	serializer_class = sesiones_rutinasserializer

# Create your views here.
