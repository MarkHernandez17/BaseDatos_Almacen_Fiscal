create database Proyecto_AlmacenFiscal
use Proyecto_AlmacenFiscal
--Mark Bryan Hernandez Esquivel. Proyecto sobre base de  datos de un Almacen Fiscal.

--Esta DataBase va a contar con tres tablas muy importntes , las cuales son empleados ,Empresas Exportadoras y Productos.
--A continacion iniciamos el codigo con la creacion de la tabla empleados la cual cuenta como llave primaria id_empleado.
CREATE TABLE Empleados (

id_empleado      char(8) primary key,
cedula_juridica    int,
nombre             character(50) not null,
telefono           int not null,
correo_electrónico character(50),
puesto             character(15) not null
 
);
go
-- Procedimoscon la creacion de la tabla Empresas importadoras, con su respectiva llave primaria que seria id_empresa.
CREATE TABLE Empresas_importadoras (

id_empresa          char(8) primary key,
nombre_empresa      character(50)not null,
telefono            int not null,
fax                 int,
correo_electrónico  character(50) not null

); 
go
--Creamos la Tabla Articulos , esta  va  a contener todos los productos que ingresen al almacen fiscal. Estos cuentan 
--con un codigo unico llamado id_articulo.
CREATE TABLE Articulos (
id_articulo         char(8) primary key,
nombre_articulo     character(50) not null,
categoria           character(50) not null,
fecha_produccion    date
);
go
-- Aca empezamos con la creacion de las tablas hijas ,  la primera seria Inventarios que va estar compuesta por propio codigo
-- unico id_inventario , instanciamos la tabla articulos para que con ella , obtengamos la informacion que posteriormente ya habiamos
-- ingresado. Y por ultimo se coloco la columna cantidad_articulo.
-- La razon por la cual no realizamos la consulta de la cantidad de articulos en articulos , es porque el sismtema va enfocado al
-- de varios almacenes , entonces a la hora de hacer una consulta de cuantas cantidades hay sobre un producto en especifico va 
--direccionada a la tabla inventraio con la que va a contar cada almacen.
CREATE TABLE Inventarios (

id_inventario     char(8) primary key,
id_articulos      char(8) not null,
cantidad_articulo int not null

); 
go

--Se crea la tabla encargado de llevar el registro de los almacenes , instanciando la tabla  inventario para llevar 
-- un mejor control de la info de la productos y la cantidad que cuantan por inventario.

CREATE TABLE Almacenes (

id_almacen          char(8) primary key,
id_inventarios      char(8) not null,
ubicación           varchar(150) not null,
telefono            int not null,
fax                 int
); 
go

--Cada Almacen dependiendo de sus caracteristicas cambia el impuesto, por ello, se creo la tabla Impuestos_Almacen
-- Esta contara con su codigo unico y tambien instanciara la tabla almacenes. Dado a que seria innecesario 
-- volver a digitar la info de los almcenes si ya contamos con ello en dicha tabla.
-- Despue de la instancia de la tabla almacenes  ingresamos la columna del costo del impuesto.

CREATE TABLE Impuestos_Almacen (

id_impuestos        char(8) primary key,   
id_almacenes         char(8) not null,
costo_impuesto     int not null


);
go

--Se creo la tabla Costo_Articulo , cuenta con cu codigo unico y se instancia la  tabla articulos.
--Se crea la columna Costoarrticulo para ingresar el el valor de cada articulo.
--En esta tabla cumple con la misma funcion que la tabla anterior, esto se decidio manejar de manera debido ,
--A	que es recomendable hacer una buena reparticion de la base de datos, sin repetir cosas que ya tenemos y
--no crear tablas enormes las cuales al realizar un leve cambio puede alterar el funcionamiento de todo el programa.

CREATE TABLE Costo_Articulos (

id_costoArti      char(8) primary key,
id_articulos       char(8) not null,
costo_articulo    int not null
);
go

