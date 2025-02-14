USE [PermisosDB]
GO
/****** Object:  Table [dbo].[tbSolicitudes]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbSolicitudes](
	[FolioSolicitud] [int] IDENTITY(1,1) NOT NULL,
	[EstadoSolicitud] [nvarchar](250) NULL,
	[FechaDeSolicitud] [nvarchar](250) NULL,
	[NombreMaestro] [nvarchar](250) NULL,
	[NumeroEmpleado] [int] NULL,
	[EmailSolicitante] [nvarchar](250) NOT NULL,
	[CategoriaEmpleado] [nvarchar](250) NULL,
	[CarreraAfectada1] [nvarchar](250) NULL,
	[CarreraAfectada2] [nvarchar](250) NULL,
	[CarreraAfectada3] [nvarchar](250) NULL,
	[CarreraAfectada4] [nvarchar](250) NULL,
	[CarreraAfectada5] [nvarchar](250) NULL,
	[NombreEvento] [nvarchar](250) NULL,
	[CostoEvento] [int] NULL,
	[LugarEvento] [nvarchar](250) NULL,
	[FechaSalida] [nvarchar](250) NULL,
	[HoraSalida] [nvarchar](250) NULL,
	[FechaRegreso] [nvarchar](250) NULL,
	[HoraRegreso] [nvarchar](250) NULL,
	[RecursoHospedajeCheck] [nvarchar](2) NULL,
	[RecursoViaticosCheck] [nvarchar](2) NULL,
	[RecursoTransporteCheck] [nvarchar](2) NULL,
	[RecursoTransporteDef] [nvarchar](250) NULL,
	[RecursoOficioComision] [nvarchar](2) NULL,
	[RecursoCombustibleCheck] [nvarchar](2) NULL,
	[RecursoCombustibleDef] [int] NULL,
	[RecursoOtroCheck] [nvarchar](2) NULL,
	[RecursoOtroDef] [nvarchar](250) NULL,
	[ActAsociadaCACEICIEESCheck] [nvarchar](2) NULL,
	[ActAsociadaISO90012008Check] [nvarchar](2) NULL,
	[ActAsociadaLicenciaturaCheck] [nvarchar](2) NULL,
	[ActAsociadaPosgradoCheck] [nvarchar](2) NULL,
	[ActAsociadaPersonalCheck] [nvarchar](2) NULL,
	[ActAsociadaOtraCheck] [nvarchar](2) NULL,
	[ActAsociadaOtraDef] [nvarchar](250) NULL,
	[AprobadoCoordinador] [bit] NULL,
	[AprobadoSubDirector] [bit] NULL,
	[AprobadoAdministrador] [bit] NULL,
	[AprobadoDirector] [bit] NULL,
	[AprobadoPosgrado] [bit] NULL,
 CONSTRAINT [PK_dbSolicitudes] PRIMARY KEY CLUSTERED 
(
	[FolioSolicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbUsuarios]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbUsuarios](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NoEmpleado] [int] NULL,
	[Nombre] [nvarchar](250) NULL,
	[Apellidos] [nvarchar](250) NULL,
	[Rol] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NOT NULL,
	[Password] [nvarchar](250) NOT NULL,
	[Status] [nvarchar](250) NULL,
 CONSTRAINT [PK_tbUsuarios_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[spActualizarBitsAprobadoPorFolio]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery1.sql|3|0|C:\Users\Jovany\AppData\Local\Temp\~vsF572.sql


CREATE PROCEDURE [dbo].[spActualizarBitsAprobadoPorFolio]
(
	   @Rol nvarchar(250),
	   @FolioSolicitud int
)
AS
BEGIN

	IF @Rol='COORDINADOR'
	BEGIN
		UPDATE [dbo].[tbSolicitudes]
		SET AprobadoCoordinador = 1 
		WHERE FolioSolicitud= @FolioSolicitud
	END

	IF @Rol='SUBDIRECTOR'
	BEGIN
		UPDATE [dbo].[tbSolicitudes]
		SET AprobadoSubDirector = 1 
		WHERE FolioSolicitud= @FolioSolicitud
	END

	IF @Rol='ADMINISTRADOR'
	BEGIN
		UPDATE [dbo].[tbSolicitudes]
		SET AprobadoAdministrador = 1 
		WHERE FolioSolicitud= @FolioSolicitud
	END

	IF @Rol='DIRECTOR'
	BEGIN
		UPDATE [dbo].[tbSolicitudes]
		SET AprobadoDirector = 1 
		WHERE FolioSolicitud= @FolioSolicitud
	END

	IF @Rol='POSGRADO'
	BEGIN
		UPDATE [dbo].[tbSolicitudes]
		SET AprobadoPosgrado = 1 
		WHERE FolioSolicitud= @FolioSolicitud
	END

	
END
GO
/****** Object:  StoredProcedure [dbo].[spActualizarUsuario]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spActualizarUsuario]
(
			@Rol nvarchar(250)
           ,@NombreMaestro nvarchar(250)
           ,@NumeroEmpleado int
           ,@EmailMaestro nvarchar(250)
           ,@PasswordEmail nvarchar(250)
           ,@Estado nvarchar(250)
)
AS
BEGIN
	UPDATE [dbo].[tbUsuarios]
	SET [Rol] = @Rol
      ,[NombreMaestro] = @NombreMaestro
      ,[EmailMaestro] = @EmailMaestro
      ,[PasswordEmail] = @PasswordEmail
      ,[Estado] = @Estado
 WHERE NumeroEmpleado=@NumeroEmpleado
END

GO
/****** Object:  StoredProcedure [dbo].[spAgregarSolicitud]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spAgregarSolicitud]
(
		@EstadoSolicitud nvarchar(250),
        @FechaDeSolicitud nvarchar(250),
        @NombreMaestro nvarchar(250),
        @NumeroEmpleado int,
        @EmailSolicitante nvarchar(250),
        @CategoriaEmpleado nvarchar(250),
        @CarreraAfectada1 nvarchar(250),
        @CarreraAfectada2 nvarchar(250),
        @CarreraAfectada3 nvarchar(250),
        @CarreraAfectada4 nvarchar(250),
        @CarreraAfectada5 nvarchar(250),
        @NombreEvento nvarchar(250), 
        @CostoEvento int,
        @LugarEvento nvarchar(250), 
        @FechaSalida nvarchar(250), 
        @HoraSalida nvarchar(250),
        @FechaRegreso nvarchar(250),
        @HoraRegreso nvarchar(250),
        @RecursoHospedajeCheck nvarchar(2),
        @RecursoViaticosCheck nvarchar(2), 
        @RecursoTransporteCheck nvarchar(2), 
        @RecursoTransporteDef nvarchar(250), 
        @RecursoOficioComision nvarchar(2),
        @RecursoCombustibleCheck nvarchar(2),
        @RecursoCombustibleDef int,
        @RecursoOtroCheck nvarchar(2), 
        @RecursoOtroDef nvarchar(250), 
        @ActAsociadaCACEICIEESCheck nvarchar(2), 
        @ActAsociadaISO90012008Check nvarchar(2), 
        @ActAsociadaLicenciaturaCheck nvarchar(2), 
        @ActAsociadaPosgradoCheck nvarchar(2), 
        @ActAsociadaPersonalCheck nvarchar(2), 
        @ActAsociadaOtraCheck nvarchar(2),
        @ActAsociadaOtraDef nvarchar(2)
)
AS
BEGIN

INSERT INTO [dbo].[tbSolicitudes]
           ([EstadoSolicitud]
           ,[FechaDeSolicitud]
           ,[NombreMaestro]
           ,[NumeroEmpleado]
           ,[EmailSolicitante]
           ,[CategoriaEmpleado]
           ,[CarreraAfectada1]
           ,[CarreraAfectada2]
           ,[CarreraAfectada3]
           ,[CarreraAfectada4]
           ,[CarreraAfectada5]
           ,[NombreEvento]
           ,[CostoEvento]
           ,[LugarEvento]
           ,[FechaSalida]
           ,[HoraSalida]
           ,[FechaRegreso]
           ,[HoraRegreso]
           ,[RecursoHospedajeCheck]
           ,[RecursoViaticosCheck]
           ,[RecursoTransporteCheck]
           ,[RecursoTransporteDef]
           ,[RecursoOficioComision]
           ,[RecursoCombustibleCheck]
           ,[RecursoCombustibleDef]
           ,[RecursoOtroCheck]
           ,[RecursoOtroDef]
           ,[ActAsociadaCACEICIEESCheck]
           ,[ActAsociadaISO90012008Check]
           ,[ActAsociadaLicenciaturaCheck]
           ,[ActAsociadaPosgradoCheck]
           ,[ActAsociadaPersonalCheck]
           ,[ActAsociadaOtraCheck]
           ,[ActAsociadaOtraDef])
     VALUES
           (@EstadoSolicitud,
           @FechaDeSolicitud,
           @NombreMaestro, 
           @NumeroEmpleado,
           @EmailSolicitante,
           @CategoriaEmpleado,
           @CarreraAfectada1,
           @CarreraAfectada2,
           @CarreraAfectada3, 
           @CarreraAfectada4,
           @CarreraAfectada5,
           @NombreEvento, 
           @CostoEvento, 
           @LugarEvento, 
           @FechaSalida, 
           @HoraSalida, 
           @FechaRegreso, 
           @HoraRegreso, 
           @RecursoHospedajeCheck,
           @RecursoViaticosCheck, 
           @RecursoTransporteCheck, 
           @RecursoTransporteDef, 
           @RecursoOficioComision,
           @RecursoCombustibleCheck,
           @RecursoCombustibleDef,
           @RecursoOtroCheck, 
           @RecursoOtroDef, 
           @ActAsociadaCACEICIEESCheck, 
           @ActAsociadaISO90012008Check, 
           @ActAsociadaLicenciaturaCheck, 
           @ActAsociadaPosgradoCheck, 
           @ActAsociadaPersonalCheck, 
           @ActAsociadaOtraCheck,
           @ActAsociadaOtraDef)
	
END





GO
/****** Object:  StoredProcedure [dbo].[spAgregarUsuario]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAgregarUsuario]
(
			@Rol nvarchar(250),
            @Nombre nvarchar(250),
			@Apellidos nvarchar(250),
            @NoEmpleado int,
            @Email nvarchar(250),
            @Password nvarchar(250),
            @Status nvarchar(250)
)
AS
BEGIN

INSERT INTO [dbo].[tbUsuarios]
           ([NoEmpleado]
           ,[Nombre]
           ,[Apellidos]
           ,[Rol]
           ,[Email]
           ,[Password]
           ,[Status])
     VALUES
           (@NoEmpleado,
			@Nombre,
			@Apellidos,
			@Rol, 
			@Email, 
			@Password, 
			@Status)

END

GO
/****** Object:  StoredProcedure [dbo].[spEliminarUsuario]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEliminarUsuario]
(
	@NumeroEmpleado int
)
AS
BEGIN
	DELETE FROM tbUsuarios where NumeroEmpleado=@NumeroEmpleado
END

GO
/****** Object:  StoredProcedure [dbo].[spMostrarSolicitudesPorEmailYEstado]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spMostrarSolicitudesPorEmailYEstado]
(
	@Email nvarchar(250),
	@Status nvarchar(250)
)

AS
BEGIN
	SELECT * FROM [dbo].[tbSolicitudes] WHERE EmailSolicitante=@Email AND EstadoSolicitud = @Status
END

GO
/****** Object:  StoredProcedure [dbo].[spMostrarUsuariosPorEmail]    Script Date: 27/05/2017 14:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spMostrarUsuariosPorEmail]
(
	@Email nvarchar(250)
)

AS
BEGIN
	SELECT * FROM [dbo].[tbUsuarios] WHERE Email=@Email
END

GO
