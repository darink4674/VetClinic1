USE [Vetclinic]
GO
/****** Object:  Table [dbo].[Animal]    Script Date: 25.04.2025 13:34:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Animal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IdGender] [int] NULL,
	[IdTypeAni] [int] NULL,
	[Weight_kg] [float] NULL,
	[Height_cm] [float] NULL,
 CONSTRAINT [PK_Animal] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 25.04.2025 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDAnimal] [int] NULL,
	[IDDoc] [int] NULL,
	[DateAccep] [date] NULL,
	[Comment] [nvarchar](max) NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 25.04.2025 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[Patronymic] [nvarchar](max) NULL,
	[IdTypeDoc] [int] NULL,
 CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Gender]    Script Date: 25.04.2025 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 25.04.2025 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](200) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TypeAni]    Script Date: 25.04.2025 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeAni](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_TypeAni] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TypeDoc]    Script Date: 25.04.2025 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeDoc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_TypeDoc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserAnimals]    Script Date: 25.04.2025 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAnimals](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdAnimal] [int] NOT NULL,
	[IsOwner] [bit] NOT NULL DEFAULT ((1)),
	[RegistrationDate] [date] NOT NULL DEFAULT (getdate()),
 CONSTRAINT [PK_UserAnimals] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 25.04.2025 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[Patronymic] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [nvarchar](20) NULL,
	[IdRole] [int] NULL,
	[IdDoctor] [int] NULL,
	[RegistrationDate] [datetime] NOT NULL CONSTRAINT [DF__Users__Registrat__70DDC3D8]  DEFAULT (getdate()),
	[LastLoginDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF__Users__IsActive__71D1E811]  DEFAULT ((1)),
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Animal] ON 

INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (1, N'меган', 2, 5, 2, 35)
INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (2, N'бони', 1, 5, 35, 50)
INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (3, N'герда', 2, 2, 15, 40)
INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (4, N'гарри', 1, 1, 35, 44)
INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (5, N'джордж', 1, 1, 35, 50)
INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (6, N'ggg', 1, 4, 10, 150)
INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (7, N'хома', 2, 4, 10, 100)
INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (8, N'пуся', 1, 1, 4, 30)
INSERT [dbo].[Animal] ([ID], [Name], [IdGender], [IdTypeAni], [Weight_kg], [Height_cm]) VALUES (9, N'хома', 1, 4, 237628, 873924)
SET IDENTITY_INSERT [dbo].[Animal] OFF
SET IDENTITY_INSERT [dbo].[Appointment] ON 

INSERT [dbo].[Appointment] ([ID], [IDAnimal], [IDDoc], [DateAccep], [Comment], [IsDelete]) VALUES (1, 2, 1, CAST(N'2025-01-14' AS Date), N'дцп', 0)
INSERT [dbo].[Appointment] ([ID], [IDAnimal], [IDDoc], [DateAccep], [Comment], [IsDelete]) VALUES (2, 3, 5, CAST(N'2024-02-15' AS Date), N'облысение', 0)
INSERT [dbo].[Appointment] ([ID], [IDAnimal], [IDDoc], [DateAccep], [Comment], [IsDelete]) VALUES (3, 1, 2, CAST(N'2024-03-16' AS Date), N'простуда', 0)
INSERT [dbo].[Appointment] ([ID], [IDAnimal], [IDDoc], [DateAccep], [Comment], [IsDelete]) VALUES (9, 9, 5, CAST(N'2025-04-16' AS Date), N'очень большой хомяк', 0)
SET IDENTITY_INSERT [dbo].[Appointment] OFF
SET IDENTITY_INSERT [dbo].[Doctor] ON 

INSERT [dbo].[Doctor] ([ID], [LastName], [Name], [Patronymic], [IdTypeDoc]) VALUES (1, N'Иванов ', N'Иван ', N'Иванович', 3)
INSERT [dbo].[Doctor] ([ID], [LastName], [Name], [Patronymic], [IdTypeDoc]) VALUES (2, N'Петрова ', N'Петриха', N'Петоровна', 2)
INSERT [dbo].[Doctor] ([ID], [LastName], [Name], [Patronymic], [IdTypeDoc]) VALUES (3, N'Сидоров ', N'Сидр', N'Сидорович', 1)
INSERT [dbo].[Doctor] ([ID], [LastName], [Name], [Patronymic], [IdTypeDoc]) VALUES (4, N'Смирнов', N'Смирин', N'Смиринович', 4)
INSERT [dbo].[Doctor] ([ID], [LastName], [Name], [Patronymic], [IdTypeDoc]) VALUES (5, N'Озверинов', N'Озверин', N'Озверинович', 5)
SET IDENTITY_INSERT [dbo].[Doctor] OFF
SET IDENTITY_INSERT [dbo].[Gender] ON 

INSERT [dbo].[Gender] ([ID], [Name]) VALUES (1, N'male')
INSERT [dbo].[Gender] ([ID], [Name]) VALUES (2, N'female')
SET IDENTITY_INSERT [dbo].[Gender] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([ID], [Name], [Description]) VALUES (1, N'Admin', N'Администратор системы')
INSERT [dbo].[Roles] ([ID], [Name], [Description]) VALUES (2, N'Doctor', N'Ветеринарный врач')
INSERT [dbo].[Roles] ([ID], [Name], [Description]) VALUES (3, N'Reception', N'Регистратор/администратор клиники')
INSERT [dbo].[Roles] ([ID], [Name], [Description]) VALUES (4, N'Client', N'Клиент/владелец животного')
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[TypeAni] ON 

INSERT [dbo].[TypeAni] ([ID], [Name]) VALUES (1, N'петух')
INSERT [dbo].[TypeAni] ([ID], [Name]) VALUES (2, N'волк')
INSERT [dbo].[TypeAni] ([ID], [Name]) VALUES (3, N'попугай')
INSERT [dbo].[TypeAni] ([ID], [Name]) VALUES (4, N'хомяк')
INSERT [dbo].[TypeAni] ([ID], [Name]) VALUES (5, N'лиса')
SET IDENTITY_INSERT [dbo].[TypeAni] OFF
SET IDENTITY_INSERT [dbo].[TypeDoc] ON 

INSERT [dbo].[TypeDoc] ([ID], [Name]) VALUES (1, N'Ориентолог')
INSERT [dbo].[TypeDoc] ([ID], [Name]) VALUES (2, N'Кошколог')
INSERT [dbo].[TypeDoc] ([ID], [Name]) VALUES (3, N'Собачолог')
INSERT [dbo].[TypeDoc] ([ID], [Name]) VALUES (4, N'Хомяколог')
INSERT [dbo].[TypeDoc] ([ID], [Name]) VALUES (5, N'Психолог')
SET IDENTITY_INSERT [dbo].[TypeDoc] OFF
SET IDENTITY_INSERT [dbo].[UserAnimals] ON 

INSERT [dbo].[UserAnimals] ([ID], [IdUser], [IdAnimal], [IsOwner], [RegistrationDate]) VALUES (1, 1, 1, 1, CAST(N'2025-04-16' AS Date))
INSERT [dbo].[UserAnimals] ([ID], [IdUser], [IdAnimal], [IsOwner], [RegistrationDate]) VALUES (2, 1, 2, 1, CAST(N'2025-04-16' AS Date))
INSERT [dbo].[UserAnimals] ([ID], [IdUser], [IdAnimal], [IsOwner], [RegistrationDate]) VALUES (3, 2, 3, 1, CAST(N'2025-04-16' AS Date))
INSERT [dbo].[UserAnimals] ([ID], [IdUser], [IdAnimal], [IsOwner], [RegistrationDate]) VALUES (4, 2, 4, 1, CAST(N'2025-04-16' AS Date))
SET IDENTITY_INSERT [dbo].[UserAnimals] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Login], [Password], [LastName], [FirstName], [Patronymic], [Email], [Phone], [IdRole], [IdDoctor], [RegistrationDate], [LastLoginDate], [IsActive]) VALUES (1, N'ilina', N'$2a$10$xJwL5v5Jz5UZ5Z5Z5Z5Z5O', N'Ильина', N'Дарина', N'Сергеевна', N'darina@gmail.com', N'+79600699971', 2, 1, CAST(N'2025-04-16 14:11:46.700' AS DateTime), CAST(N'2025-04-16 18:47:02.827' AS DateTime), 1)
INSERT [dbo].[Users] ([ID], [Login], [Password], [LastName], [FirstName], [Patronymic], [Email], [Phone], [IdRole], [IdDoctor], [RegistrationDate], [LastLoginDate], [IsActive]) VALUES (2, N'Ильина', N'123', N'Петрова', N'Анна', N'Сергеевна', N'petrova@vetclinic.ru', N'+79161234569', 2, 2, CAST(N'2025-04-16 14:11:46.700' AS DateTime), CAST(N'2025-04-25 13:34:02.390' AS DateTime), 1)
INSERT [dbo].[Users] ([ID], [Login], [Password], [LastName], [FirstName], [Patronymic], [Email], [Phone], [IdRole], [IdDoctor], [RegistrationDate], [LastLoginDate], [IsActive]) VALUES (3, N'sidorov.a', N'$2a$10$xJwL5v5Jz5UZ5Z5Z5Z5Z5O', N'Сидоров', N'Алексей', N'Викторович', N'sidorov@vetclinic.ru', N'+79161234570', 2, 3, CAST(N'2025-04-16 14:11:46.700' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Users_Login]    Script Date: 25.04.2025 13:34:51 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_Users_Login] UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_Gender] FOREIGN KEY([IdGender])
REFERENCES [dbo].[Gender] ([ID])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_Gender]
GO
ALTER TABLE [dbo].[Animal]  WITH CHECK ADD  CONSTRAINT [FK_Animal_TypeAni] FOREIGN KEY([IdTypeAni])
REFERENCES [dbo].[TypeAni] ([ID])
GO
ALTER TABLE [dbo].[Animal] CHECK CONSTRAINT [FK_Animal_TypeAni]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Animal] FOREIGN KEY([IDAnimal])
REFERENCES [dbo].[Animal] ([ID])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [FK_Appointment_Animal]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [FK_Appointment_Doctor] FOREIGN KEY([IDDoc])
REFERENCES [dbo].[Doctor] ([ID])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [FK_Appointment_Doctor]
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD  CONSTRAINT [FK_Doctor_TypeDoc] FOREIGN KEY([IdTypeDoc])
REFERENCES [dbo].[TypeDoc] ([ID])
GO
ALTER TABLE [dbo].[Doctor] CHECK CONSTRAINT [FK_Doctor_TypeDoc]
GO
ALTER TABLE [dbo].[UserAnimals]  WITH CHECK ADD  CONSTRAINT [FK_UserAnimals_Animal] FOREIGN KEY([IdAnimal])
REFERENCES [dbo].[Animal] ([ID])
GO
ALTER TABLE [dbo].[UserAnimals] CHECK CONSTRAINT [FK_UserAnimals_Animal]
GO
ALTER TABLE [dbo].[UserAnimals]  WITH CHECK ADD  CONSTRAINT [FK_UserAnimals_Users] FOREIGN KEY([IdUser])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserAnimals] CHECK CONSTRAINT [FK_UserAnimals_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Doctor] FOREIGN KEY([IdDoctor])
REFERENCES [dbo].[Doctor] ([ID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Doctor]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([IdRole])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
