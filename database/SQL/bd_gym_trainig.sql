CREATE DATABASE  IF NOT EXISTS `bd_gimnasio_210115` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_gimnasio_210115`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_gimnasio_210115
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(80) NOT NULL,
  `Descripcion` text,
  `Responsable_ID` int DEFAULT NULL,
  `Sucursal_ID` int unsigned DEFAULT NULL,
  `Total_Equipos` int unsigned NOT NULL DEFAULT '0',
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_empleado_3` (`Responsable_ID`),
  KEY `fk_sucursales_2` (`Sucursal_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Atencion a clientes',NULL,2,1,0,_binary ''),(2,'Control de Inventarios',NULL,45,1,0,_binary ''),(3,'Gerencia',NULL,45,1,0,_binary ''),(4,'Marketing',NULL,2,1,0,_binary ''),(5,'Membresias',NULL,2,1,0,_binary ''),(6,'Nutricion',NULL,2,2,0,_binary ''),(7,'Recursos Humanos',NULL,45,2,0,_binary ''),(8,'Recursus Materiales',NULL,2,2,0,_binary ''),(9,'Training',NULL,45,2,0,_binary '');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_INSERT` AFTER INSERT ON `areas` FOR EACH ROW BEGIN
    -- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_responsable varchar(60) default null;
    DECLARE v_nombre_sucursal varchar(60) default null;

    -- Iniciación de las variables
    -- El estatus de la sucursal se almacena en un dato del tipo BIT, por
    -- cuestiones de memoria, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con la redacción de los eventos
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.responsable_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.responsable_id);
    else
        SET v_nombre_responsable = "Sin responsable asignado";
    end if;

    if new.sucursal_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    else
        SET v_nombre_sucursal = "Sin sucursal asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "areas",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "DESCRIPCIÓN = ", NEW.descripcion,
        "RESPONSABLE ID = ", v_nombre_responsable,
        "SUCURSAL ID = ",  v_nombre_sucursal,
        "TOTAL EQUIPOS = ", NEW.total_equipos, 
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_UPDATE` AFTER UPDATE ON `areas` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_sucursal VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_sucursal2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    -- El estatus de la sucursal se almacena en un dato del tipo BIT, por
    -- cuestiones de memoria, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con la redacción de los eventos. 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.responsable_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado responsable debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.responsable_id);
    ELSE
		SET v_nombre_responsable = "Sin responsable asignado.";
    END IF;
    
    IF OLD.responsable_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado responsable debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_responsable2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.responsable_id);
    ELSE
		SET v_nombre_responsable2 = "Sin responsable asignado.";
    END IF;

    IF NEW.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    ELSE
		SET v_nombre_sucursal = "Sin sucursal asignada.";
    END IF;

    IF OLD.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal2 = (SELECT nombre FROM sucursales WHERE id = OLD.sucursal_id);
    ELSE
		SET v_nombre_sucursal2 = "Sin sucursal asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "areas",
        CONCAT_WS(" ","Se han actualizado los datos del área con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "RESPONSABLE = ", v_nombre_responsable2, "cambio a", v_nombre_responsable,
        "SUCURSAL ID =",v_nombre_sucursal2,"cambio a", v_nombre_sucursal,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `areas_AFTER_DELETE` AFTER DELETE ON `areas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "area",
        CONCAT_WS(" ","Se ha eliminado una AREA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(50) NOT NULL,
  `Operacion` enum('Create','Read','Update','Delete') NOT NULL,
  `Tabla` varchar(50) NOT NULL,
  `Descripcion` text NOT NULL,
  `Fecha_Hora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=98566 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_pedidos`
--

DROP TABLE IF EXISTS `detalles_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_pedidos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Pedido_ID` int unsigned NOT NULL,
  `Producto_ID` int unsigned NOT NULL,
  `Cantidad` int NOT NULL,
  `Total_Parcial` decimal(6,2) NOT NULL,
  `Fecha_Registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Entrega` datetime DEFAULT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_pedido_1` (`Pedido_ID`),
  KEY `fk_producto_1` (`Producto_ID`),
  CONSTRAINT `fk_pedido_1` FOREIGN KEY (`Pedido_ID`) REFERENCES `pedidos` (`ID`),
  CONSTRAINT `fk_producto_1` FOREIGN KEY (`Producto_ID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_pedidos`
--

LOCK TABLES `detalles_pedidos` WRITE;
/*!40000 ALTER TABLE `detalles_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalles_pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_INSERT` AFTER INSERT ON `detalles_pedidos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_pedido varchar(60) default null;
    DECLARE v_nombre_producto varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.pedido_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_pedido = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = NEW.pedido_id);
    else
        SET v_nombre_pedido = "Sin pedido asignado";
    end if;

    if new.producto_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = NEW.producto_id);
    else
        SET v_nombre_producto = "Sin producto asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_pedidos",
        CONCAT_WS(" ","Se ha insertado una nuevo DETALLE_PEDIDO con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "PEDIDO ID = ", v_nombre_pedido,
        "PRODUCTO ID = ",  v_nombre_producto,
        "CANTIDAD = ", NEW.cantidad,
		"TOTAL PARCIAL = ", NEW.total_parcial,
        "FECHA REGISTRO = ", NEW.fecha_registro,
        "FECHA ENTREGA = ", NEW.fecha_entrega,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_UPDATE` AFTER UPDATE ON `detalles_pedidos` FOR EACH ROW BEGIN
		 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_pedido VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_pedido2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_producto VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_producto2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.pedido_id IS NOT NULL THEN 
		-- En caso de tener el id del pedido
        set v_nombre_pedido = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = NEW.pedido_id);
    ELSE
		SET v_nombre_pedido = "Sin pedido asignado.";
    END IF;
    
    IF OLD.pedido_id IS NOT NULL THEN 
		-- En caso de tener el id del pedido
        set v_nombre_pedido2 = (SELECT CONCAT_WS(" ", p.usuario_id, p.total, p.fecha_registro) FROM pedidos p WHERE id = OLD.pedido_id);
    ELSE
		SET v_nombre_pedido2 = "Sin pedido asignado.";
    END IF;

    IF NEW.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = NEW.producto_id);
    ELSE
		SET v_nombre_producto = "Sin producto asignado.";
    END IF;

    IF OLD.producto_id IS NOT NULL THEN 
		-- En caso de tener el id del producto
        SET v_nombre_producto = (SELECT concat_ws(" ", p.nombre, p.marca) FROM productos WHERE id = OLD.producto_id);
    ELSE
		SET v_nombre_producto2 = "Sin producto asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_pedidos",
        CONCAT_WS(" ","Se han actualizado los datos del DETALLES_PEDIDOS con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "PEDIDO ID = ", v_nombre_pedido2, " cambio a ", v_nombre_pedido,
        "PRODUCTO ID =",v_nombre_producto2," cambio a ", v_nombre_producto,
        "CANTIDAD = ", OLD.cantidad, "cambio a ", NEW.cantidad,
        "TOTAL PARCIAL = ", OLD.total_parcial, " cambio a ", NEW.total_parcial,
        "FECHA REGISTRO = ", OLD.fecha_registro, " cambio a ", NEW.fecha_registro,
        "RECHAENTREGA = ", OLD.fecha_entrega, " cambio a ", NEW.fecha_entrega,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_pedidos_AFTER_DELETE` AFTER DELETE ON `detalles_pedidos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "detalles_pedidos",
        CONCAT_WS(" ","Se ha eliminado una relación DETALLES_PEDIDOS con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalles_programas_saludables`
--

DROP TABLE IF EXISTS `detalles_programas_saludables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_programas_saludables` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Programa_ID` int unsigned DEFAULT NULL,
  `Rutina_ID` int unsigned DEFAULT NULL,
  `Dieta_ID` int unsigned DEFAULT NULL,
  `Fecha_Inicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Fin` datetime NOT NULL,
  `Estatus` enum('Programada','Iniciada','Seguimiento','Suspendida','Finalizada') NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_programa_1` (`Programa_ID`),
  KEY `fk_rutina_1` (`Rutina_ID`),
  KEY `fk_dieta_1` (`Dieta_ID`),
  CONSTRAINT `fk_dieta_1` FOREIGN KEY (`Dieta_ID`) REFERENCES `dietas` (`ID`),
  CONSTRAINT `fk_programa_1` FOREIGN KEY (`Programa_ID`) REFERENCES `programas_saludables` (`ID`),
  CONSTRAINT `fk_rutina_1` FOREIGN KEY (`Rutina_ID`) REFERENCES `rutinas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_programas_saludables`
--

LOCK TABLES `detalles_programas_saludables` WRITE;
/*!40000 ALTER TABLE `detalles_programas_saludables` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalles_programas_saludables` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_INSERT` AFTER INSERT ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_programa varchar(60) default null;
    DECLARE v_nombre_rutina varchar(60) default null;
    DECLARE v_nombre_dieta varchar(60) default null;

    -- Iniciación de las variables
     if new.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = NEW.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;

    if new.rutina_id is not null then
        -- En caso de tener el id de la rutina
        set v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    else
        SET v_nombre_rutina = "Sin rutina asignada";
    end if;

    if new.dieta_id is not null then
        -- En caso de tener el id de la dieta
        set v_nombre_dieta = (SELECT nombre FROM dietas WHERE id = NEW.dieta_id);
    else
        SET v_nombre_dieta = "Sin dieta asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se ha insertado una nueva relación en DETALLES PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "PROGRAMA ID = ", v_nombre_programa,
        "RUTINA ID = ", v_nombre_rutina,
        "DIETA ID = ",  v_nombre_dieta,
        "FECHA INICIO = ", NEW.fecha_inicio, 
        "FECHA FIN = ", NEW.fecha_fin,
        "ESTATUS = ", NEW.estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_UPDATE` AFTER UPDATE ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_nombre_programa varchar(60) default null;
    DECLARE v_nombre_rutina VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_programa2 varchar(60) default null;
    DECLARE v_nombre_rutina2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_dieta VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_dieta2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    if new.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = NEW.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;
    
    if old.programa_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_programa = (SELECT nombre FROM programas_saludables WHERE id = old.programa_id);
    else
        SET v_nombre_programa = "Sin programa asignado";
    end if;
          
    IF NEW.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    ELSE
		SET v_nombre_rutina = "Sin rutina asignada.";
    END IF;
    
    IF OLD.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina2 = (SELECT resultados_esperados FROM rutinas WHERE id = OLD.rutina_id);
    ELSE
		SET v_nombre_rutina2 = "Sin rutina asignada.";
    END IF;

    IF NEW.dieta_id IS NOT NULL THEN 
		-- En caso de tener el id de la dieta
		SET v_nombre_dieta = (SELECT nombre FROM dietas WHERE id = NEW.dieta_id);
    ELSE
		SET v_nombre_dieta = "Sin dieta asignada.";
    END IF;

    IF OLD.dieta_id IS NOT NULL THEN 
		-- En caso de tener el id de la dieta
		SET v_nombre_dieta2 = (SELECT nombre FROM dietas WHERE id = OLD.dieta_id);
    ELSE
		SET v_nombre_dieta2 = "Sin dieta asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se han actualizado los datos de la relación DETALLES PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "PROGRAMA ID = ", v_nombre_programa2, " cambio a ", v_nombre_programa,
        "RUTINA ID = ", v_nombre_rutina2, " cambio a ", v_nombre_rutina,
        "DIETA ID =",v_nombre_dieta2," cambio a ", v_nombre_dieta,
        "FECHA INICIO = ", OLD.fecha_inicio, " cambio a ", NEW.fecha_inicio,
        "FECHA FIN = ", OLD.fecha_fin, " cambio a ", NEW.fecha_fin,
        "ESTATUS = ", OLD.estatus, " cambio a ", NEW.estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `detalles_programas_saludables_AFTER_DELETE` AFTER DELETE ON `detalles_programas_saludables` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "detalles_programas_saludables",
        CONCAT_WS(" ","Se ha eliminado un registro de DETALLES PROGRAMAS SALUDABLES con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dietas`
--

DROP TABLE IF EXISTS `dietas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dietas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(300) NOT NULL,
  `Descripccion` text,
  `Objetivo` text,
  `Restricciones` text,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dietas`
--

LOCK TABLES `dietas` WRITE;
/*!40000 ALTER TABLE `dietas` DISABLE KEYS */;
/*!40000 ALTER TABLE `dietas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_INSERT` AFTER INSERT ON `dietas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    
    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "dietas",
        CONCAT_WS(" ","Se ha insertado una nueva DIETA con el ID: ",NEW.ID, 
        "con los siguientes datos: NOMBRE=", NEW.nombre,
        "DESCRIPCION = ", NEW.descripccion,
        "OBJETIVO = ", NEW.objetivo, 
        "RESTRICCIONES = ", NEW.restricciones,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_UPDATE` AFTER UPDATE ON `dietas` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
	IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
	
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "dietas",
        CONCAT_WS(" ","Se han actualizado los datos de la DIETA con el ID:",NEW.ID,
        "con los siguientes datos: ",
        "NOMBRE = ", OLD.nombre, " cambio a ", NEW.nombre,
        "DESCRIPCION = ", OLD.descripccion,"cambio a ", NEW.descripccion,
        "OBJETIVO = ", OLD.objetivo," cambio a", NEW.objetivo,
        "RESCRICCIONES = ", OLD.restricciones," cambio a ", NEW.restricciones,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `dietas_AFTER_DELETE` AFTER DELETE ON `dietas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "dietas",
        CONCAT_WS(" ","Se ha eliminado una DIETA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `edad`
--

DROP TABLE IF EXISTS `edad`;
/*!50001 DROP VIEW IF EXISTS `edad`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `edad` AS SELECT 
 1 AS `grupo_edad`,
 1 AS `genero`,
 1 AS `total_personas`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ejercicios`
--

DROP TABLE IF EXISTS `ejercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ejercicios` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre_Formal` varchar(80) NOT NULL,
  `Nombre_Comun` varchar(50) NOT NULL,
  `Descripcion` text,
  `Tipo` enum('Aeróbico','Resistencia','Flexibilidad','Fuerza') DEFAULT NULL,
  `Video_Ejemplo` varchar(100) DEFAULT NULL,
  `Consideraciones` text,
  `Dificultad` enum('Básica','Intermedia','Avanzada') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ejercicios`
--

LOCK TABLES `ejercicios` WRITE;
/*!40000 ALTER TABLE `ejercicios` DISABLE KEYS */;
INSERT INTO `ejercicios` VALUES (91,'Escaladores de montaña','Mountain Climbers','Ejercicio aeróbico de fuerza que involucra diferentes grupos musculares. Los gemelos, el bíceps femoral, los cuádriceps y los glúteos mayores son los músculos que más se fortalecen.','Aeróbico',NULL,'Mantener la estabilidad corporal y la contracción del abdomen es parte de la rutina.','Intermedia'),(92,'Flexiones de brazos con una mano','One-arm push-ups','Ejercicio que trabaja los pectorales, deltoides y tríceps mientras se fortalecen también los músculos del core.','Fuerza',NULL,'Mantener la postura correcta y la alineación de las rodillas es esencial.','Avanzada'),(93,'Saltos de caja','Box Jumps','Ejercicio pliométrico que implica saltar repetidamente sobre una caja o cualquier otra superficie estable y nivelada. Este ejercicio está dirigido a los cuádriceps, los isquiotibiales y los glúteos.','Aeróbico',NULL,'Mantener la postura correcta y la técnica correcta del salto es esencial.','Intermedia'),(94,'Abdominales con rueda','Ab Wheel Rollouts','Ejercicio que permite desarrollar los músculos y fortalecer los ligamentos y tendones de las piernas. Su ejecución de forma regular brinda una serie de beneficios al organismo en general.','Fuerza',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(95,'Curl de bíceps con mancuernas en banco inclinado','Incline Dumbbell Bicep Curl','Ejercicio que permite levantar menos carga que el convencional, pero se centra en mayor medida en la parte trasera de tus muslos y tus glúteos.','Fuerza',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(96,'Peso muerto con mancuernas','Dumbbell Deadlift','Ejercicio que permite trabajar los músculos de muslos y glúteos. Este movimiento compuesto involucra los cuádriceps, los glúteos y los isquiotibiales.','Fuerza',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(97,'Sentadillas con salto y mancuernas','Jump Squats with Dumbbells','Ejercicio pliométrico de alta intensidad excelente para generar una fuerza explosiva, preparar los músculos y articulaciones de la parte inferior del cuerpo, y aumentar la altura de tu salto vertical.','Aeróbico',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(98,'Press de hombros con mancuernas','Dumbbell Shoulder Press','Ejercicio que permite trabajar los músculos de los hombros. Este movimiento compuesto involucra los deltoides.','Fuerza',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(99,'Zancadas con mancuernas','Dumbbell Lunges','Ejercicio que permite trabajar los músculos de las piernas y glúteos. Este movimiento compuesto involucra los cuádriceps, los glúteos y los isquiotibiales.','Resistencia',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Intermedia'),(100,'Elevaciones laterales con mancuernas','Dumbbell Lateral Raises','Ejercicio que permite trabajar los músculos de los hombros. Este movimiento compuesto involucra los deltoides.','Resistencia',NULL,'Mantener la postura correcta y la técnica correcta del movimiento es esencial.','Básica');
/*!40000 ALTER TABLE `ejercicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_INSERT` AFTER INSERT ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "ejercicios",
        CONCAT_WS(" ","Se ha insertado un nuevo ejercicio con el ID: ",
        NEW.ID, "con los siguientes datos: NOMBRE_FORMAL=", NEW.nombre_formal,
        "NOMBRE_COMUN = ", NEW.nombre_comun, "DESCRIPCION = ", NEW.descripcion,
        "TIPO = ", NEW.tipo, "VIDEO_EJEMPLO = ", NEW.video_ejemplo,
        "CONSIDERACIONES = ", NEW.consideraciones, "DIFICULTAD = ", NEW.dificultad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_UPDATE` AFTER UPDATE ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "ejercicios",
        CONCAT_WS(" ","Se han actualizado los datos del ejercicio con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "NOMBRE_FORMAL=", OLD.nombre_formal, " cambio a " ,NEW.nombre_formal,
        "NOMBRE_COMUN = ", OLD.nombre_comun, " cambio a " , NEW.nombre_comun, 
        "DESCRIPCION = ", OLD.descripcion, " cambio a " , NEW.descripcion,
        "TIPO = ",  OLD.tipo, " cambio a " ,NEW.tipo, 
        "VIDEO_EJEMPLO = ", OLD.video_ejemplo, " cambio a " , NEW.video_ejemplo,
        "CONSIDERACIONES = ",  OLD.consideraciones, " cambio a " ,NEW.consideraciones, 
        "DIFICULTAD = ", OLD.dificultad, " cambio a " , NEW.dificultad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ejercicios_AFTER_DELETE` AFTER DELETE ON `ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "ejercicios",
        CONCAT_WS(" ","Se han eliminado un ejercicio con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `Persona_ID` int unsigned NOT NULL,
  `Puesto` varchar(50) NOT NULL,
  `Area` varchar(60) NOT NULL,
  `Numero_Empleado` int unsigned NOT NULL,
  `Sucursal_ID` int unsigned NOT NULL,
  `Fecha_Contratacion` datetime NOT NULL,
  PRIMARY KEY (`Persona_ID`),
  KEY `fk_sucursales_1` (`Sucursal_ID`),
  CONSTRAINT `fk_persona_2` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`),
  CONSTRAINT `fk_sucursales_1` FOREIGN KEY (`Sucursal_ID`) REFERENCES `sucursales` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_INSERT` AFTER INSERT ON `empleados` FOR EACH ROW BEGIN
	 -- Declaración de variables
     DECLARE v_nombre_sucursal varchar(60) default null;
     
     if new.sucursal_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    else
        SET v_nombre_sucursal = "Sin sucursal asignada";
    end if;
    
    INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "empleados",
        CONCAT_WS(" ","Se ha insertado una nuevo EMPLEADO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: PUESTO = ", NEW.puesto,
        "AREA=", NEW.area,
        "NUMERO EMPLEADO = ", NEW.numero_empleado,
        "SUCURSAL ID = ", v_nombre_sucursal,
        "FECHA CONTRATACIÓN = ",  NEW.fecha_contratacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_UPDATE` AFTER UPDATE ON `empleados` FOR EACH ROW BEGIN
	-- Declaración de variables
	DECLARE v_nombre_sucursal VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_sucursal2 VARCHAR(60) DEFAULT NULL;
    
    IF NEW.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal = (SELECT nombre FROM sucursales WHERE id = NEW.sucursal_id);
    ELSE
		SET v_nombre_sucursal = "Sin sucursal asignada.";
    END IF;

    IF OLD.sucursal_id IS NOT NULL THEN 
		-- En caso de tener el id de la sucursal debemos recuperar su nombre
		-- para ingresarlo en la bitacora.
		SET v_nombre_sucursal2 = (SELECT nombre FROM sucursales WHERE id = OLD.sucursal_id);
    ELSE
		SET v_nombre_sucursal2 = "Sin sucursal asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "empleados",
        CONCAT_WS(" ","Se han actualizado los datos del empleado con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "PUESTO = ", OLD.puesto, " cambio a " ,NEW.puesto,
        "AREA = ", OLD.area, " cambio a " , NEW.area, 
        "NUMERO EMPLEADO = ", OLD.numero_empleado, " cambio a " , NEW.numero_empleado,
        "SUCURSAL ID = ", v_nombre_sucursal2 , " cambio a " , v_nombre_sucursal, 
        "FECHA CONTRATACIÓN = ", OLD.fecha_contratacion, " cambio a " , NEW.fecha_contratacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empleados_AFTER_DELETE` AFTER DELETE ON `empleados` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Delete",
        "empleados",
        CONCAT_WS(" ","Se ha eliminado un EMPLEADO con el ID: ", OLD.persona_id),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(250) NOT NULL,
  `Descripcion` text,
  `Marca` varchar(50) NOT NULL,
  `Modelo` varchar(50) NOT NULL,
  `Especificaciones` text,
  `Fotografia` varchar(100) DEFAULT NULL,
  `Total_Existencia` int unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (91,'Máquina de remo inclinado','Esta máquina actúa en el sistema muscular y es eficaz para lograr una figura estilizada y dar forma a los músculos','Total Gym','Incline Remo CE','Esta máquina tiene una resistencia regulable y está hecha de acero aleado. Sus dimensiones son 98\" de profundidad, 23.5\" de ancho y 30\" de altura. El peso máximo recomendado es de 400 libras y el peso del artículo es de 98 libras',NULL,1),(92,'Máquina de desarrollo de pantorrilla sentado','Esta máquina está diseñada con el ángulo ideal para brindar máxima tensión en la pantorrilla','SONICO FITNESS','X10','Esta máquina tiene una bocina de carga de la placa y una almohadilla ajustable para el muslo, lo que la hace adaptable para cualquier usuario',NULL,1),(93,'Máquina de abducción de cadera','Esta máquina trabaja los músculos de la abducción de la cadera, fortaleciéndolos y mejorando la movilidad en la zona de los muslos','Total Gym','NP-L1131','Esta máquina trabaja los músculos de la abducción de la cadera, fortaleciéndolos y mejorando la movilidad en la zona de los muslos. Sus dimensiones son 98\" de profundidad, 23.5\" de ancho y 30\" de altura. El peso máximo recomendado es de 400 libras y el peso del artículo es de 98 libras',NULL,1),(94,'Máquina de rotación de tronco','Esta máquina permite la flexión lateral gracias a las articulaciones cartilaginosas entre las vértebras adyacentes en la columna vertebral','TZ','9003','Esta máquina tiene un tamaño de 1360*1206*1680 mm, está hecha de tubo elíptico plano de 150*50*3 mm, tiene placas de peso de 65kg y un peso de la máquina de 205kg',NULL,1),(95,'Máquina de glúteos','Esta máquina está diseñada para trabajar los músculos que giran el muslo hacia fuera, como el glúteo medio, el sartorio y el tensor de la fascia lata','Nautilus','Glute Drive','Esta máquina aísla y fortalece los glúteos mientras mejora la estabilidad del núcleo. Sus dimensiones son 60\" de ancho, 62\" de largo y 35\" de altura. El peso total de la máquina es de 252 libras',NULL,1),(96,'Máquina para isquiotibiales de pie','Esta máquina es un banco con un peso móvil en un extremo. Para trabajar los isquiotibiales, te acuestas boca abajo, sostienes un rodillo pesado con los pies y lo levantas doblando las rodillas','Technogym','Leg Curl','Esta máquina permite entrenar los músculos isquiotibiales de manera segura y efectiva',NULL,1),(97,'Máquina de Pull Over','Esta máquina se enfoca en los músculos de la espalda, los hombros y los brazos, lo que lo convierte en un ejercicio muy completo','JBS FITNESS','Pullover Strength','Esta máquina permite ejercitar el pullover en su máxima contracción. Tiene un asiento regulable en altura y un cinturón para una máxima sujeción. Está disponible para carga olímpica o discos de 28mm',NULL,1),(98,'Máquina de extensión de cadera','Esta máquina permite la extensión de cadera de pie, proporcionando un ángulo diferente de trabajo y permitiendo trabajar ciertas partes de la cadera de forma específica','SportsArt','N961','Esta máquina permite trabajar los glúteos, femorales y flexores de la cadera desde una posición erguida. Sus dimensiones son 150 x 172 x 126 cm',NULL,1),(99,'Máquina de elevación de gemelos, de pie en posición inclinada','Esta máquina permite realizar elevaciones de gemelos de pie. El ejercicio trabaja los músculos del gemelo, especialmente el musculo gastrocnemio, y el soleo en menor medida','Simply Fitness','Elevación de gemelos de pie','Esta máquina permite realizar elevaciones de gemelos de pie. El ejercicio trabaja los músculos del gemelo, especialmente el musculo gastrocnemio, y el soleo en menor medida',NULL,1),(100,'Maquina de flexión lateral de columna vertebral','Esta máquina permite la flexión lateral gracias a las articulaciones cartilaginosas entre las vértebras adyacentes en la columna vertebral, Este sistema convierte tu mesa de operaciones estándar en una mesa especializada para cirugías de columna vertebral con un ajuste fácil y preciso de la cabeza y la columna cervical','Allen Medical','Sistema para columna vertebral Allen','Este sistema convierte tu mesa de operaciones estándar en una mesa especializada para cirugías de columna vertebral con un ajuste fácil y preciso de la cabeza y la columna cervical. El sistema proporciona un excelente acceso al arco en C y al arco en O, por lo tanto, proporciona también los beneficios de la radiolucencia de una mesa independiente para cirugías de columna vertebra',NULL,1);
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_AFTER_INSERT` AFTER INSERT ON `equipos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "equipos",
        CONCAT_WS(" ","Se ha insertado un nuevo equipo con el ID: ",NEW.ID, 
        "con los siguientes datos: NOMBRE=", NEW.nombre,
        "DESCRIPCION = ", NEW.descripcion,
        "MARCA = ", NEW.marca,
        "MODELO = ", NEW.modelo, 
        "ESPECIFICACIONES = ", NEW.especificaciones,
        "FOTOGRAFIA = ", NEW.fotografia, 
        "TOTAL_EXISTENCIA = ", NEW.total_existencia),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_BEFORE_UPDATE` BEFORE UPDATE ON `equipos` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "equipos",
        CONCAT_WS(" ","Se han actualizado los datos del equipo con el ID: ",NEW.ID, 
        "con los siguientes datos:", "NOMBRE=", OLD.nombre, " cambio a " ,NEW.nombre,
        "DESCRIPCION = ", OLD.descripcion, " cambio a " , NEW.descripcion,
        "MARCA = ", OLD.marca, " cambio a " , NEW.marca, 
        "MODELO = ",  OLD.modelo, " cambio a " ,NEW.modelo, 
        "ESPECIFICACIONES = ", OLD.especificaciones, " cambio a " , NEW.especificaciones,
        "FOTOGRAFIA = ",  OLD.fotografia, " cambio a " ,NEW.fotografia, 
        "TOTAL_EXISTENCIA = ", OLD.total_existencia, " cambio a " , NEW.total_existencia),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_AFTER_DELETE` AFTER DELETE ON `equipos` FOR EACH ROW BEGIN
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "equipos",
        CONCAT_WS(" ","Se ha eliminado un equipo con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipos_existencias`
--

DROP TABLE IF EXISTS `equipos_existencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos_existencias` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Equipo_ID` int unsigned NOT NULL,
  `Area_ID` int unsigned NOT NULL,
  `Color` varchar(100) DEFAULT NULL,
  `Estatus` enum('Nuevo','Semi-Nuevo','Bueno','Regular','Malo','Baja','Extraviado') NOT NULL,
  `Fecha_Asignacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fk_equipo_1` (`Equipo_ID`),
  KEY `fk_area_1` (`Area_ID`),
  CONSTRAINT `fk_area_1` FOREIGN KEY (`Area_ID`) REFERENCES `areas` (`ID`),
  CONSTRAINT `fk_equipo_1` FOREIGN KEY (`Equipo_ID`) REFERENCES `equipos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos_existencias`
--

LOCK TABLES `equipos_existencias` WRITE;
/*!40000 ALTER TABLE `equipos_existencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipos_existencias` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_INSERT` AFTER INSERT ON `equipos_existencias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_equipo varchar(60) default null;
    DECLARE v_nombre_area varchar(60) default null;

    -- Iniciación de las variables
    if new.equipo_id is not null then
        -- En caso de tener el id del equipo
        set v_nombre_equipo = (SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = NEW.equipo_id);
    else
        SET v_nombre_equipo = "Sin equipo asignado";
    end if;

    if new.area_id is not null then
        -- En caso de tener el id del area
        set v_nombre_area = (SELECT nombre FROM areas WHERE id = NEW.area_id);
    else
        SET v_nombre_area = "Sin area asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "equipos_existencias",
        CONCAT_WS(" ","Se ha insertado una nueva relación de EQUIPOS EXISTENCIAS con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "EQUIPO ID = ", v_nombre_equipo,
        "AREA ID = ",  v_nombre_area,
        "COLOR = ", NEW.color, 
        "ESTATUS = ", NEW.estatus,
        "FECHA DE ASIGNACIÓN = ", NEW.fecha_asignacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_UPDATE` AFTER UPDATE ON `equipos_existencias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_equipo VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_equipo2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_area VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_area2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.equipo_id IS NOT NULL THEN 
		-- En caso de tener el id del equipo
		SET v_nombre_equipo = (SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = NEW.equipo_id);
    ELSE
		SET v_nombre_equipo = "Sin equipo asignado.";
    END IF;
    
    IF OLD.equipo_id IS NOT NULL THEN 
		-- En caso de tener el id del equipo
		SET v_nombre_equipo2 =(SELECT CONCAT_WS(" ", e.nombre, e.marca, e.modelo) FROM equipos e WHERE id = OLD.equipo_id);
    ELSE
		SET v_nombre_equipo2 = "Sin equipo asignado.";
    END IF;

    IF NEW.area_id IS NOT NULL THEN 
		-- En caso de tener el id del area
		SET v_nombre_area = (SELECT nombre FROM areas WHERE id = NEW.area_id);
    ELSE
		SET v_nombre_area = "Sin area asignada.";
    END IF;

    IF OLD.area_id IS NOT NULL THEN 
		-- En caso de tener el id del area
		SET v_nombre_area2 = (SELECT nombre FROM areas WHERE id = OLD.area_id);
    ELSE
		SET v_nombre_area2 = "Sin area asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "equipos_exixstencias",
        CONCAT_WS(" ","Se han actualizado los datos de la relación EQUIPOS EXISTENCIAS con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "EQUIPO ID = ", v_nombre_equipo2, "cambio a", v_nombre_equipo,
        "AREA ID =",v_nombre_area2,"cambio a", v_nombre_area,
        "COLOR = ", OLD.color, "cambio a", NEW.color ,
        "ESTATUS = ", OLD.estatus, "cambio a", NEW.estatus,
        "FECHA DE ASIGNACIÓN = ", OLD.fecha_asignacion , "cambio a", NEW.fecha_asignacion ),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `equipos_existencias_AFTER_DELETE` AFTER DELETE ON `equipos_existencias` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "equipos_existencias",
        CONCAT_WS(" ","Se ha eliminado una relación EUIPOS EXISTENCIAS con los IDs: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `instructores`
--

DROP TABLE IF EXISTS `instructores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructores` (
  `Empleado_ID` int unsigned NOT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Horario_Disponibilidad` text,
  `Total_Miembros_Atendidos` int unsigned DEFAULT NULL,
  `Valoracion_Miembro` int unsigned DEFAULT '0',
  PRIMARY KEY (`Empleado_ID`),
  CONSTRAINT `fk_empleado_1` FOREIGN KEY (`Empleado_ID`) REFERENCES `empleados` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructores`
--

LOCK TABLES `instructores` WRITE;
/*!40000 ALTER TABLE `instructores` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructores` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_INSERT` AFTER INSERT ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "instructores",
        CONCAT_WS(" ","Se ha insertado un nuevo INSTRUCTOR con el ID: ",NEW.empleado_id, 
        "con los siguientes datos: ESPECIALIDAD=", NEW.especialidad,
        "HORARIO DE DISPONIBILIDAD = ", NEW.horario_disponibilidad, 
        "TOTAL DE MIEMBROS ATENDIDOS = ", NEW.total_miembros_atendidos,
        "VALORACIÓN DE LOS MIEMBROS = ", NEW.valoracion_miembro),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_UPDATE` AFTER UPDATE ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "instructores",
        CONCAT_WS(" ","Se han actualizado los datos del INSTRUCTOR con el ID: ",NEW.empleado_id, 
        "con los siguientes datos:",
        "ESPECIALIDAD = ", OLD.especialidad, " cambio a " ,NEW.especialidad,
        "HORARIO DE DISPONIBILIDAD = ", OLD.horario_disponibilidad, " cambio a " , NEW.horario_disponibilidad, 
        "TOTAL DE MIEMBROS ATENDIDOS = ", OLD.total_miembros_atendidos, " cambio a " , NEW.total_miembros_atendidos,
        "VALORACIÓN DE MIEMBRO = ",  OLD.valoracion_miembro, " cambio a " ,NEW.valoracion_miembro),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `instructores_AFTER_DELETE` AFTER DELETE ON `instructores` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "instructores",
        CONCAT_WS(" ","Se ha eliminado un INSTRUCTOR con el ID: ", OLD.empleado_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `membresias`
--

DROP TABLE IF EXISTS `membresias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membresias` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Codigo` varchar(50) NOT NULL,
  `Tipo` enum('Individual','Familiar','Empresarial') NOT NULL,
  `Tipo_Servicios` enum('Basicos','Completa','Coaching','Nutriólogo') NOT NULL,
  `Tipo_Plan` enum('Anual','Semestral','Trimestral','Bimestral','Mensual','Semanal','Diaria') DEFAULT NULL,
  `Nivel` enum('Nuevo','Plata','Oro','Diamante') NOT NULL,
  `Fecha_Inicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Fin` datetime NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Codigo` (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresias`
--

LOCK TABLES `membresias` WRITE;
/*!40000 ALTER TABLE `membresias` DISABLE KEYS */;
/*!40000 ALTER TABLE `membresias` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_INSERT` AFTER INSERT ON `membresias` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "membresias",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "CODIGO = ", NEW.codigo,
        "TIPO = ", NEW.tipo,
        "TIPO SERVICIOS = ", NEW.tipo_servicios,
        "TIPO PLAN = ",  NEW.tipo_plan,
        "NIVEL = ", NEW.nivel, 
        "FECHA INICIO = ", NEW.fecha_inicio,
        "FECHA FIN = ", NEW.fecha_fin,
        "ESTATUS = ", v_cadena_estatus,
        "FECHA REGISTRO = ", NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ", NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_UPDATE` AFTER UPDATE ON `membresias` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "membresias",
        CONCAT_WS(" ","Se han actualizado los datos de la MEMBRESIA con el ID: ",NEW.ID, 
        "con los siguientes datos:",
        "CODIGO = ", OLD.codigo, " cambio a " ,NEW.codigo,
        "TIPO = ",  OLD.tipo, " cambio a " ,NEW.tipo, 
		"TIPO SERVICIOS = ", OLD.tipo_servicios, " cambio a " , NEW.tipo_servicios,
        "TIPO PLAN = ", OLD.tipo_plan, " cambio a " , NEW.tipo_plan, 
        "NIVEL = ", OLD.nivel, " cambio a " , NEW.nivel,
        "FECHA INICIO = ",  OLD.fecha_inicio, " cambio a " ,NEW.fecha_inicio, 
        "FECHA FIN = ", OLD.fecha_fin, " cambio a " , NEW.fecha_fin,
        "ESTATUS = ",  v_cadena_estatus2, " cambio a " ,v_cadena_estatus,
        "FECHA REGISTRO = ",  OLD.fecha_registro, " cambio a " ,NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  OLD.fecha_actualizacion, " cambio a " ,NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_AFTER_DELETE` AFTER DELETE ON `membresias` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "membresias",
        CONCAT_WS(" ","Se ha eliminado una MEMBRESIA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `membresias_usuarios`
--

DROP TABLE IF EXISTS `membresias_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membresias_usuarios` (
  `Membresia_ID` int unsigned NOT NULL,
  `Usuarios_ID` int unsigned NOT NULL,
  `Fecha_Ultima_Visita` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`Membresia_ID`,`Usuarios_ID`),
  KEY `fk_usuario_2` (`Usuarios_ID`),
  CONSTRAINT `fk_membresia_ID` FOREIGN KEY (`Membresia_ID`) REFERENCES `membresias` (`ID`),
  CONSTRAINT `fk_usuario_2` FOREIGN KEY (`Usuarios_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresias_usuarios`
--

LOCK TABLES `membresias_usuarios` WRITE;
/*!40000 ALTER TABLE `membresias_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `membresias_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_INSERT` AFTER INSERT ON `membresias_usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_membresia varchar(60) default null;
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.membresia_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_membresia = (SELECT codigo FROM membresias WHERE id = NEW.membresia_id);
    else
        SET v_nombre_membresia = "Sin membresia asignado";
    end if;

    if new.usuarios_id is not null then
        -- En caso de tener el id de la sucursal debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuarios_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "membresias",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con los IDs: Membresia - ", NEW.membresia_id, ", Usuario - ", NEW.usuarios_id, 
        "con los siguientes datos: ",
        "MEMBRESIA ID = ", v_nombre_membresia,
        "USUARIO ID = ",  v_nombre_usuario,
        "FECHA ULTIMA VISITA = ", NEW.fecha_ultima_visita, 
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_UPDATE` AFTER UPDATE ON `membresias_usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_membresia VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_membresia2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.membresia_id IS NOT NULL THEN 
		-- En caso de tener el id de la membresia
		SET v_nombre_membresia =  (SELECT codigo FROM membresias WHERE id = NEW.membresia_id);
    ELSE
		SET v_nombre_membresia = "Sin membresia asignada.";
    END IF;
    
    IF OLD.membresia_id IS NOT NULL THEN 
		-- En caso de tener el id de la membresia
		SET v_nombre_membresia2 =  (SELECT codigo FROM membresias WHERE id = OLD.membresia_id);
    ELSE
		SET v_nombre_membresia2 = "Sin membresia asignada.";
    END IF;

    IF NEW.usuarios_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario =  (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuarios_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignada.";
    END IF;

    IF OLD.usuarios_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 =  (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = OLD.usuarios_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "membresias_usuarios",
        CONCAT_WS(" ","Se han actualizado los datos del área con los IDs: Membresia - ", OLD.membresia_id, ", Usuario - ", OLD.usuarios_id,
		"con los siguientes datos:",
        "MEMBRESIA ID = ", v_nombre_membresia2, " cambio a ", v_nombre_membresia,
        "USUARIOS ID =",v_nombre_usuario2," cambio a ", v_nombre_usuario,
        "FECHA ULTIMA VISITA =",OLD.fecha_ultima_visita," cambio a ", NEW.fecha_ultima_visita,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `membresias_usuarios_AFTER_DELETE` AFTER DELETE ON `membresias_usuarios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
		USER(),
		"Delete",
		"membresias_usuarios",
		CONCAT_WS(" ","Se ha eliminado una relación MEMBRESIAS USUARIOS con los IDs: Membresia - ", OLD.membresia_id, ", Usuario - ", OLD.usuarios_id),
		now(),
		DEFAULT
	);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `miembros`
--

DROP TABLE IF EXISTS `miembros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `miembros` (
  `Persona_ID` int unsigned NOT NULL,
  `Tipo` enum('Frecuente','Ocasional','Nuevo','Esporádico','Una sola visita') NOT NULL,
  `Membresia_Activa` bit(1) NOT NULL DEFAULT b'1',
  `Antiguedad` varchar(80) NOT NULL,
  PRIMARY KEY (`Persona_ID`),
  CONSTRAINT `fk_persona_1` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miembros`
--

LOCK TABLES `miembros` WRITE;
/*!40000 ALTER TABLE `miembros` DISABLE KEYS */;
/*!40000 ALTER TABLE `miembros` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_INSERT` AFTER INSERT ON `miembros` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
	-- Iniciación de las variables
    IF new.membresia_activa = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "miembros",
        CONCAT_WS(" ","Se ha insertado un nuevo MIEMBRO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: TIPO = ", NEW.tipo,
        "MEMBRESIA ACTIVA = ", v_cadena_estatus,
        "ANTIGUEDAD = ", NEW.antiguedad),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_UPDATE` AFTER UPDATE ON `miembros` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    
    -- Inicialización de las variables
    IF NEW.membresia_activa = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.membresia_activa = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "miembros",
        CONCAT_WS(" ","Se han actualizado los datos del MIEMBRO con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "TIPO = ", OLD.tipo, "cambio a", NEW.tipo,
        "MEMBRESIA ACTIVA =",v_cadena_estatus2,"cambio a", v_cadena_estatus,
        "ANTIGUEDAD = ", OLD.antiguedad, "cambio a", NEW.antiguedad),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `miembros_AFTER_DELETE` AFTER DELETE ON `miembros` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "miembros",
        CONCAT_WS(" ","Se ha eliminado el MIEMBRO con el ID: ", OLD.persona_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Usuario_ID` int unsigned NOT NULL,
  `Total` decimal(6,2) NOT NULL,
  `Fecha_Registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_usuario_3` (`Usuario_ID`),
  CONSTRAINT `fk_usuario_3` FOREIGN KEY (`Usuario_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_INSERT` AFTER INSERT ON `pedidos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;
     DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;
    
    if new.usuario_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "pedidos",
        CONCAT_WS(" ","Se ha insertado un nuevo PEDIDO con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "USUARIO ID = ", v_nombre_usuario,
        "TOTAL = ", NEW.total, 
        "FECHA REGISTRO = ",  NEW.fecha_registro,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_UPDATE` AFTER UPDATE ON `pedidos` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(100) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;
    
    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;

    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "pedidos",
        CONCAT_WS(" ","Se han actualizado los datos del PEDIDO con el ID: ", NEW.ID,
        "con los siguientes datos:",
        "USUARIO ID = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "TOTAL =",OLD.total,"cambio a", NEW.total,
        "FECHA DE REGISTRO =",OLD.fecha_registro,"cambio a", NEW.fecha_registro,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pedidos_AFTER_DELETE` AFTER DELETE ON `pedidos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "pedidos",
        CONCAT_WS(" ","Se ha eliminado un PEDIDO con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Titulo_Cortesia` varchar(20) DEFAULT NULL,
  `Nombre` varchar(80) NOT NULL,
  `Primer_Apellido` varchar(80) NOT NULL,
  `Segundo_Apellido` varchar(80) NOT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Fotografia` varchar(100) DEFAULT NULL,
  `Genero` enum('M','F','N/B') DEFAULT NULL,
  `Tipo_Sangre` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_INSERT` AFTER INSERT ON `personas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "personas",
        CONCAT_WS(" ","Se ha insertado una nueva persona con el ID: ",NEW.ID, 
        "con los siguientes datos:  TITULO CORTESIA = ", NEW.titulo_cortesia,
        "NOMBRE=", NEW.nombre,
        "PRIMER APELLIDO = ", NEW.primer_apellido,
        "SEGUNDO APELLIDO = ", NEW.segundo_apellido,
        "FECHA NACIMIENTO = ",  NEW.fecha_nacimiento,
        "FOTOGRAFIA = ", NEW.fotografia, 
        "GENERO = ", NEW.genero, 
        "TIPO SANGRE = ", NEW.tipo_sangre,
        "ESTATUS = ", NEW.estatus,
        "FECHA REGISTRO = ",  NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_UPDATE` AFTER UPDATE ON `personas` FOR EACH ROW BEGIN
 INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Update",
        "personas",
        CONCAT_WS(" ","Se han actualizado los datos de la persona con el ID: ",NEW.ID, 
        "con los siguientes datos: TITULO CORTESIA = ", old.titulo_cortesia, " cambio a " ,NEW.titulo_cortesia,
        "NOMBRE=", OLD.nombre, " cambio a " ,NEW.nombre,
        "PRIMER APELLIDO = ", OLD.primer_apellido, " cambio a " , NEW.primer_apellido,
        "SEGUNDO APELLIDO = ", OLD.segundo_apellido, " cambio a " , NEW.segundo_apellido, 
        "FECHA NACIMIENTO = ",  OLD.fecha_nacimiento, " cambio a " ,NEW.fecha_nacimiento, 
        "FOTOGRAFIA = ",  OLD.fotografia, " cambio a " ,NEW.fotografia, 
        "GENERO = ", OLD.genero, " cambio a " , NEW.genero,
        "TIPO SANGRE = ", OLD.tipo_sangre, " cambio a " , NEW.tipo_sangre,
        "ESTATUS = ", OLD.estatus, " cambio a " ,  NEW.estatus,
        "FECHA REGISTRO = ", OLD.fecha_registro, " cambio a " ,   NEW.fecha_registro,
        "FECHA ACTUALIZACIÓN = ",  OLD.fecha_actualizacion, " cambio a " ,  NEW.fecha_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `personas_AFTER_DELETE` AFTER DELETE ON `personas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "personas",
        CONCAT_WS(" ","Se ha eliminado una persona con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Marca` varchar(100) NOT NULL,
  `Codigo_Barras` varchar(100) DEFAULT NULL,
  `Descripcion` text,
  `Presentacion` varchar(50) NOT NULL,
  `Precio_Actual` decimal(6,2) NOT NULL,
  `Fotografia` varchar(100) NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_INSERT` AFTER INSERT ON `productos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "productos",
        CONCAT_WS(" ","Se ha insertado una nueva AREA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "MARCA = ", NEW.marca,
        "CODIGO DE BARRAS = ",  NEW.codigo_barras,
        "DESCRIPCIÓN = ", NEW.descripcion,
        "PRESENTACIÓN = ", NEW.presentacion, 
        "PRECIO ACTUAL = ", NEW.precio_actual,
        "FOTOGRAFÍA = ",  NEW.fotografia,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_UPDATE` AFTER UPDATE ON `productos` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;

    -- Inicialización de las variables 
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "productos",
        CONCAT_WS(" ","Se han actualizado los datos del PRODUCTO con el ID: ",NEW.ID,
        "con los siguientes datos:",
        "NOMBRE = ", OLD.nombre, " cambio a " ,NEW.nombre,
        "MARCA = ", OLD.marca, " cambio a " , NEW.marca, 
        "CODIGO DE BARRAS = ", OLD.codigo_barras, " cambio a " , NEW.codigo_barras,
        "DESCRIPCIÓN = ",  OLD.descripcion, " cambio a " ,NEW.descripcion, 
        "PRESENTACIÓN = ", OLD.presentacion, " cambio a " , NEW.presentacion,
        "PRECIO ACTUAL = ",  OLD.precio_actual, " cambio a " ,NEW.precio_actual, 
        "FOTOGRAFÍA = ", OLD.fotografia, " cambio a " , NEW.fotografia,
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `productos_AFTER_DELETE` AFTER DELETE ON `productos` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "productos",
        CONCAT_WS(" ","Se ha eliminado un PRODUCTO con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `programas_saludables`
--

DROP TABLE IF EXISTS `programas_saludables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programas_saludables` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(250) NOT NULL,
  `Usuario_ID` int unsigned NOT NULL,
  `Instructor_ID` int unsigned NOT NULL,
  `Fecha_Creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Estatus` enum('Registrado','Sugerido','Aprobado por el Médico','Aprobado por el Usuario','Rechazado por el Médico','Rechazado por el Usuario','Terminado','Suspendido','Cancelado') NOT NULL DEFAULT 'Registrado',
  `Duracion` varchar(80) NOT NULL,
  `Porcentaje_Avance` decimal(5,2) NOT NULL DEFAULT '0.00',
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_usuario_1` (`Usuario_ID`),
  KEY `fk_instructores_1` (`Instructor_ID`),
  CONSTRAINT `fk_instructores_1` FOREIGN KEY (`Instructor_ID`) REFERENCES `instructores` (`Empleado_ID`),
  CONSTRAINT `fk_usuario_1` FOREIGN KEY (`Usuario_ID`) REFERENCES `usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programas_saludables`
--

LOCK TABLES `programas_saludables` WRITE;
/*!40000 ALTER TABLE `programas_saludables` DISABLE KEYS */;
/*!40000 ALTER TABLE `programas_saludables` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_INSERT` AFTER INSERT ON `programas_saludables` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;
    DECLARE v_nombre_instructor varchar(60) default null;

    -- Iniciación de las variables
    if new.usuario_id is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    if new.instructor_id is not null then
        -- En caso de tener el id del instructor debemos recuperar su nombre
        set v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.instructor_id);
    else
        SET v_nombre_instructor = "Sin instructor asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "programas_saludables",
        CONCAT_WS(" ","Se ha insertado una nueva relación de PROGRAMAS SALUDABLES con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE = ", NEW.nombre,
        "USUARIO ID = ", v_nombre_usuario,
        "INSTRUCTOR ID = ",  v_nombre_instructor,
        "FECHA DE CREACIÓN = ", NEW.fecha_creacion,
		"ESTATUS = ", NEW.estatus,
        "DURACIÓN = ", NEW.duracion, 
        "PORCENTAJE DE AVANCE = ", NEW.porcentaje_avance,
        "FECHA DE ULTIMA ACTUALIZACIÓN = ", NEW.fecha_ultima_actualizacion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_UPDATE` AFTER UPDATE ON `programas_saludables` FOR EACH ROW BEGIN
	 -- Declaración de variables
    DECLARE v_nombre_usuario VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_instructor VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_instructor2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;
    
    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;

    IF NEW.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del instructor
		SET v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.instructor_id);
    ELSE
		SET v_nombre_instructor = "Sin instructor asignado.";
    END IF;

    IF OLD.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del instructor
		SET v_nombre_instructor2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = OLD.instructor_id);
    ELSE
		SET v_nombre_instructor2 = "Sin instructor asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "programas_saludables",
        CONCAT_WS(" ","Se han actualizado los datos de la relación PROGRAMAS SALUDABLES con el ID: ",NEW.ID,
        "con los siguientes datos:",
        "NOMBRE = ", OLD.nombre, "cambio a", NEW.nombre,
        "USUARIO ID = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "INSTRUCTOR ID =",v_nombre_instructor2,"cambio a", v_nombre_instructor,
        "FECHA DE CREACIÓN = ", OLD.fecha_creacion, "cambio a", NEW.fecha_creacion,
        "ESTATUS = ", OLD.estatus, "cambio a", NEW.estatus,
        "DURACIÓN = ", OLD.duracion, "cambio a", NEW.duracion,
        "PORCENTAJE DE AVANCE = ", OLD.porcentaje_avance, "cambio a", NEW.porcentaje_avance,
        "FECHA DE ULTIMA ACTUALIZACIÓN = ", OLD.fecha_ultima_actualizacion, "cambio a", NEW.fecha_ultima_actualizacion),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `programas_saludables_AFTER_DELETE` AFTER DELETE ON `programas_saludables` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "programas_saludables",
        CONCAT_WS(" ","Se ha eliminado una relación en PROGRAMAS SALUDABLES con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rutinas`
--

DROP TABLE IF EXISTS `rutinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutinas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Instructor_ID` int unsigned NOT NULL,
  `Usuario_ID` int unsigned NOT NULL,
  `Fecha_Asignacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Termino` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tiempo_Aproximado` time DEFAULT NULL,
  `Estatus` enum('Concluido','Actual','Suspendida') DEFAULT NULL,
  `Resultados_Esperados` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutinas`
--

LOCK TABLES `rutinas` WRITE;
/*!40000 ALTER TABLE `rutinas` DISABLE KEYS */;
/*!40000 ALTER TABLE `rutinas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_INSERT` AFTER INSERT ON `rutinas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_instructor varchar(60) default null;
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    if new.instructor_id is not null then
        -- En caso de tener el id del empleado responsable debemos recuperar su nombre
        set v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.instructor_id);
    else
        SET v_nombre_instructor = "Sin responsable asignado";
    end if;

    if new.usuario_id is not null then
        -- En caso de tener el id del usuario
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.usuario_id);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "rutinas",
        CONCAT_WS(" ","Se ha insertado una nueva RUTINA con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "INSTRUCTOR ID = ", v_nombre_instructor,
        "USUARIO ID = ", v_nombre_usuario,
        "FECHA DE ASIGNACIÓN = ", NEW.fecha_asignacion,
        "FECHA DE TERMINO = ", NEW.fecha_termino,
        "TIEMPO APROXIMADO = ", NEW.tiempo_Aproximado, 
        "ESTATUS = ", NEW.estatus,
        "RESULTADOS ESPERADOS = ", NEW.resultados_esperados),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_UPDATE` AFTER UPDATE ON `rutinas` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_instructor VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_instructor2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_usuario VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_usuario2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado
		SET v_nombre_instructor = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.instructor_id);
    ELSE
		SET v_nombre_instructor = "Sin responsable asignado.";
    END IF;
    
    IF OLD.instructor_id IS NOT NULL THEN 
		-- En caso de tener el id del empleado 
		SET v_nombre_instructor2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
		p.segundo_apellido) FROM personas p WHERE id = OLD.instructor_id);
    ELSE
		SET v_nombre_instructor2 = "Sin responsable asignado.";
    END IF;

    IF NEW.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,p.segundo_apellido) FROM personas p WHERE id = NEW.usuario_id);
    ELSE
		SET v_nombre_usuario = "Sin usuario asignado.";
    END IF;

    IF OLD.usuario_id IS NOT NULL THEN 
		-- En caso de tener el id del usuario
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_apellido) FROM personas p WHERE id = OLD.usuario_id);
    ELSE
		SET v_nombre_usuario2 = "Sin usuario asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "areas",
        CONCAT_WS(" ","Se han actualizado los datos del área con el ID: ",
        NEW.ID, "con los siguientes datos:",
        "INSTRUCTOR ID = ", v_nombre_instructor2, " cambio a ", v_nombre_instructor,
        "USUARIO ID =",v_nombre_usuario2," cambio a ", v_nombre_usuario,
        "FECHA DE ASIGNACIÓN = ", OLD.fecha_asignacion, "cambio a", NEW.fecha_asignacion,
        "FECHA DE TERMINO = ", OLD.fecha_termino, "cambio a", NEW.fecha_termino,
        "TIEMPO APROXIMADO = ", OLD.tiempo_aproximado, "cambio a", NEW.tiempo_aproximado,
        "ESTATUS = ", OLD.estatus, " cambio a ", NEW.estatus,
        "RESULTADOS ESPERADOS = ", OLD.resultados_esperados, " cambio a ", NEW.resultados_esperados),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_AFTER_DELETE` AFTER DELETE ON `rutinas` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "rutinas",
        CONCAT_WS(" ","Se ha eliminado una RUTINA con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rutinas_ejercicios`
--

DROP TABLE IF EXISTS `rutinas_ejercicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutinas_ejercicios` (
  `Ejercicio_ID` int unsigned NOT NULL,
  `Rutina_ID` int unsigned NOT NULL,
  `Repeticiones` int unsigned DEFAULT NULL,
  `Tiempo` time DEFAULT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  KEY `fk_ejercicio_1` (`Ejercicio_ID`),
  KEY `fk_rutina_2` (`Rutina_ID`),
  CONSTRAINT `fk_ejercicio_1` FOREIGN KEY (`Ejercicio_ID`) REFERENCES `ejercicios` (`ID`),
  CONSTRAINT `fk_rutina_2` FOREIGN KEY (`Rutina_ID`) REFERENCES `rutinas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutinas_ejercicios`
--

LOCK TABLES `rutinas_ejercicios` WRITE;
/*!40000 ALTER TABLE `rutinas_ejercicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `rutinas_ejercicios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_INSERT` AFTER INSERT ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_ejercicio varchar(60) default null;
    DECLARE v_nombre_rutina varchar(60) default null;

    -- Iniciación de las variables
    IF new.estatus = b'1' then
        set v_cadena_estatus = "Activa";
    else
        set v_cadena_estatus = "Inactiva";
    end if;

    if new.ejercicio_id is not null then
        -- En caso de tener el id del ejercicio
        set v_nombre_ejercicio = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = NEW.ejercicio_id);
    else
        SET v_nombre_ejercicio = "Sin ejercicio asignado";
    end if;

    if new.rutina_id is not null then
        -- En caso de tener el id de la rutina
        set v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    else
        SET v_nombre_rutina = "Sin rutina asignada";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se ha insertado una nueva relación RUTINAS EJERCICIOS con los IDs: Ejercicio - ", NEW.ejercicio_ID, ", Rutina - ", NEW.Rutina_ID , 
        "con los siguientes datos: ",
        "EJERCICIO ID = ", v_nombre_ejercicio,
        "RUTINA ID = ",  v_nombre_rutina,
        "REPETICIONES = ", NEW.repeticiones, 
		"TIEMPO = ", NEW.tiempo,
        "ESTATUS = ", v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_UPDATE` AFTER UPDATE ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_ejercicio VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_ejercicio2 VARCHAR(100) DEFAULT NULL;
    DECLARE v_nombre_rutina VARCHAR(60) DEFAULT NULL;
    DECLARE v_nombre_rutina2 VARCHAR(60) DEFAULT NULL;

    -- Inicialización de las variables
    IF NEW.estatus = b'1' THEN
		SET v_cadena_estatus= "Activa";
    ELSE
		SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
		SET v_cadena_estatus2= "Activa";
    ELSE
		SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
    IF NEW.ejercicio_id IS NOT NULL THEN 
		-- En caso de tener el id del ejercicio
		SET v_nombre_ejercicio = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = NEW.ejercicio_id);
    ELSE
		SET v_nombre_ejercicio = "Sin ejercicio asignado.";
    END IF;
    
    IF OLD.ejercicio_id IS NOT NULL THEN 
		-- En caso de tener el id del ejercicio
		SET v_nombre_ejercicio2 = (SELECT CONCAT_WS(" ", e.nombre_formal, e.nombre_comun) FROM ejercicios e WHERE id = OLD.ejercicio_id);
    ELSE
		SET v_nombre_ejercicio2 = "Sin ejercicio asignado.";
    END IF;

    IF NEW.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina = (SELECT resultados_esperados FROM rutinas WHERE id = NEW.rutina_id);
    ELSE
		SET v_nombre_rutina = "Sin rutina asignada.";
    END IF;

    IF OLD.rutina_id IS NOT NULL THEN 
		-- En caso de tener el id de la rutina
		SET v_nombre_rutina2 = (SELECT resultados_esperados FROM rutinas WHERE id = OLD.rutina_id);
    ELSE
		SET v_nombre_rutina2 = "Sin rutina asignada.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se han actualizado los datos de la relación RUTINAS EJERCICIOS con los IDs: Rutina -", NEW.Rutina_ID, "Ejercicio -", NEW.Ejercicio_ID, 
        "con los siguientes datos:",
        "EJERCICIO ID  = ", v_nombre_ejercicio2, " cambio a ", v_nombre_ejercicio,
        "RUTINA ID = ",v_nombre_rutina2," cambio a ", v_nombre_rutina,
        "REPETICIONES  = ", OLD.repeticiones, " cambio a ", NEW.repeticiones,
        "TIEMPO = ",OLD.tiempo," cambio a ", NEW.tiempo,
        "ESTATUS = ", v_cadena_estatus2, " cambio a ", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rutinas_ejercicios_AFTER_DELETE` AFTER DELETE ON `rutinas_ejercicios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "rutinas_ejercicios",
        CONCAT_WS(" ","Se ha eliminado una relación RUTINAS EJERCICIOS con los IDs: Ejercicio - ", OLD.ejercicio_ID, ", Rutina - ", OLD.Rutina_ID ),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sesiones_rutinas`
--

DROP TABLE IF EXISTS `sesiones_rutinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesiones_rutinas` (
  `id_sesion` int NOT NULL,
  `id_rutina` int NOT NULL,
  `id_instructor` int NOT NULL,
  `asistencia` bit(1) NOT NULL,
  `fecha_sesion` datetime NOT NULL,
  `observaciones` text,
  PRIMARY KEY (`id_sesion`,`id_rutina`),
  UNIQUE KEY `id_rutina_UNIQUE` (`id_rutina`),
  UNIQUE KEY `id_instructor_UNIQUE` (`id_instructor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones_rutinas`
--

LOCK TABLES `sesiones_rutinas` WRITE;
/*!40000 ALTER TABLE `sesiones_rutinas` DISABLE KEYS */;
/*!40000 ALTER TABLE `sesiones_rutinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursales` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Direccion` varchar(250) NOT NULL,
  `Responsable_ID` int unsigned DEFAULT NULL,
  `Total_Clientes_Atendidos` int unsigned NOT NULL DEFAULT '0',
  `Promedio_Clientes_X_Dia` int unsigned NOT NULL DEFAULT '0',
  `Capacidad_Maxima` int unsigned NOT NULL DEFAULT '0',
  `Total_Empleados` int unsigned DEFAULT '0',
  `Horario_Disponibilidad` text NOT NULL,
  `Estatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fk_empleado_2` (`Responsable_ID`),
  CONSTRAINT `fk_empleado_2` FOREIGN KEY (`Responsable_ID`) REFERENCES `empleados` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursales`
--

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
INSERT INTO `sucursales` VALUES (1,'Xicotepec','Av. 5 de Mayo #75, Col. Centro',NULL,0,0,80,0,'08:00 a 24:00',_binary ''),(2,'Villa Ávila Camacho','Calle Asturinas #124, Col. del Rio',NULL,0,0,50,0,'08:00 a 20:00',_binary ''),(3,'San Isidro','Av. Lopez Mateoz #162 Col. Tierra Negra',NULL,1,1,90,0,'09:00 a 21:00',_binary ''),(4,'Seiva','Av. de las Torres #239, Col. Centro',NULL,0,0,50,0,'07:00 a 22:00',_binary '\0'),(5,'Huahuchinango','Calle Abasolo #25, Col.Barrio tibanco',NULL,0,0,56,0,'07:00 a 21:00',_binary '');
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_INSERT` AFTER INSERT ON `sucursales` FOR EACH ROW BEGIN
-- Declaración de variables
	DECLARE v_cadena_estatus varchar(15) default null;
    DECLARE v_nombre_responsable varchar(60) default null;
-- Iniciación de las variables
-- El estatus de la sucursal se almacena en un dato del tipo BIT, por
-- cuestiones de memoria, pero para registrar eventos en bitacora
-- se requiere ser más descriptivo con la redacción de los eventos
IF new.estatus = b'1' then
	set v_cadena_estatus = "Activa";
else
	set v_cadena_estatus = "Inactiva";
end if;

if new. responsable_id is not null then
-- En caso de tener el id del empleado responsable debemos recuperar su nombre
-- 
	set v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.responsable_id);
else
	SET v_nombre_responsable = "Sin responsable asignado";
end if;
-- Insertar en la bitacora
INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Create",
        "sucursales",
        CONCAT_WS(" ","Se ha insertado una nueva SUCURSAL con el ID: ",NEW.ID, 
        "con los siguientes datos: ",
        "NOMBRE=", NEW.nombre,
        "DIRECCION = ", NEW.direccion,
        "RESPONSABLE ID = ", v_nombre_responsable,
        "TOTAL CLIENTES ATENDIDOS = ",  NEW.total_clientes_atendidos,
        "PROMEDIO CLIENTES POR DIA = ", NEW.promedio_clientes_x_dia, 
        "CAPACIDAD MAXIMA = ", NEW.capacidad_maxima, 
        "TOTAL EMPLEADOS = ", NEW.total_empleados,
        "HORARIO DISPONIBILIDAD = ", NEW.horario_disponibilidad,
        "ESTATUS = ",  v_cadena_estatus),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_UPDATE` AFTER UPDATE ON `sucursales` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_cadena_estatus VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable VARCHAR(100) DEFAULT NULL;
    DECLARE v_cadena_estatus2 VARCHAR(15) DEFAULT NULL;
    DECLARE v_nombre_responsable2 VARCHAR(100) DEFAULT NULL;

    -- Inicialización de las variables
    -- El estatus de la sucursa se almacena en un dato del tipo BIT, por
    -- cuestiones de memorìa, pero para registrar eventos en bitacora
    -- se requiere ser más descriptivo con las readcción de los eventos. 
    IF NEW.estatus = b'1' THEN
     SET v_cadena_estatus= "Activa";
	ELSE
	 SET v_cadena_estatus= "Inactiva";
    END IF; 
    
    IF OLD.estatus = b'1' THEN
     SET v_cadena_estatus2= "Activa";
	ELSE
	 SET v_cadena_estatus2= "Inactiva";
    END IF; 
          
	IF NEW.responsable_id IS NOT NULL THEN 
    -- En caso de tener el id del empleado responsable debemos recuperar su nombre
    -- para ingresarlo en la bitacora.
	SET v_nombre_responsable = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
    p.segundo_apellido) FROM personas p WHERE id = NEW.responsable_id);
	ELSE
    SET v_nombre_responsable = "Sin responsable asingado.";
    END IF;
    
    IF OLD.responsable_id IS NOT NULL THEN 
    -- En caso de tener el id del empleado responsable debemos recuperar su nombre
    -- para ingresarlo en la bitacora.
	SET v_nombre_responsable2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido,
    p.segundo_apellido) FROM personas p WHERE id = OLD.responsable_id);
	ELSE
    SET v_nombre_responsable2 = "Sin responsable asingado.";
    END IF;
    
    
    INSERT INTO bitacora VALUES(
		DEFAULT,
		USER(),
        "Update",
        "sucursales",
        CONCAT_WS(" ","Se ha modificado una SUCURSAL  existente con el ID: ",
        NEW.ID, "con los siguientes datos: NOMBRE =", OLD.nombre,"cambio a",NEW.nombre,
        "DIRECCION =", OLD.direccion,"cambio a",NEW.direccion,
        "RESPONSABLE = ", v_nombre_responsable2, "cambio a", v_nombre_responsable,
        "TOTAL CLIENTES ATENDIDOS  =",OLD.total_clientes_atendidos,"cambio a", NEW.total_clientes_atendidos,
        "PROMEDIO DE CLIENTES POR DIA =", OLD.promedio_clientes_x_dia,"cambio a",NEW.promedio_clientes_x_dia, 
        "CAPACIDAD MÀXIMA =", OLD.capacidad_maxima,"cambio a", NEW.capacidad_maxima,
        "TOTAL EMPLEADOS =", OLD.total_empleados, "cambio a", NEW.total_empleados,
        "HORARIO_DISPONIBILIDAD =", OLD.horario_disponibilidad, "cambio a", NEW.horario_disponibilidad, 
        "ESTATUS = ", v_cadena_estatus2, "cambio a", v_cadena_estatus),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sucursales_AFTER_DELETE` AFTER DELETE ON `sucursales` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "sucursales",
        CONCAT_WS(" ","Se ha eliminado una SUCURSAL con el ID: ", OLD.ID),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `Persona_ID` int unsigned NOT NULL,
  `Nombre_Usuario` int NOT NULL,
  `Password` blob,
  `Tipo` enum('Empleado','Visitante','Miembro','Instructor') DEFAULT NULL,
  `Estatus_Conexion` enum('Online','Offline','Banned') DEFAULT NULL,
  `Ultima_Conexion` datetime DEFAULT NULL,
  PRIMARY KEY (`Persona_ID`),
  UNIQUE KEY `Nombre_Usuario` (`Nombre_Usuario`),
  CONSTRAINT `fk_persona_3` FOREIGN KEY (`Persona_ID`) REFERENCES `personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_INSERT` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;

    -- Iniciación de las variables
    if new.nombre_usuario is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.nombre_usuario);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;

    -- Insertar en la bitacora
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Create",
        "usuarios",
        CONCAT_WS(" ","Se ha insertado un nuevo USUARIO con el ID: ",NEW.persona_id, 
        "con los siguientes datos: ",
        "NOMBRE USUARIO= ", v_nombre_usuario,
        "PASSWORD = ", NEW.password,
        "TIPO = ", NEW.tipo,
        "ESTATUS CONEXIÓN = ", NEW.estatus_conexion,
        "ULTIMA CONEXIÓN = ", NEW.ultima_conexion),
        NOW(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_UPDATE` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
	-- Declaración de variables
    DECLARE v_nombre_usuario varchar(60) default null;
    DECLARE v_nombre_usuario2 varchar(60) default null;

    -- Iniciación de las variables
    if new.nombre_usuario is not null then
        -- En caso de tener el id del usuario debemos recuperar su nombre
        set v_nombre_usuario = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_Apellido) FROM personas p WHERE id = NEW.nombre_usuario);
    else
        SET v_nombre_usuario = "Sin usuario asignado";
    end if;
    
    IF OLD.nombre_usuario IS NOT NULL THEN 
		-- En caso de tener el id del usuario debemos recuperar su nombre
		SET v_nombre_usuario2 = (SELECT CONCAT_WS(" ", p.titulo_cortesia, p.nombre, p.primer_apellido, p.segundo_apellido) FROM personas p WHERE id = OLD.nombre_usuario);
    ELSE
		SET v_nombre_usuario2 = "Sin responsable asignado.";
    END IF;
    
    INSERT INTO bitacora VALUES(
        DEFAULT,
        USER(),
        "Update",
        "usuarios",
        CONCAT_WS(" ","Se han actualizado los datos del USUARIO con el ID: ",
        NEW.persona_id, "con los siguientes datos:",
        "NOMBRE USUARIO = ", v_nombre_usuario2, "cambio a", v_nombre_usuario,
        "PASSWORD =",OLD.password,"cambio a", NEW.password,
        "TIPO = ", OLD.tipo, "cambio a", NEW.tipo,
        "ESTATUS CONEXIÓN = ", OLD.estatus_conexion, "cambio a", NEW.estatus_conexion,
        "ULTIMA CONEXIÓN = ", OLD.ultima_conexion, "cambio a", NEW.ultima_conexion),
        NOW(),
        DEFAULT       
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_DELETE` AFTER DELETE ON `usuarios` FOR EACH ROW BEGIN
	INSERT INTO bitacora VALUES(
		DEFAULT,
        USER(),
        "Delete",
        "usuarios",
        CONCAT_WS(" ","Se ha eliminado un USUARIO con el ID: ", OLD.persona_id),
        now(),
        DEFAULT
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vw_genero_empleados_miembros`
--

DROP TABLE IF EXISTS `vw_genero_empleados_miembros`;
/*!50001 DROP VIEW IF EXISTS `vw_genero_empleados_miembros`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_genero_empleados_miembros` AS SELECT 
 1 AS `Tipo`,
 1 AS `genero`,
 1 AS `Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_genero_membresias`
--

DROP TABLE IF EXISTS `vw_genero_membresias`;
/*!50001 DROP VIEW IF EXISTS `vw_genero_membresias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_genero_membresias` AS SELECT 
 1 AS `tipo`,
 1 AS `genero`,
 1 AS `count(*)`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_personas_por_genero`
--

DROP TABLE IF EXISTS `vw_personas_por_genero`;
/*!50001 DROP VIEW IF EXISTS `vw_personas_por_genero`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_personas_por_genero` AS SELECT 
 1 AS `genero`,
 1 AS `count(*)`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'bd_gimnasio_210115'
--

--
-- Dumping routines for database 'bd_gimnasio_210115'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_calcular_fin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcular_fin`(fecha_inicio DATETIME, v_tipo_plan VARCHAR(255)) RETURNS datetime
    DETERMINISTIC
BEGIN
  DECLARE fecha_final DATETIME;

  SET fecha_final = 
    CASE v_tipo_plan
      WHEN "Anual" THEN DATE_ADD(fecha_inicio, INTERVAL 1 YEAR)
      WHEN "Semestral" THEN DATE_ADD(fecha_inicio, INTERVAL 6 MONTH)
      WHEN "Trimestral" THEN DATE_ADD(fecha_inicio, INTERVAL 3 MONTH)
      WHEN "Bimestral" THEN DATE_ADD(fecha_inicio, INTERVAL 2 MONTH)
      WHEN "Mensual" THEN DATE_ADD(fecha_inicio, INTERVAL 1 MONTH)
      WHEN "Semanal" THEN DATE_ADD(fecha_inicio, INTERVAL 1 WEEK)
      WHEN "Diaria" THEN DATE_ADD(fecha_inicio, INTERVAL 1 DAY)
      ELSE fecha_inicio
    END;

  RETURN fecha_final;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_calcula_antiguedad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcula_antiguedad`(fecha DATE) RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE fecha_actual date;
    DECLARE anios INT;
    DECLARE meses INT;
    DECLARE semanas INT;
    DECLARE dias INT;
    DECLARE edad VARCHAR(200);
    
    -- Obtenemos la fecla actual
    SET fecha_actual = CURDATE();
    
    -- Calculamos la diferencia en años, mese, semanas, y dias
    SET anios = TIMESTAMPDIFF(YEAR, fecha, fecha_actual);
    SET meses = TIMESTAMPDIFF(MONTH, fecha, fecha_actual) - (12 * anios);
    SET dias = DATEDIFF(fecha_actual, DATE_ADD(fecha, INTERVAL anios YEAR) + INTERVAL meses MONTH);
    SET semanas = dias / 7;
    SET dias = dias % 7;
    
    -- Construimos el mensaje de la edad
    SET edad = concat_ws(" ", anios, "años, ", meses, "meses, ", semanas, "semanas y ", dias, "dias");
RETURN edad;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_calcula_edad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calcula_edad`(v_fecha_nacimiento date) RETURNS int
    DETERMINISTIC
BEGIN
RETURN timestampdiff(year, v_fecha_nacimiento, curdate());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_generar_codigo_aleatorio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_generar_codigo_aleatorio`(longitud INT) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
  DECLARE codigo_aleatorio VARCHAR(255) DEFAULT '';
  DECLARE caracteres VARCHAR(62) DEFAULT '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  DECLARE i INT DEFAULT 0;
  
  WHILE i < longitud DO
    SET codigo_aleatorio = CONCAT(codigo_aleatorio, SUBSTRING(caracteres, FLOOR(RAND() * LENGTH(caracteres)) + 1, 1));
    SET i = i + 1;
  END WHILE;
  
  RETURN codigo_aleatorio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_generar_contrasena_aleatoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_generar_contrasena_aleatoria`() RETURNS blob
    DETERMINISTIC
BEGIN
	DECLARE v_contrasena VARCHAR(255);
    DECLARE v_contrasena_blob BLOB;
  
	-- Genera una contraseña aleatoria
	SET v_contrasena = SUBSTRING(MD5(RAND()) FROM 1 FOR 8);

	-- Convierte la contraseña a BLOB
	SET v_contrasena_blob = UNHEX(SHA2(v_contrasena, 256));
RETURN v_contrasena_blob;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_Apellido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_Apellido`() RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_apellido_generado varchar(60) default null; 
	SET v_apellido_generado = ELT (fn_numero_aleatorio_rangos(1,50),
	"Hernández","García", "Martínez", "López"," González",
	"Pérez","Rodríguez", "Sánchez", "Ramírez","Cruz",
	"Cortes","Gómes","Morales", "Vázquez","Reyes",
	"Jiménez","Torres","Díaz", "Gutiérrez","Ruíz",
	"Mendoza","Aguilar","Ortiz","Moreno","Castillo",
	"Romero","Álvarez", "Méndez", "Chávez"," Rivera",
	"Juárez","Ramos", "Domínguez", "Herrera","Medina",
	"Castro","Vargas","Guzmán", "Velázquez","De la Cruz",
	"Contreras","Salazar","Luna", "Ortega","Santiago",
	"Guerrero","Estrada","Bautista","Cortés","Soto");
RETURN v_apellido_generado;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_bandera_porcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_bandera_porcentaje`(porcentaje int) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE num_generado int default 0;
    DECLARE bandera BOOLEAN;
	set num_generado = fn_numero_aleatorio_rangos(0, 100);
    
    if  num_generado <= porcentaje then
		set bandera = true;
	else 
		set bandera = false;
	end if;
 return bandera;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha`(fecha_inicio date, fecha_fin date) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE dia int default null; 
	DECLARE mes int default null; 
	DECLARE anio int default null; 
	DECLARE fecha date default null;
    SET dia = fn_numero_aleatorio_rangos (EXTRACT(DAY FROM fecha_inicio),EXTRACT(DAY FROM fecha_fin));
    SET mes = fn_numero_aleatorio_rangos (EXTRACT(MONTH  FROM fecha_inicio),EXTRACT(MONTH  FROM fecha_fin));
    SET anio = fn_numero_aleatorio_rangos (EXTRACT(YEAR  FROM fecha_inicio),EXTRACT(YEAR  FROM fecha_fin));
    set fecha = concat(anio,'-',mes,'-',dia);
RETURN fecha;
RETURN 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha_nacimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha_nacimiento`(fecha_inicio date, fecha_fin date) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE min_dias INT;
    DECLARE max_dias INT;
    DECLARE dias_aleatorios INT;
    DECLARE fecha_aleatoria DATE;
    
    set min_dias = datediff(fecha_inicio, '1900-01-01');
    set max_dias = datediff(fecha_fin, '1900-01-01');
    set dias_aleatorios = fn_numero_aleatorio_rangos(min_dias, max_dias);
    set fecha_aleatoria = date_add( '1900-01-01', interval dias_aleatorios DAY);
RETURN fecha_aleatoria;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_fecha_registro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_fecha_registro`(fechaInicio date, fechaFin date, horaInicio time, horaFin time) RETURNS datetime
    DETERMINISTIC
BEGIN
	DECLARE fechaAleatoria DATE;
	DECLARE horaEntrada time;
    DECLARE horaSalida time;   
	DECLARE horaRegistro time;
	DECLARE fechaHoraGenerada datetime;
    
    SET fechaAleatoria = date_add(fechaInicio, INTERVAL floor(rand() * (datediff(fechaFin, fechaInicio) + 1)) DAY);
    
    SET horaRegistro = addtime(horaInicio, SEC_TO_TIME(FLOOR(RAND() * TIME_TO_SEC(TIMEDIFF(horaFin, horaInicio)))));
    
    set fechaHoraGenerada = concat(fechaAleatoria, " ", horaRegistro);
RETURN fechaHoraGenerada;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_nombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_nombre`(v_genero CHAR(1)) RETURNS varchar(60) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_nombre_generado varchar(60) default null; 
	if v_genero = 'M' THEN 
		SET v_nombre_generado = ELT (fn_numero_aleatorio_rangos(1,25),
        "Marco","Juan", "Pedro", "Alejandro"," Agustin",
        "Ricardo","Gustavo", "Gerardo", "Hugo","Adalid",
        "Mario","Jesus","Yair", "Adan","Maximiliano",
        "Aldair","José","Edgar", "Jorge","Iram",
        "Carlos","Federico","Fernando","Samuel","Daniel");
	else
		SET v_nombre_generado = ELT (fn_numero_aleatorio_rangos(1,25),
        "Lorena","Maria","Luz", "Dulce","Suri",
        "Ameli","Ana","Karla","Carmen","Alondra",
        "Bertha", "Diana","Jazmin","Hortencia", "Guadalupe",
        "Estrella","Monica", "Paola","Brenda", "Flor",
        "Lucía","Sofia","Paula","Valeria","Esmeralda");
	END IF;
RETURN v_nombre_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_sangre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_sangre`() RETURNS varchar(10) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE v_sangre_generado varchar(10) default null; 
	SET v_sangre_generado = ELT (fn_numero_aleatorio_rangos(1,8),
	"A+","A-","B+","B-","AB+","AB-","O+","O-");
RETURN v_sangre_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_titulo_cortesia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_titulo_cortesia`(v_genero CHAR(1) ) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
-- función de insertar personas
	declare  v_titulo varchar(20) default null;
    
	if v_genero = 'M' then
		set v_titulo = ELT(fn_numero_aleatorio_rangos(1,10), 
		"Ing.","Sr.", "Joven","Mtro.","Lic.",
		"Med.", "Sgto.", "Tnte.", "C.", "C.P.");
	else
		set v_titulo = ELT(fn_numero_aleatorio_rangos(1,10), 
		"Sra.","Srita", "Dra.","Mtra","Med.",
		"Ing.", "Lic.", "C.", "C.P.", "Pfra");
	end if;
	

RETURN v_titulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_genera_vandera_porcentaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_genera_vandera_porcentaje`(porcentaje int) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE num_generado int default 0;
    DECLARE bandera BOOLEAN;
	set num_generado = fn_numero_aleatorio_rangos(0, 100);
    
    if  num_generado <= porcentaje then
		set bandera = true;
	else 
		set bandera = false;
	end if;
 return bandera;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_numero_aleatorio_rangos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_numero_aleatorio_rangos`(v_limite_inferior int, v_limite_superior int) RETURNS int
    DETERMINISTIC
BEGIN	
	declare v_numero_generado INT 
    default floor(Rand()* (v_limite_superior - v_limite_inferior + 1) + v_limite_inferior);
    SET @numero_generado = v_numero_generado;
RETURN v_numero_generado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Saludar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Saludar`() RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE saludo VARCHAR(50);
	SET saludo = '¡Hola!';
	RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarHora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarHora`(nombre VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE hora INT;
    DECLARE saludo VARCHAR(100);
    
    SET hora = HOUR(now());
	IF hora >= 6 AND hora< 12 THEN
        SET saludo = CONCAT('¡Buenos días ', nombre,'!');
    ELSEIF hora >= 12 AND hora < 18 THEN
        SET saludo = CONCAT('¡Buenas tardes ', nombre,'!');
    ELSE
        SET saludo = CONCAT('¡Buenas noches ', nombre,'!');
    END IF;
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarHoraEspecifica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarHoraEspecifica`(nombre VARCHAR(50), hora TIME) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE saludo VARCHAR(100);
    IF HOUR(hora) >= 6 AND HOUR(hora) < 12 THEN
        SET saludo = CONCAT('¡Buenos días ', nombre,'!');
    ELSEIF HOUR(hora) >= 12 AND HOUR(hora) < 18 THEN
        SET saludo = CONCAT('¡Buenas tardes ', nombre,'!');
    ELSE
        SET saludo = CONCAT('¡Buenas noches ', nombre,'!');
    END IF;
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SaludarNombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `SaludarNombre`(nombre VARCHAR(50)) RETURNS varchar(100) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE saludo VARCHAR(100);
    SET saludo = CONCAT('¡Hola ', nombre, '! ');
    RETURN saludo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_estatus_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_estatus_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "qwerty" then 
		(SELECT "areas" as Tabla, "Débil, Catálogo", (SELECT COUNT(*) FROM areas) as Total_Registros)
        UNION
        (SELECT "detalles_pedidos" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM detalles_pedidos))
        UNION
        (SELECT "detalles_programas_saludables" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM detalles_programas_saludables))
        UNION
        (SELECT "dietas" as Tabla, "Devil", (SELECT COUNT(*) FROM dietas))
        UNION
        (SELECT "ejercicios" as Tabla, "Fuerte, Catálogo", (SELECT COUNT(*) FROM ejercicios))
        UNION
        (SELECT "empleados" as Tabla, "Débil", (SELECT COUNT(*) FROM empleados))
        UNION
        (SELECT "equipos" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM equipos))
        UNION
        (SELECT "equipos_existencias" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM equipos_existencias))
        UNION
        (SELECT "instructores" as Tabla, "Débil", (SELECT COUNT(*) FROM instructores))
        UNION
        (SELECT "membresias_usuarios" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM membresias_usuarios))
        UNION
        (SELECT "membresias" as Tabla, "Débil", (SELECT COUNT(*) FROM membresias))
        UNION
        (SELECT "miembros" as Tabla, "Débil", (SELECT COUNT(*) FROM miembros))
        UNION
        (SELECT "pedidos" as Tabla, "Débil", (SELECT COUNT(*) FROM pedidos))
        UNION
        (SELECT "personas" as Tabla, "Fuerte", (SELECT COUNT(*) FROM personas))
        UNION
        (SELECT "productos" as Tabla, "Fuerte", (SELECT COUNT(*) FROM productos))
        UNION
        (SELECT "programas_saludables" as Tabla, "Débil", (SELECT COUNT(*) FROM programas_saludables))
        UNION
        (SELECT "rutinas" as Tabla, "Débil", (SELECT COUNT(*) FROM rutinas))
        UNION
        (SELECT "rutinas_ejercicios" as Tabla, "Débil, Derivada", (SELECT COUNT(*) FROM rutinas_ejercicios))
        UNION
        (SELECT "sucursales" as Tabla, "Débil, Catálogo", (SELECT COUNT(*) FROM sucursales))
        UNION
        (SELECT "usuarios" as Tabla, "Débil", (SELECT COUNT(*) FROM usuarios))
        UNION
        (SELECT "bitacora" as Tabla, "Isla", (SELECT COUNT(*) FROM bitacora));
	else
		select "La contraseña es incorrecta, no puedo mostrar el estatus de la BD" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_empleados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_empleados`(v_cuantos int, v_tipo varchar(15))
BEGIN
	DECLARE i INT default 1;
    DECLARE v_id_persona INT;
    DECLARE v_id_sucursal INT;
	DECLARE v_pos_sucursal INT DEFAULT 0;
    -- debemos conocer el total de sucursales activas
	DECLARE v_total_sucursales INT DEFAULT (select count(*) FROM sucursales WHERE estatus = b'1');
    
    DECLARE v_id_area INT;
    DECLARE v_pos_area INT DEFAULT 0;
    -- 
    DECLARE v_total_areas INT default null;
    DECLARE v_numero_empleados_sucursal INT default null;
	
    -- Para elegir a la sucursal a la que se le dasignara
    while i <= v_cuantos do
		-- Insertar los datos del la persona
        SET v_tipo = null;
        call sp_inserta_personas(1);
        set v_id_persona = last_insert_id();
        
        -- Determina la sucursal a la que pertenece el empleado
        sucursal:LOOP
        if v_total_sucursales > 1 then
			set v_pos_sucursal  = fn_numero_aleatorio_rangos(0, v_total_sucursales-1);
            SET v_id_sucursal = (SELECT id FROM sucursales LIMIT v_pos_sucursal,1);
            
            -- como ya se que sucursal, calcular el area a ala que le trabaja
            SET v_total_areas = (SELECT count(*) FROM areas WHERE sucursal_id = v_id_sucursal AND estatus = b'1');
            -- calcular el total de empleados de la sucursal
            SET v_numero_empleados_sucursal = (SELECT COUNT(*) FROM empleados WHERE sucursal_id = v_id_sucursal);
            
            -- si la sucursal no tiene areas, elegir una de las de la matriz
            IF v_total_areas = 0 THEN 
				set v_total_areas = (SELECT COUNT(*) FROM areas WHERE sucursal_id = 1 AND estatus = b'1');
                SET v_pos_area = fn_numero_aleatorio_rangos(0,v_total_areas-1);
                SET v_id_area = (SELECT id FROM areas WHERE  sucursal_id = 1 LIMIT v_pos_area,1);
            ELSE
				SET v_pos_area = fn_numero_aleatorio_rangos(0,v_total_areas-1);
                SET v_id_area = (SELECT id FROM areas WHERE  sucursal_id = v_id_sucursal LIMIT v_pos_area,1);
            END IF;
            LEAVE sucursal;
		ELSE 
			SELECT ("Al menos debería existir 1 sucursal") as MensajeError;
            LEAVE sucursal;
        end if;
        end loop;
        
        -- En caso de que no se diga que tipo de empleado creamos, se elige uno aleatorio
        if v_tipo IS NULL THEN
			set v_tipo = ELT(fn_numero_aleatorio_rangos(1,5), "Instructor","Administrativo","Intendecia", "Area Medicá","Directivo");
        END IF;
        
        -- Ya que se tiene todos los datos del trabajador insertar en la subentidad
        INSERT INTO empleados VALUES(v_id_persona,
									 v_tipo,
                                     v_id_area,
                                     v_numero_empleados_sucursal+1,
                                     v_id_sucursal,
                                     fn_genera_fecha_registro("2015-01-01", CURDATE(), "08:00:00", "20:00:00"));
        
		set i = i+1;
    end while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_membresias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_membresias`(v_cuantos INT, v_tipo varchar(20))
    DETERMINISTIC
BEGIN
	 -- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_persona INT;
	DECLARE v_lim_miembros INT;
    DECLARE v_id_membresia INT;
    DECLARE v_tipo_servicios VARCHAR(10);
    DECLARE v_tipo_plan VARCHAR(10);
    DECLARE v_nivel VARCHAR(10);
    DECLARE v_codigo varchar(50);
    DECLARE v_aleatorio BIT DEFAULT b'0';
    DECLARE v_fecha_inicio datetime default NULL;
    DECLARE v_fecha_fin DATETIME default NULL;
    DECLARE v_fecha_registro DATETIME DEFAULT NULL;
    
    -- Determinar si la membresia creada sera aleatoria
    IF v_tipo IS NULL THEN
		SET v_aleatorio = b'1';
    END IF;
    
    while i <= v_cuantos do
		IF v_aleatorio = b'1' THEN
            set v_tipo = ELT(fn_numero_aleatorio_rangos(1,3), "Individual","Familiar","Empresarial");
        END IF;
        
        SET v_tipo_servicios = NULL;
		SET v_tipo_plan = NULL;
		SET v_nivel = NULL;
        SET v_codigo = NULL;
        
        -- INSERTAR EN MEMBRESIAS, LUEGO PERSONAS, LUEGO USUARIOS, TAL VEZ EN MIEMBROS, MEMBRESIAS_USUARIOS
        
        CASE v_tipo
		  WHEN "Individual" THEN SET v_lim_miembros=1;
		  WHEN "Familiar" THEN SET v_lim_miembros= fn_numero_aleatorio_rangos(1,5);
		  WHEN "Empresarial" THEN SET v_lim_miembros = fn_numero_aleatorio_rangos(10,50);
          ELSE SET  v_lim_miembros=1;
		END case;
        
        -- Calcular el servicio aleoatoriamente
        if v_tipo_servicios IS NULL THEN
			set v_tipo_servicios = ELT(fn_numero_aleatorio_rangos(1,4), "Basicos","Completa","Coaching", "Nutriólogo");
        END IF;
        
        -- Calcular el codigo aleatoriamente
        IF v_codigo IS NULL THEN
			SET v_codigo = fn_generar_codigo_aleatorio(50);
        END IF;
        
        -- Calcular el plan aleatoriamente
        if v_tipo_plan IS NULL THEN
			set v_tipo_plan = ELT(fn_numero_aleatorio_rangos(1,7), "Anual","Semestral","Trimestral", "Bimestral", "Mensual", "Semanal", "Diaria");
        END IF;
        
        -- Calculamos la fecha de inicio de la membresia
        set v_fecha_inicio = fn_genera_fecha_registro("2015-01-01", CURDATE(), "08:00:00", "20:00:00");
        
        -- Culamos la fecha del fin de la membresia
        SET v_fecha_fin = fn_calcular_fin(v_fecha_inicio, v_tipo_plan);
        
        -- Calcular el nivel aleatoriamente
        if v_nivel IS NULL THEN
			set v_nivel = ELT(fn_numero_aleatorio_rangos(1,4), "Nuevo","Plata","Oro", "Diamante");
        END IF;
        
        -- Ingresamos la fecha de registro
        SET v_fecha_registro = v_fecha_inicio;
        
		-- Ya que se tiene todos los datos del usuario se inserta en la subentidad
        INSERT INTO membresias VALUES (default,
									   v_codigo,
									   v_tipo,
									   v_tipo_servicios,
									   v_tipo_plan,
                                       v_nivel,
                                       v_fecha_inicio,
                                       v_fecha_fin,
                                       default,
                                       v_fecha_registro,
                                       null);

		-- Obtenemos el ID de la membresia
		set v_id_membresia = last_insert_id();

        -- Insertamos en las relaciones
        call sp_inserta_membresias_usuarios(v_lim_miembros,v_id_membresia);

		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_membresias_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_membresias_usuarios`(v_cuantos int,v_id_membresia int)
    DETERMINISTIC
BEGIN
	-- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_usuario int;
	DECLARE v_fecha_conexion DATETIME;
    
    while i <= v_cuantos do
		call sp_inserta_miembros(1, null);
		set v_id_usuario = last_insert_id();
		-- Revisando la fecha de la ultima conexión
		SET v_fecha_conexion = (SELECT ultima_conexion from usuarios where persona_id = v_id_usuario );
		
		-- Insertar los datos
		INSERT INTO membresias_usuarios values (v_id_membresia,
												v_id_usuario,
												v_fecha_conexion,
												default);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_miembros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_miembros`(v_cuantos int, v_tipo varchar(15))
BEGIN
    -- Declaración de variables
    DECLARE i INT default 1;
    DECLARE v_id_persona INT;
    DECLARE v_tiempo DATETIME;
    DECLARE v_antiguedad VARCHAR(80);
    
    -- debemos conocer el total de personas activas
    DECLARE v_total_personas INT DEFAULT (select count(*) FROM personas WHERE estatus = b'1');
    
	while i <= v_cuantos do
		SET v_tipo = NULL;
        SET v_tiempo = NULL;
		
        -- obtener un id que no este repetido
        
        call sp_inserta_usuarios(1, null);
        set v_id_persona = last_insert_id();
        
        -- En caso de que no se diga que tipo de miembro creamos, se elige uno aleatorio
        if v_tipo IS NULL THEN
            set v_tipo = ELT(fn_numero_aleatorio_rangos(1,5), "Frecuente","Ocasional","Nuevo", "Esporádico","Una sola visita");
        END IF;
        
        personas:LOOP
        SET v_tiempo = (SELECT Fecha_Registro FROM personas WHERE ID=v_id_persona); 
		
		if TIMESTAMPDIFF(YEAR,v_tiempo,CURDATE()) < 1 THEN 
			SET v_antiguedad = concat_ws(" ", 'Miembro nuevo con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
		ELSEIF TIMESTAMPDIFF(YEAR,v_tiempo,CURDATE()) BETWEEN 1 AND 3 THEN 
			SET v_antiguedad = concat_ws(" ", 'Miembro regular con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
		ELSE 
			SET v_antiguedad = concat_ws(" ", 'Miembro antiguo con ',fn_calcula_antiguedad(v_tiempo) );
            LEAVE personas;
        END IF;
        END LOOP;

        -- Ya que se tiene todos los datos del usuario se inserta en la subentidad
        INSERT INTO miembros VALUES (v_id_persona,
									 v_tipo,
                                     default,
                                     v_antiguedad);
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_personas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_personas`(v_cuantos INT)
    DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE v_genero CHAR(1) default NULL;
    
    DECLARE v_titulo_porcentaje boolean DEFAULT NULL;
    declare  v_titulo varchar(20) default null;
    
    DECLARE v_fecha_actual DATE;
    DECLARE v_fecha_limite_16 DATE;
    DECLARE v_fecha_limite_65 DATE;
    declare v_fecha_inicio_registro date;
    declare v_fecha_fin_registro date;
    DECLARE v_horario_inicio_registro TIME;
    DECLARE v_horario_fin_registro TIME;
    
    set v_fecha_actual = curdate();
    set v_fecha_limite_16 = date_sub(v_fecha_actual, INTERVAL 16 YEAR);
	set v_fecha_limite_65 = date_sub(v_fecha_actual, INTERVAL 65 YEAR);
    
    -- considerando que el gimnasio empezo a funcionar el 01 de Enero de 2020 y que continua en operación
    SET v_fecha_inicio_registro = "2020-01-01";
    SET v_fecha_fin_registro = curdate();
    -- considera que el área de membresias 
    set v_horario_inicio_registro = "08:00:00";
    set v_horario_fin_registro = "20:00:00";
    
    while i <= v_cuantos DO
		set v_titulo_porcentaje= fn_genera_bandera_porcentaje(20);
        SET v_genero = ELT (fn_numero_aleatorio_rangos(1,2),"M","F");
        if v_titulo_porcentaje then
			set v_titulo = fn_genera_titulo_cortesia(v_genero);
		end if;
        
		INSERT INTO personas VALUES (
		default,
		v_titulo,
		fn_genera_nombre(v_genero),
		fn_genera_Apellido(),
		fn_genera_Apellido(),
        fn_genera_fecha_nacimiento(v_fecha_limite_65,v_fecha_limite_16),
		null,
		v_genero,
		fn_genera_sangre(),
		default,
		fn_genera_fecha_registro(v_fecha_inicio_registro, v_fecha_fin_registro, v_horario_inicio_registro,v_horario_fin_registro),
		NULL);
        set v_titulo = null;
        SET i = i +1;
	END while;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_usuarios`(v_cuantos int, v_tipo varchar(15))
    DETERMINISTIC
BEGIN
	DECLARE i INT default 1;
    DECLARE v_aleatorio BIT default b'0';
    DECLARE v_estatus_conexion varchar(50) DEFAULT NULL;
    DECLARE v_id_persona INT;
    
    IF v_tipo IS NULL THEN
		SET v_aleatorio = b'1';
    END IF;
    
    while i <= v_cuantos do
		-- SELECT concat("Entrando en el ciclo #", i) as MensajeError;
		IF v_aleatorio = b'1' then
			SET v_tipo = null;
			SET v_estatus_conexion = NULL;
		END IF;
		
		call sp_inserta_personas(1);
		set v_id_persona = last_insert_id();
		
		-- En caso de que no se diga que tipo de empleado creamos, se elige uno aleatorio
		if v_tipo IS NULL THEN
			set v_tipo = ELT(fn_numero_aleatorio_rangos(1,4), "Empleado","Visitante","Miembro", "Instructor");
		END IF;
		
		-- En caso de que no se diga la ultima conexión, se elige uno aleatorio
		if v_estatus_conexion IS NULL THEN
			set v_estatus_conexion = ELT(fn_numero_aleatorio_rangos(1,3), "Online","Offline","Banned");
		END IF;
		
		-- Ya que se tiene todos los datos del trabajador insertar en la subentidad
		INSERT INTO usuarios VALUES(v_id_persona,
									 v_id_persona,
									 default,
									 v_tipo,
									 v_estatus_conexion,
									 fn_genera_fecha_registro( (SELECT fecha_registro FROM personas WHERE id= v_id_persona), CURDATE(), "08:00:00", "20:00:00"));
		set i = i+1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_limpia_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_limpia_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "qwerty" then 
		-- Antes de poder eliminart a las personas tengo que asegurarme que ninguna sucurse
        UPDATE sucursales set responsable_id = null;
        -- Despues de haber eliminado a los responsables de las sucursales, eliminamos a los empleados
        delete from empleados;
        
        -- eliminamos los mienbros 
        -- UPDATE miembros set persona_id = null;
        delete from miembros;
        
        -- eliminamos la relación de membresias y usuarios
        delete from membresias_usuarios;
        
        -- eliminamos las membresias 
        delete from membresias;
        ALTER TABLE membresias AUTO_INCREMENT = 1;
        
        -- eliminamos los usuarios 
		-- UPDATE usuarios set nombre_usuario = null;
        delete from usuarios;
        
        -- entonces procedemos alimpiar a las personas
		delete from personas;
        ALTER TABLE personas AUTO_INCREMENT = 1;
	else
		select "La contraseña es incorrecta" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_poblar_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_poblar_bd`(v_password varchar(10))
    DETERMINISTIC
BEGIN
	if v_password = "qwerty" then 
		call sp_inserta_empleados(182, null);
        CALL sp_inserta_membresias(55, null);
		CALL sp_inserta_membresias(20, 'Individual');
		CALL sp_inserta_membresias(116, 'Familiar');
		CALL sp_inserta_membresias(12, 'Empresarial');
	else
		select "La contraseña es incorrecta, no se poblo la BD" as Mensaje;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `edad`
--

/*!50001 DROP VIEW IF EXISTS `edad`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `edad` AS select (case when (`FN_CALCULA_EDAD`(`personas`.`Fecha_Nacimiento`) between 0 and 17) then 'Menor de 18' when (`FN_CALCULA_EDAD`(`personas`.`Fecha_Nacimiento`) between 18 and 29) then '18-29' when (`FN_CALCULA_EDAD`(`personas`.`Fecha_Nacimiento`) between 30 and 49) then '30-49' when (`FN_CALCULA_EDAD`(`personas`.`Fecha_Nacimiento`) >= 50) then '50 o más' end) AS `grupo_edad`,`personas`.`Genero` AS `genero`,count(0) AS `total_personas` from `personas` where (`personas`.`Genero` in ('M','F')) group by `grupo_edad`,`personas`.`Genero` order by (case when (`grupo_edad` = 'Menor de 18') then 1 when (`grupo_edad` = '18-29') then 2 when (`grupo_edad` = '30-49') then 3 when (`grupo_edad` = '50 o más') then 4 end),`personas`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_genero_empleados_miembros`
--

/*!50001 DROP VIEW IF EXISTS `vw_genero_empleados_miembros`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_genero_empleados_miembros` AS select 'Empleados' AS `Tipo`,`personas`.`Genero` AS `genero`,count(0) AS `Total` from (`empleados` join `personas` on((`personas`.`ID` = `empleados`.`Persona_ID`))) group by `personas`.`Genero` union select 'Clientes' AS `Tipo`,`personas`.`Genero` AS `genero`,count(0) AS `Total` from (`miembros` join `personas` on((`personas`.`ID` = `miembros`.`Persona_ID`))) group by `personas`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_genero_membresias`
--

/*!50001 DROP VIEW IF EXISTS `vw_genero_membresias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_genero_membresias` AS select `m`.`Tipo` AS `tipo`,`p`.`Genero` AS `genero`,count(0) AS `count(*)` from ((((`personas` `p` join `usuarios` `u` on((`p`.`ID` = `u`.`Persona_ID`))) join `miembros` `mi` on((`mi`.`Persona_ID` = `p`.`ID`))) join `membresias_usuarios` `mu` on((`mu`.`Usuarios_ID` = `p`.`ID`))) join `membresias` `m` on((`mu`.`Membresia_ID` = `m`.`ID`))) where (`mi`.`Membresia_Activa` = 0x01) group by `m`.`Tipo`,`p`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_personas_por_genero`
--

/*!50001 DROP VIEW IF EXISTS `vw_personas_por_genero`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_personas_por_genero` AS select `personas`.`Genero` AS `genero`,count(0) AS `count(*)` from `personas` group by `personas`.`Genero` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-24 23:05:01
