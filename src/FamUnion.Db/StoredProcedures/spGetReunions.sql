﻿CREATE PROCEDURE [dbo].[spGetReunions]
AS
	SELECT 
		ReunionId [Id],
		Name,
		Description,
		StartDate,
		EndDate,
		AddressId,
		CreatedBy,
		CreatedDate,
		ModifiedBy,
		ModifiedDate
	FROM
		[dbo].[Reunion]
	ORDER BY StartDate, Name
RETURN 0