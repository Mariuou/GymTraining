from rest_framework import serializers
from .models import *

class rutinasserializer(serializers.ModelSerializer):
	class Meta:
		model = rutinas
		fields = '__all__'

class ejerciciosserializer(serializers.ModelSerializer):
	class Meta:
		model = ejercicios
		fields = '__all__'
  
class rutinas_ejerciciosserializer(serializers.ModelSerializer):
	class Meta:
		model = rutinas_ejercicios
		fields = '__all__'
  
class programa_saludablesserializer(serializers.ModelSerializer):
	class Meta:
		model = programas_saludables
		fields = '__all__'
  
class detalle_psserializer(serializers.ModelSerializer):
	class Meta:
		model = detalles_programas_saludables
		fields = '__all__'
  
class sesiones_rutinasserializer(serializers.ModelSerializer):
	class Meta:
		model = sesiones_rutinas
		fields = '__all__'
  