-- Se creo la tabla control_ingreso,esta es el claro ejemplo de que lo que son tablas hijas.
-- Esta consta de un codigo unico
-- Esta compuesta por toda informacion relectada por la tabla empresas, almacenes y ariticulos.
--Esta fue creada para llevar un  registro/control de los empresas , el almacen y los articulos que han ingresado a sisitema.

CREATE TABLE Control_Ingreso (

Id_control          char(8) primary key,
id_empresas         char(8) not null,
id_almacenes        char(8) not null,
id_articulos        char(8)not null

); 
go

-- Se creo la tabla facturas con un codigo unico, se instancia las tablas empresas importadoras, mpuestos almacen, y la tabla de costs articulos
-- Su funcion es crear una factura al  cliente con la informacion de la empreas , la cantidad de impuestos por apagar y el costo de articulo
-- se creo  una columna con el total del costo por pagar.
CREATE TABLE Facturas(

id_factura          char(8) primary key,
id_empresas         char(8)not null,
id_impuestos        char(8) not null,
id_costoArtis       char(8) not null,
total_costo         int not null,
);
go

--Se Empiezan a crear las llaves foreneas para crear la relacion entre las tablas padres y  las hijas.

-- Se crea la llave foranea id_articulos en la tabla inventraios que va a hacer referencia a la tabla Articulos, al campo id_articulo.
alter table Inventarios
ADD FOREIGN KEY (id_articulos)REFERENCES Articulos(id_articulo);

-------------------------------------------------------------------
-- Se crea la llave foranea id_inventarios en la tabla Almacenes que va a hacer referencia a la tabla Inventarios, al campo id_inventario.

alter table Almacenes
ADD FOREIGN KEY (id_inventarios)REFERENCES Inventarios(id_inventario);

----------------------------------------------------------------
-- Se crea la llave foranea id_almacenes en la tabla Impuestos_Almacen que va a hacer referencia a la tabla Almacenes, al campo id_almacen.

alter table Impuestos_Almacen
ADD FOREIGN KEY (id_almacenes)REFERENCES Almacenes(id_almacen);

---------------------------------------------------------------
-- Se crea la llave foranea id_articulos en la tabla Costo_Articulos que va a hacer referencia a la tabla Articulos, al campo id_articulo.

alter table Costo_Articulos
ADD FOREIGN KEY (id_articulos)REFERENCES Articulos(id_articulo);

------------------------------------------------------------
-- Se crea la llave foranea id_empresas en la tabla Control_Ingreso que va a hacer referencia a la tabla Empresas_importadoras, al campo id_empresa.

alter table Control_Ingreso
ADD FOREIGN KEY (id_empresas)REFERENCES Empresas_importadoras(id_empresa);

-- Se crea la llave foranea id_almacenes en la tabla Control_Ingreso que va a hacer referencia a la tabla Almacenes, al campo id_almacen.

alter table Control_Ingreso
ADD FOREIGN KEY (id_almacenes)REFERENCES Almacenes(id_almacen);

-- Se crea la llave foranea id_articulos en la tabla Control_Ingreso que va a hacer referencia a la tabla Articulos, al campo id_articulo.

alter table Control_Ingreso
ADD FOREIGN KEY (id_articulos)REFERENCES Articulos(id_articulo);

------------------------------------------------------------------
-- Se crea la llave foranea id_empresas en la tabla Facturas que va a hacer referencia a la tabla Empresas_importadoras, al campo id_empresa.

alter table Facturas
ADD FOREIGN KEY (id_empresas)REFERENCES Empresas_importadoras(id_empresa);

-- Se crea la llave foranea id_impuestos en la tabla Facturas que va a hacer referencia a la tabla Impuestos_Almacen, al campo id_impuestos.

alter table Facturas
ADD FOREIGN KEY (id_impuestos)REFERENCES Impuestos_Almacen(id_impuestos);

-- Se crea la llave foranea id_costoArtis en la tabla Facturas que va a hacer referencia a la tabla Costo_Articulos, al campo id_costoArti.

alter table Facturas
ADD FOREIGN KEY (id_costoArtis)REFERENCES Costo_Articulos(id_costoArti);

------------------------------------------------------------------

