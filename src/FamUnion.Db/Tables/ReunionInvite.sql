﻿CREATE TABLE [dbo].[ReunionInvite]
(
	[InviteId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	[ReunionId] UNIQUEIDENTIFIER NOT NULL CONSTRAINT FK_ReunionInvite_Reunion FOREIGN KEY REFERENCES [dbo].[Reunion]([ReunionId]),
	[Email] NVARCHAR(255) NOT NULL,
	[Name] NVARCHAR(255),
	[RsvpCount] INT NOT NULL CONSTRAINT DF_ReunionInvite_RsvpCount DEFAULT (0),
	[ExpiresAt] DATETIME NULL,
	[Status] INT NOT NULL CONSTRAINT DF_ReunionInvite_Status DEFAULT (0),
	[CreatedBy] NVARCHAR(100) NOT NULL CONSTRAINT DF_ReunionInvite_CreatedBy DEFAULT SUSER_SNAME(),
	[CreatedDate] DATETIME NOT NULL CONSTRAINT DF_ReunionInvite_CreatedDate DEFAULT SYSDATETIME(),
	[ModifiedBy] NVARCHAR(100) NULL,
	[ModifiedDate] DATETIME NULL,
	CONSTRAINT PK_ReunionInvite UNIQUE ([ReunionId], [Email])
)
