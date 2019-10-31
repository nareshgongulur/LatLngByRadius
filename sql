SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

CREATE PROCEDURE [dbo].[GetAllLatLongByRadius]
    @Lat float,
    @Long float,
	@Radius int

AS

declare @milesInMeters int = @Radius/ 0.0006213712 
select @Lat as Lat, @Long as Long, @milesInMeters as Meters

declare @GetAllLocations geography = geography::Point(@Lat, @Long, 4326).STBuffer(@milesInMeters)
select @GetAllLocations as Buffered_Geography

Select Lat, Long, * from dbo.[TABLENAME] where @GetAllLocations.STIntersects(geog) = 1


RETURN
