USE [BookStoreDW]
GO

CREATE TABLE [dbo].[DimShipping](
	[Shipping_Method_SK] [int] IDENTITY(1,1) NOT NULL,
	[Shipping_Method_ID_BK] [int] NULL,
	[Mehtod_Name] [varchar](200) NULL,
	[Cost_Shipping] [decimal](6, 2) NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
 CONSTRAINT [PK_Shipping] PRIMARY KEY CLUSTERED 
(
	[Shipping_Method_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
----------------------------------------------------------
CREATE TABLE [dbo].[DimAuthor](
	[Author_SK] [int] IDENTITY(1,1) NOT NULL,
	[Auther_ID_BK] [int] NULL,
	[Author_Name] [varchar](400) NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
 CONSTRAINT [PK_Auther] PRIMARY KEY CLUSTERED 
(
	[Author_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
----------------------------------------------------------
CREATE TABLE [dbo].[DimBook](
	[Book_SK] [int] IDENTITY(1,1) NOT NULL,
	[Book_ID_BK] [int] NULL,
	[Title] [varchar](400) NULL,
	[ISBN13] [varchar](13) NULL,
	[Language_Code] [varchar](400) NULL,
	[Language_Name] [varchar](400) NULL,
	[Publication_Date] [datetime] NULL,
	[Publisher_Name] [varchar](400) NULL,
	[Author_SK] [int] NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
	[num_pages] [int] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[Book_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DimBook]  WITH CHECK ADD  CONSTRAINT [FK__DimBook__Author___3D5E1FD2] FOREIGN KEY([Author_SK])
REFERENCES [dbo].[DimAuthor] ([Author_SK])
GO

ALTER TABLE [dbo].[DimBook] CHECK CONSTRAINT [FK__DimBook__Author___3D5E1FD2]
GO
----------------------------------------------------------
CREATE TABLE [dbo].[DimOrderLines](
	[Line_SK] [int] IDENTITY(1,1) NOT NULL,
	[Line_ID] [int] NULL,
	[Book_SK] [int] NULL,
	[Price] [decimal](5, 2) NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
	[Order_ID] [int] NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[Line_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DimOrderLines]  WITH CHECK ADD  CONSTRAINT [FK_BOOKS_LINES] FOREIGN KEY([Book_SK])
REFERENCES [dbo].[DimBook] ([Book_SK])
GO

ALTER TABLE [dbo].[DimOrderLines] CHECK CONSTRAINT [FK_BOOKS_LINES]
GO
------------------------------------------------------
CREATE TABLE [dbo].[DimAddress](
	[Address_SK] [int] IDENTITY(1,1) NOT NULL,
	[Address_ID] [int] NULL,
	[Street_Number] [varchar](600) NULL,
	[Street_Name] [varchar](600) NULL,
	[City] [varchar](600) NULL,
	[Country_Name] [varchar](600) NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Address_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
CREATE TABLE [dbo].[DimAddressStatus](
	[Address_Status_SK] [int] IDENTITY(1,1) NOT NULL,
	[Address_Status_ID] [int] NULL,
	[Address_Status] [varchar](600) NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
 CONSTRAINT [PK_DimAddressStatus] PRIMARY KEY CLUSTERED 
(
	[Address_Status_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
----------------------------------------------------------
CREATE TABLE [dbo].[DimCustomer](
	[Customer_SK] [int] IDENTITY(1,1) NOT NULL,
	[Customer_ID] [int] NULL,
	[First_Name] [varchar](600) NULL,
	[Last_Name] [varchar](600) NULL,
	[Email] [varchar](600) NULL,
	[Address_Status_SK] [int] NULL,
	[Address_SK] [int] NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
	CONSTRAINT FK01 FOREIGN KEY (Address_Status_SK) REFERENCES [DimAddressStatus] (Address_Status_SK),
	CONSTRAINT FK02 FOREIGN KEY (Address_SK) REFERENCES [DimAddress] (Address_SK),
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
---------------------------------------------------------
CREATE TABLE [dbo].[DimStatus](
	[Status_SK] [int] IDENTITY(1,1) NOT NULL,
	[Status_ID_BK] [int] NULL,
	[Status_Value] [varchar](600) NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Status_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----------------------------------------------------------
CREATE TABLE [dbo].[DimHistory](
	[History_SK] [int] IDENTITY(1,1) NOT NULL,
	[History_ID] [int] NULL,
	[Status_SK] [int] NULL,
	[Status_Date] [datetime] NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
	[Order_ID] [int] NULL,
 CONSTRAINT [PK_DimHistory] PRIMARY KEY CLUSTERED 
(
	[History_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DimHistory]  WITH CHECK ADD  CONSTRAINT [FKHsitoryStatues] FOREIGN KEY([Status_SK])
REFERENCES [dbo].[DimStatus] ([Status_SK])
GO

ALTER TABLE [dbo].[DimHistory] CHECK CONSTRAINT [FKHsitoryStatues]
GO
----------------------------------------------------------
CREATE TABLE [dbo].[FactOrders](
	[Customer_SK] [int] NULL,
	[Shipping_Method_SK] [int] NULL,
	[Line_SK] [int] NULL,
	[History_SK] [int] NULL,
	[Address_SK] [int] NULL,
	[DateSK] [int] NULL,
	[OrderDate] [datetime] NULL,
	[_ValidFrom] [datetime] NULL,
	[_ValidTo] [datetime] NULL,
	[Order_ID] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FactOrders]  WITH CHECK ADD  CONSTRAINT [FK_FactOrders_DimCustomer] FOREIGN KEY([Customer_SK])
REFERENCES [dbo].[DimCustomer] ([Customer_SK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimCustomer]
GO

ALTER TABLE [dbo].[FactOrders]  WITH CHECK ADD  CONSTRAINT [FK_FactOrders_DimDate] FOREIGN KEY([DateSK])
REFERENCES [dbo].[DimDate] ([DateSK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimDate]
GO

ALTER TABLE [dbo].[FactOrders]  WITH CHECK ADD  CONSTRAINT [FK_FactOrders_DimHistory] FOREIGN KEY([History_SK])
REFERENCES [dbo].[DimHistory] ([History_SK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimHistory]
GO

ALTER TABLE [dbo].[FactOrders]  WITH CHECK ADD  CONSTRAINT [FK_FactOrders_DimOrderLines] FOREIGN KEY([Line_SK])
REFERENCES [dbo].[DimOrderLines] ([Line_SK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimOrderLines]
GO

ALTER TABLE [dbo].[FactOrders]  WITH CHECK ADD  CONSTRAINT [FK_FactOrders_DimShipping] FOREIGN KEY([Shipping_Method_SK])
REFERENCES [dbo].[DimShipping] ([Shipping_Method_SK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimShipping]
GO
GO

