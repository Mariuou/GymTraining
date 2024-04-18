from django.urls import path,include
from rest_framework import routers
from api import views 
# from .views import sucursalviewset, miembroviewset, miembros_adeudosserializer, mantenimientoviewset, prestamoviewset, consumibleviewset, equipo_existenciaviewset, equipoviewset

router = routers.DefaultRouter()
router.register(r'rutinas', views.rutinas_viewset)
router.register(r'ejercicios', views.ejercicios_viewset)
router.register(r'rutinas_ejercicios', views.ruitnas_ejercicios_viewset)
router.register(r'programas_saludables', views.programa_saludable_viewset)
router.register(r'detalle_ps', views.detalle_ps_viewset)
router.register(r'sesiones_rutinas', views.sesiones_rutinas_viewset)

urlpatterns = [
	path('api/v1',include(router.urls))
]
