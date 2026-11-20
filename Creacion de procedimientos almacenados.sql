
--1.

CREATE PROCEDURE SP_AumentarSueldo
    @CodEmp INT,
    @Porcentaje DECIMAL(5,2)
AS
BEGIN
    UPDATE EMPLE
    SET SUELDO = SUELDO + (SUELDO * @Porcentaje / 100)
    WHERE COD_EMP = @CodEmp;
END;
GO


--2.

CREATE PROCEDURE SP_EmpleadosDepartamento
    @CodDep INT
AS
BEGIN
    SELECT
        NOM_EMP AS Nombre,
        CARGO AS Puesto,
        SUELDO AS Salario
    FROM EMPLE
    WHERE COD_DEP = @CodDep;
END;
GO


--3.

CREATE PROCEDURE SP_ResumenDepartamentos
AS
BEGIN
    SELECT
        D.COD_DEP,
        D.NOM_DEP,
        AVG(E.SUELDO) AS SueldoPromedio,
        COALESCE(SUM(E.COMISION), 0) AS TotalComisiones
    FROM DEP D
    LEFT JOIN EMPLE E
        ON D.COD_DEP = E.COD_DEP
    GROUP BY D.COD_DEP, D.NOM_DEP;
END;
GO


--4.

CREATE PROCEDURE SP_EmpleadoMayorSueldo
    @CodDep INT
AS
BEGIN
    SELECT TOP 1
        COD_EMP,
        NOM_EMP,
        CARGO,
        SUELDO
    FROM EMPLE
    WHERE COD_DEP = @CodDep
    ORDER BY SUELDO DESC, COD_EMP;
END;
GO

--5

CREATE PROCEDURE SP_EmpleadosSueldoMinimo
    @SueldoMinimo DECIMAL(7,2)
AS
BEGIN
    SELECT
        COD_EMP,
        NOM_EMP,
        CARGO,
        SUELDO
    FROM EMPLE
    WHERE SUELDO > @SueldoMinimo
    ORDER BY SUELDO DESC;
END;
GO

