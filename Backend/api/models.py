from django.db import models

class rutinas(models.Model):
    
    instructor_id = models.IntegerField()
    usuario_id = models.IntegerField()
    fecha_asignacion = models.DateTimeField()
    fecha_termino = models.DateTimeField()
    tiempo_aproximado = models.DateField()
    estatus = models.CharField(max_length=50)
    resultados_esperados = models.TextField()
    class Meta:
        db_table = 'rutinas'

class ejercicios(models.Model):
  
    nombre_formal = models.CharField(max_length=80)
    nombre_comun = models.CharField(max_length=50)
    descripcion = models.TextField()
    tipo = models.CharField(max_length=50)
    video_ejemplo = models.CharField(max_length=100)
    consideraciones = models.TextField()
    dificultad = models.CharField(max_length=50)
    class Meta:
        db_table = 'ejercicios'
    
class rutinas_ejercicios(models.Model):
    ejercicio_id = models.IntegerField()
    rutina_id = models.IntegerField()
    repeticiones = models.IntegerField()
    tiempo = models.DateField()
    estatus = models.BinaryField()
    class Meta:
        db_table = 'rutinas_ejercicios'

class programas_saludables(models.Model):
   
    nombre = models.CharField(max_length=250)
    usuario_id = models.IntegerField()
    instructor = models.IntegerField()
    fecha_creacion = models.DateTimeField()
    estatus = models.CharField(max_length=50)
    duracion = models.CharField(max_length=80)
    porcentaje_avance = models.DecimalField(max_digits=5, decimal_places=2)
    fecha_ultima_actualizacion = models.DateTimeField()
    class Meta:
        db_table = 'programas_saludables'

class detalles_programas_saludables(models.Model):
   
    programa_id = models.IntegerField()
    rutina_id = models.IntegerField()
    dieta_id = models.IntegerField()
    fecha_inicio = models.DateTimeField()
    fecha_fin = models.DateTimeField()
    estatus = models.CharField(max_length=50)
    class Meta:
        db_table = 'detalles_programas_saludables'

class sesiones_rutinas(models.Model):
    id_sesion = models.IntegerField()
    id_rutina = models.IntegerField()
    id_instructor = models.IntegerField()
    asistencia = models.BinaryField()
    fecha_sesion = models.DateTimeField()
    observaciones = models.TextField()
    class Meta:
        db_table = 'sesiones_rutinas'