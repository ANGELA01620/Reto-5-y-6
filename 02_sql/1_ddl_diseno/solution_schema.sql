


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

-- Eliminar dependencias primero
IF OBJECT_ID('dbo.Venta', 'U') IS NOT NULL DROP TABLE dbo.Venta;
IF OBJECT_ID('dbo.Cliente', 'U') IS NOT NULL DROP TABLE dbo.Cliente;
IF OBJECT_ID('dbo.Producto', 'U') IS NOT NULL DROP TABLE dbo.Producto;
IF OBJECT_ID('dbo.Sucursal', 'U') IS NOT NULL DROP TABLE dbo.Sucursal;
GO

-- =========================
-- TABLA CLIENTE
-- =========================
CREATE TABLE Cliente (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Cliente_Email UNIQUE (Email)
);

-- =========================
-- TABLA PRODUCTO
-- =========================
CREATE TABLE Producto (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL
);

-- =========================
-- TABLA SUCURSAL
-- =========================
CREATE TABLE Sucursal (
    SucursalID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL
);

-- =========================
-- TABLA VENTA
-- =========================
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





