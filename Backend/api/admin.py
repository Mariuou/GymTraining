from django.contrib import admin
from .models import *
# Register your models here.

admin.site.register(rutinas)
admin.site.register(ejercicios)
admin.site.register(rutinas_ejercicios)
admin.site.register(programas_saludables)
admin.site.register(detalles_programas_saludables)
admin.site.register(sesiones_rutinas)
