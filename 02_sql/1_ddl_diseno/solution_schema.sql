-- Eliminar FKs si existen
IF OBJECT_ID('FK_Venta_Cliente', 'F') IS NOT NULL
    ALTER TABLE Venta DROP CONSTRAINT FK_Venta_Cliente;

IF OBJECT_ID('FK_Venta_Producto', 'F') IS NOT NULL
    ALTER TABLE Venta DROP CONSTRAINT FK_Venta_Producto;

IF OBJECT_ID('FK_Venta_Sucursal', 'F') IS NOT NULL
    ALTER TABLE Venta DROP CONSTRAINT FK_Venta_Sucursal;
GO




/*
RETO PARTE A: DISEÑO DEL ESQUEMA RELACIONAL (SOLUCIÓN)
Misión: Normalización 3NF
*/

-- 1. CREACIÓN DE LA BASE DE DATOS
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'RetoSQL')
BEGIN
    CREATE DATABASE RetoSQL;
END
GO

USE RetoSQL;
GO

IF OBJECT_ID('dbo.Venta', 'U') IS NOT NULL DROP TABLE dbo.Venta;
IF OBJECT_ID('dbo.Cliente', 'U') IS NOT NULL DROP TABLE dbo.Cliente;
IF OBJECT_ID('dbo.Producto', 'U') IS NOT NULL DROP TABLE dbo.Producto;
IF OBJECT_ID('dbo.Sucursal', 'U') IS NOT NULL DROP TABLE dbo.Sucursal;
IF OBJECT_ID('dbo.RawSales', 'U') IS NOT NULL DROP TABLE dbo.RawSales;
GO

-- =======================================================
-- 2. TABLAS MAESTRAS (Independientes)
-- =======================================================

-- TABLA CLIENTE
-- Normalizamos eliminando redundancia de Emails repetidos
CREATE TABLE Cliente (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Cliente_Email UNIQUE (Email)
);


-- TABLA PRODUCTO
-- Normalizamos Categoria y Precio
CREATE TABLE Producto (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL
);

-- TABLA SUCURSAL
-- Normalizamos Sucursal y Ciudad
CREATE TABLE Sucursal (
    SucursalID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL
);


-- =======================================================
-- 3. TABLA TRANSACCIONAL (Dependientes)
-- =======================================================
CREATE TABLE Venta (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME NOT NULL,
    Cantidad INT NOT NULL,
    ClienteID INT NOT NULL,
    ProductoID INT NOT NULL,
    SucursalID INT NOT NULL,
    CONSTRAINT FK_Venta_Cliente  FOREIGN KEY (ClienteID)  REFERENCES Cliente(ClienteID),
    CONSTRAINT FK_Venta_Producto FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID),
    CONSTRAINT FK_Venta_Sucursal FOREIGN KEY (SucursalID) REFERENCES Sucursal(SucursalID)
);
GO




SELECT name
FROM sys.tables;





