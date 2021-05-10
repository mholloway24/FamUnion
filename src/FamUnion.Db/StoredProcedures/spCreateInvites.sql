﻿CREATE PROCEDURE [dbo].[spCreateInvites]
	@invites [dbo].[udfInviteType] READONLY,
	@userId NVARCHAR(255)
AS
	MERGE INTO [dbo].[ReunionInvite] TARGET
	USING @invites SOURCE
	ON SOURCE.ReunionId = TARGET.ReunionId
		AND SOURCE.Email = TARGET.Email
	WHEN NOT MATCHED BY TARGET
	THEN
		INSERT (ReunionId, Email, Name, CreatedBy, CreatedDate)
		VALUES (SOURCE.ReunionId, SOURCE.Email, SOURCE.Name, @userId, SYSDATETIME());
