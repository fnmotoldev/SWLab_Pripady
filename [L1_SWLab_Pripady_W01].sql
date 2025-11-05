USE [DWH_L0]
GO
/****** Object:  StoredProcedure [LW].[sp_L1_SWLab_Pripady_v2_251104_UPD]    Script Date: 04.11.2025 15:43:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/**************************************
-- Stored Procedure: sp_L1_SWLab_Pripady
--    Version:      01-01
--	  Change:		19.06.2025
--    Description:	
--					v01-00 -- 19.06.2025 -  Deploy script
**************************************/


ALTER  PROCEDURE [LW].[sp_L1_SWLab_Pripady_v2_251104_UPD]
    @dwLineageKey int,
	@sourceTable NVARCHAR(128),
	@effectiveDate DATETIME2 

AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

		-- Initialize @effectiveDate if not provided
		--SET @effectiveDate = GETDATE();

-- Debugging: Show the effective date being used by the procedure
SELECT @effectiveDate AS [EffectiveDate_ProcedureScope];

DECLARE  @dwDateTo date = '2999-12-31';
DECLARE @FinishLoad datetime = CONVERT(varchar, GetDate(), 20);
DECLARE @LineageKey int;
DECLARE @sql NVARCHAR(MAX);				
DECLARE @sql_deleted NVARCHAR(MAX);		

BEGIN TRY
	BEGIN TRAN;

SET @sql = N'
DECLARE  @dwDateTo date = ''2999-12-31'';
DECLARE @FinishLoad datetime = CONVERT(varchar, GetDate(), 20);

--Debugging: This SELECT will now correctly show the value passed from the procedure
SELECT @effectiveDate as Effective_date_2

    -- (# 1 #) MERGE  ROWS FOR THE MODIFIED ROWS
 insert into [dbo].[L1_SWLab_Pripady]
      (
	   [dwModifiedRc]
	   ,[dwDatproRcKlinika]
	   ,[dwYearUctarna]
      ,[dwLineage_Key]
      ,[pripad]
      ,[datpri]
      ,[datpro]
      ,[rc]
      ,[zp]
      ,[vek]
      ,[pohlavi]
      ,[doba_hosp]
      ,[ukonceni]
      ,[icp]
      ,[klinika]
      ,[drg]
      ,[grouper]
      ,[typuhrady]
      ,[rv]
      ,[rv_los]
      ,[rv_mat]
      ,[osdoba]
      ,[inl_cas]
      ,[inl_mat]
      ,[dg]
      ,[vdg1]
      ,[vdg2]
      ,[vdg3]
      ,[vdg4]
      ,[vdg5]
      ,[vdg6]
      ,[vdg7]
      ,[vdg8]
      ,[vdg9]
      ,[vdg10]
      ,[vdg11]
      ,[vdg12]
      ,[vdg13]
      ,[vdg14]
      ,[vyk1]
      ,[vyk2]
      ,[vyk3]
      ,[vyk4]
      ,[vyk5]
      ,[vyk6]
      ,[vyk7]
      ,[vyk8]
      ,[vyk9]
      ,[vyk10]
      ,[vyk11]
      ,[vyk12]
      ,[vyk13]
      ,[vyk14]
      ,[vyk15]
      ,[vyk16]
      ,[vyk17]
      ,[vyk18]
      ,[vyk19]
      ,[vyk20]
      ,[vyk21]
      ,[vyk22]
      ,[vyk23]
      ,[vyk24]
      ,[vyk25]
      ,[por_hmot]
      ,[body]
      ,[zulp]
      ,[zum]
      ,[nakl_mat]
      ,[doklad]
      ,[zdroj]
      ,[upv]
      ,[in_ni_upv]
      ,[cel_body]
      ,[icz]
      ,[cvsp]
      ,[statut]
      ,[urgent]
      ,[skore_zav]
      ,[typ]
      ,[koef_zs]
      ,[odbpro]
      ,[dwCurrentFlag]
      ,[dwDateFrom]
	  ,[dwDateTo]
	  ,[dwInserted]
      ,[dwModified] 
  )

SELECT
[dwModifiedRc]
      ,[dwDatproRcKlinika]
	  ,[dwYearUctarna]
      ,[dwLineage_Key]
      ,[pripad]
      ,[datpri]
      ,[datpro]
      ,[rc]
      ,[zp]
      ,[vek]
      ,[pohlavi]
      ,[doba_hosp]
      ,[ukonceni]
      ,[icp]
      ,[klinika]
      ,[drg]
      ,[grouper]
      ,[typuhrady]
      ,[rv]
      ,[rv_los]
      ,[rv_mat]
      ,[osdoba]
      ,[inl_cas]
      ,[inl_mat]
      ,[dg]
      ,[vdg1]
      ,[vdg2]
      ,[vdg3]
      ,[vdg4]
      ,[vdg5]
      ,[vdg6]
      ,[vdg7]
      ,[vdg8]
      ,[vdg9]
      ,[vdg10]
      ,[vdg11]
      ,[vdg12]
      ,[vdg13]
      ,[vdg14]
      ,[vyk1]
      ,[vyk2]
      ,[vyk3]
      ,[vyk4]
      ,[vyk5]
      ,[vyk6]
      ,[vyk7]
      ,[vyk8]
      ,[vyk9]
      ,[vyk10]
      ,[vyk11]
      ,[vyk12]
      ,[vyk13]
      ,[vyk14]
      ,[vyk15]
      ,[vyk16]
      ,[vyk17]
      ,[vyk18]
      ,[vyk19]
      ,[vyk20]
      ,[vyk21]
      ,[vyk22]
      ,[vyk23]
      ,[vyk24]
      ,[vyk25]
      ,[por_hmot]
      ,[body]
      ,[zulp]
      ,[zum]
      ,[nakl_mat]
      ,[doklad]
      ,[zdroj]
      ,[upv]
      ,[in_ni_upv]
      ,[cel_body]
      ,[icz]
      ,[cvsp]
      ,[statut]
      ,[urgent]
      ,[skore_zav]
      ,[typ]
      ,[koef_zs]
      ,[odbpro]
	  ,[dwCurrentFlag]
      ,[dwDateFrom]
      ,[dwDateTo]
      ,[dwInserted]
      ,[dwModified]

FROM 

(	  
  MERGE INTO [dbo].[L1_SWLab_Pripady] AS target
  -- The source must be defined with the USING clause
  USING ' + QUOTENAME(@sourceTable) + N' AS source
  ON 
				/* CONDITION */
  (
	  ISNULL(target.[dwDatproRcKlinika], 0) = ISNULL( source.[dwDatproRcKlinika], 0)
	  AND ISNULL(target.[grouper], 0) = ISNULL(source.[grouper], 0)
	  AND  dwCurrentFlag = ''Y''
  )

		--		/* UPDATE RECORDS */
		--		/* MATCHED */

    WHEN MATCHED  
    AND (
--     ISNULL(target.[DatproRcKlinika], '''')			<>      ISNULL(source.[DatproRcKlinika]   , '''')
--      OR ISNULL(target.[dwLineage_Key], 0)		<>      ISNULL(source.[dwLineage_Key], 0)
       ISNULL(target.[dwModifiedRc], 0)				<>      ISNULL(source.[dwModifiedRc], 0)
-- [v2]           OR ISNULL(target.[pripad], 0)		<>      ISNULL(source.[pripad], 0)
      OR ISNULL(target.[datpri], ''1950-01-01'')    <>      ISNULL(source.[datpri], ''1950-01-01'')
--      OR ISNULL(target.[datpro], '''')				<>      ISNULL(source.[datpro], '''')
--      OR ISNULL(target.[rc], '''')					<>      ISNULL(source.[rc], '''')
      OR ISNULL(target.[zp], '''')					<>      ISNULL(source.[zp], '''')
      OR ISNULL(target.[vek], '''')					<>      ISNULL(source.[vek], '''')
      OR ISNULL(target.[pohlavi], '''')				<>      ISNULL(source.[pohlavi], '''')
      OR ISNULL(target.[doba_hosp], 0)				<>      ISNULL(source.[doba_hosp], 0)
      OR ISNULL(target.[ukonceni], '''')			<>      ISNULL(source.[ukonceni], '''')
      OR ISNULL(target.[icp], '''')					<>      ISNULL(source.[icp], '''')
--      OR ISNULL(target.[klinika], '''')				<>      ISNULL(source.[klinika], '''')
      OR ISNULL(target.[drg], '''')					<>      ISNULL(source.[drg], '''')
--     OR ISNULL(target.[grouper], 0)				<>      ISNULL(source.[grouper], 0)
      OR ISNULL(target.[typuhrady], '''')			<>      ISNULL(source.[typuhrady], '''')
      OR ISNULL(target.[rv], 0)						<>      ISNULL(source.[rv], 0)
      OR ISNULL(target.[rv_los], 0)					<>      ISNULL(source.[rv_los], 0)
      OR ISNULL(target.[rv_mat], 0)					<>      ISNULL(source.[rv_mat], 0)
      OR ISNULL(target.[osdoba], 0)					<>      ISNULL(source.[osdoba], 0)
      OR ISNULL(target.[inl_cas], '''')				<>      ISNULL(source.[inl_cas], '''')
      OR ISNULL(target.[inl_mat], '''')				<>      ISNULL(source.[inl_mat], '''')
      OR ISNULL(target.[dg], '''')					<>      ISNULL(source.[dg], '''')
      OR ISNULL(target.[vdg1], '''')				<>      ISNULL(source.[vdg1], '''')
      OR ISNULL(target.[vdg2], '''')				<>      ISNULL(source.[vdg2], '''')
      OR ISNULL(target.[vdg3], '''')				<>      ISNULL(source.[vdg3], '''')
      OR ISNULL(target.[vdg4], '''')				<>      ISNULL(source.[vdg4], '''')
      OR ISNULL(target.[vdg5], '''')				<>      ISNULL(source.[vdg5], '''')
      OR ISNULL(target.[vdg6], '''')				<>      ISNULL(source.[vdg6], '''')
      OR ISNULL(target.[vdg7], '''')				<>      ISNULL(source.[vdg7], '''')
      OR ISNULL(target.[vdg8], '''')				<>      ISNULL(source.[vdg8], '''')
      OR ISNULL(target.[vdg9], '''')				<>      ISNULL(source.[vdg9], '''')
      OR ISNULL(target.[vdg10], '''')				<>      ISNULL(source.[vdg10], '''')
      OR ISNULL(target.[vdg11], '''')				<>      ISNULL(source.[vdg11], '''')
      OR ISNULL(target.[vdg12], '''')				<>      ISNULL(source.[vdg12], '''')
      OR ISNULL(target.[vdg13], '''')				<>      ISNULL(source.[vdg13], '''')
      OR ISNULL(target.[vdg14], '''')				<>      ISNULL(source.[vdg14], '''')
      OR ISNULL(target.[vyk1], '''')				<>      ISNULL(source.[vyk1], '''')
      OR ISNULL(target.[vyk2], '''')				<>      ISNULL(source.[vyk2], '''')
      OR ISNULL(target.[vyk3], '''')				<>      ISNULL(source.[vyk3], '''')
      OR ISNULL(target.[vyk4], '''')				<>      ISNULL(source.[vyk4], '''')
      OR ISNULL(target.[vyk5], '''')				<>      ISNULL(source.[vyk5], '''')
      OR ISNULL(target.[vyk6], '''')				<>      ISNULL(source.[vyk6], '''')
      OR ISNULL(target.[vyk7], '''')				<>      ISNULL(source.[vyk7], '''')
      OR ISNULL(target.[vyk8], '''')				<>      ISNULL(source.[vyk8], '''')
      OR ISNULL(target.[vyk9], '''')				<>      ISNULL(source.[vyk9], '''')
      OR ISNULL(target.[vyk10], '''')				<>      ISNULL(source.[vyk10], '''')
      OR ISNULL(target.[vyk11], '''')				<>      ISNULL(source.[vyk11], '''')
      OR ISNULL(target.[vyk12], '''')				<>      ISNULL(source.[vyk12], '''')
      OR ISNULL(target.[vyk13], '''')				<>      ISNULL(source.[vyk13], '''')
      OR ISNULL(target.[vyk14], '''')				<>      ISNULL(source.[vyk14], '''')
      OR ISNULL(target.[vyk15], '''')				<>      ISNULL(source.[vyk15], '''')
      OR ISNULL(target.[vyk16], '''')				<>      ISNULL(source.[vyk16], '''')
      OR ISNULL(target.[vyk17], '''')				<>      ISNULL(source.[vyk17], '''')
      OR ISNULL(target.[vyk18], '''')				<>      ISNULL(source.[vyk18], '''')
      OR ISNULL(target.[vyk19], '''')				<>      ISNULL(source.[vyk19], '''')
      OR ISNULL(target.[vyk20], '''')				<>      ISNULL(source.[vyk20], '''')
      OR ISNULL(target.[vyk21], '''')				<>      ISNULL(source.[vyk21], '''')
      OR ISNULL(target.[vyk22], '''')				<>      ISNULL(source.[vyk22], '''')
      OR ISNULL(target.[vyk23], '''')				<>      ISNULL(source.[vyk23], '''')
      OR ISNULL(target.[vyk24], '''')				<>      ISNULL(source.[vyk24], '''')
      OR ISNULL(target.[vyk25], '''')				<>      ISNULL(source.[vyk25], '''')
      OR ISNULL(target.[por_hmot], 0)				<>      ISNULL(source.[por_hmot], 0)
      OR ISNULL(target.[body], 0)					<>      ISNULL(source.[body], 0)
      OR ISNULL(target.[zulp], 0)					<>      ISNULL(source.[zulp], 0)
      OR ISNULL(target.[zum], 0)					<>      ISNULL(source.[zum], 0)
      OR ISNULL(target.[nakl_mat], 0)				<>      ISNULL(source.[nakl_mat], 0)
      OR ISNULL(target.[doklad], 0)					<>      ISNULL(source.[doklad], 0)
      OR ISNULL(target.[zdroj], '''')				<>      ISNULL(source.[zdroj], '''')
      OR ISNULL(target.[upv], 0)					<>      ISNULL(source.[upv], 0)
      OR ISNULL(target.[in_ni_upv], 0)				<>      ISNULL(source.[in_ni_upv], 0)
      OR ISNULL(target.[cel_body], 0)				<>      ISNULL(source.[cel_body], 0)
      OR ISNULL(target.[icz], 0)					<>      ISNULL(source.[icz], 0)
      OR ISNULL(target.[cvsp], '''')				<>      ISNULL(source.[cvsp], '''')
      OR ISNULL(target.[statut], '''')				<>      ISNULL(source.[statut], '''')
      OR ISNULL(target.[urgent], '''')				<>      ISNULL(source.[urgent], '''')
      OR ISNULL(target.[skore_zav], 0)				<>      ISNULL(source.[skore_zav], 0)
      OR ISNULL(target.[typ], '''')					<>      ISNULL(source.[typ], '''')
      OR ISNULL(target.[koef_zs], 0)				<>      ISNULL(source.[koef_zs], 0)
      OR ISNULL(target.[odbpro], '''')				<>      ISNULL(source.[odbpro], '''')
	     )
	  THEN 
  UPDATE SET 
		dwDateTo =  DATEADD(DAY,-1, @effectiveDate)		--GetDate ()			--@dwDateTo																	--[ZMENA 2]																											--[ZMENA 2]					
		,dwCurrentFlag = ''N''
		,dwModified = CONVERT(varchar, GetDate(), 20)																											--[ZMENA 3]	  
		,dwChange = ''UPDATE - zneplatnění záznamu po změně''

		--		/* MATCHED */
	WHEN NOT MATCHED THEN  
	INSERT						
   (
		[dwModifiedRc]
		,[dwDatproRcKlinika]
		,[dwYearUctarna]
--      ,[dwLineage_Key]
      ,[pripad]
      ,[datpri]
      ,[datpro]
      ,[rc]
      ,[zp]
      ,[vek]
      ,[pohlavi]
      ,[doba_hosp]
      ,[ukonceni]
      ,[icp]
      ,[klinika]
      ,[drg]
      ,[grouper]
      ,[typuhrady]
      ,[rv]
      ,[rv_los]
      ,[rv_mat]
      ,[osdoba]
      ,[inl_cas]
      ,[inl_mat]
      ,[dg]
      ,[vdg1]
      ,[vdg2]
      ,[vdg3]
      ,[vdg4]
      ,[vdg5]
      ,[vdg6]
      ,[vdg7]
      ,[vdg8]
      ,[vdg9]
      ,[vdg10]
      ,[vdg11]
      ,[vdg12]
      ,[vdg13]
      ,[vdg14]
      ,[vyk1]
      ,[vyk2]
      ,[vyk3]
      ,[vyk4]
      ,[vyk5]
      ,[vyk6]
      ,[vyk7]
      ,[vyk8]
      ,[vyk9]
      ,[vyk10]
      ,[vyk11]
      ,[vyk12]
      ,[vyk13]
      ,[vyk14]
      ,[vyk15]
      ,[vyk16]
      ,[vyk17]
      ,[vyk18]
      ,[vyk19]
      ,[vyk20]
      ,[vyk21]
      ,[vyk22]
      ,[vyk23]
      ,[vyk24]
      ,[vyk25]
      ,[por_hmot]
      ,[body]
      ,[zulp]
      ,[zum]
      ,[nakl_mat]
      ,[doklad]
      ,[zdroj]
      ,[upv]
      ,[in_ni_upv]
      ,[cel_body]
      ,[icz]
      ,[cvsp]
      ,[statut]
      ,[urgent]
      ,[skore_zav]
      ,[typ]
      ,[koef_zs]
      ,[odbpro]
	  ,[dwDateFrom]
	  ,[dwInserted]				--NEW
  )

 VALUES 
  (
 source.[dwModifiedRc]
 ,source.[dwDatproRcKlinika]
 ,source.[dwYearUctarna]
--,source.[dwLineage_Key]
,source.[pripad]
,source.[datpri]
,source.[datpro]
,source.[rc]
,source.[zp]
,source.[vek]
,source.[pohlavi]
,source.[doba_hosp]
,source.[ukonceni]
,source.[icp]
,source.[klinika]
,source.[drg]
,source.[grouper]
,source.[typuhrady]
,source.[rv]
,source.[rv_los]
,source.[rv_mat]
,source.[osdoba]
,source.[inl_cas]
,source.[inl_mat]
,source.[dg]
,source.[vdg1]
,source.[vdg2]
,source.[vdg3]
,source.[vdg4]
,source.[vdg5]
,source.[vdg6]
,source.[vdg7]
,source.[vdg8]
,source.[vdg9]
,source.[vdg10]
,source.[vdg11]
,source.[vdg12]
,source.[vdg13]
,source.[vdg14]
,source.[vyk1]
,source.[vyk2]
,source.[vyk3]
,source.[vyk4]
,source.[vyk5]
,source.[vyk6]
,source.[vyk7]
,source.[vyk8]
,source.[vyk9]
,source.[vyk10]
,source.[vyk11]
,source.[vyk12]
,source.[vyk13]
,source.[vyk14]
,source.[vyk15]
,source.[vyk16]
,source.[vyk17]
,source.[vyk18]
,source.[vyk19]
,source.[vyk20]
,source.[vyk21]
,source.[vyk22]
,source.[vyk23]
,source.[vyk24]
,source.[vyk25]
,source.[por_hmot]
,source.[body]
,source.[zulp]
,source.[zum]
,source.[nakl_mat]
,source.[doklad]
,source.[zdroj]
,source.[upv]
,source.[in_ni_upv]
,source.[cel_body]
,source.[icz]
,source.[cvsp]
,source.[statut]
,source.[urgent]
,source.[skore_zav]
,source.[typ]
,source.[koef_zs]
,source.[odbpro]
, @effectiveDate
, GETDATE()
  )

      OUTPUT $ACTION
 ,source.[dwModifiedRc]
 ,source.[dwDatproRcKlinika]
 ,source.[dwYearUctarna]
,@dwLineageKey
,source.[pripad]
,source.[datpri]
,source.[datpro]
,source.[rc]
,source.[zp]
,source.[vek]
,source.[pohlavi]
,source.[doba_hosp]
,source.[ukonceni]
,source.[icp]
,source.[klinika]
,source.[drg]
,source.[grouper]
,source.[typuhrady]
,source.[rv]
,source.[rv_los]
,source.[rv_mat]
,source.[osdoba]
,source.[inl_cas]
,source.[inl_mat]
,source.[dg]
,source.[vdg1]
,source.[vdg2]
,source.[vdg3]
,source.[vdg4]
,source.[vdg5]
,source.[vdg6]
,source.[vdg7]
,source.[vdg8]
,source.[vdg9]
,source.[vdg10]
,source.[vdg11]
,source.[vdg12]
,source.[vdg13]
,source.[vdg14]
,source.[vyk1]
,source.[vyk2]
,source.[vyk3]
,source.[vyk4]
,source.[vyk5]
,source.[vyk6]
,source.[vyk7]
,source.[vyk8]
,source.[vyk9]
,source.[vyk10]
,source.[vyk11]
,source.[vyk12]
,source.[vyk13]
,source.[vyk14]
,source.[vyk15]
,source.[vyk16]
,source.[vyk17]
,source.[vyk18]
,source.[vyk19]
,source.[vyk20]
,source.[vyk21]
,source.[vyk22]
,source.[vyk23]
,source.[vyk24]
,source.[vyk25]
,source.[por_hmot]
,source.[body]
,source.[zulp]
,source.[zum]
,source.[nakl_mat]
,source.[doklad]
,source.[zdroj]
,source.[upv]
,source.[in_ni_upv]
,source.[cel_body]
,source.[icz]
,source.[cvsp]
,source.[statut]
,source.[urgent]
,source.[skore_zav]
,source.[typ]
,source.[koef_zs]
,source.[odbpro]
      ,''Y''														--[dwCurrentFlag]		
      ,@effectiveDate												--[dwDateFrom]					
      ,@dwDateTo													--[dwDateTo]										 
      ,GETDATE()													--[dwInserted]			
      ,GETDATE()													--[dwModified]					
) AS CHANGES 
(
	   ACTION
	  ,[dwModifiedRc]
	  ,[dwDatproRcKlinika]
	  ,[dwYearUctarna]
      ,[dwLineage_Key]
      ,[pripad]
      ,[datpri]
      ,[datpro]
      ,[rc]
      ,[zp]
      ,[vek]
      ,[pohlavi]
      ,[doba_hosp]
      ,[ukonceni]
      ,[icp]
      ,[klinika]
      ,[drg]
      ,[grouper]
      ,[typuhrady]
      ,[rv]
      ,[rv_los]
      ,[rv_mat]
      ,[osdoba]
      ,[inl_cas]
      ,[inl_mat]
      ,[dg]
      ,[vdg1]
      ,[vdg2]
      ,[vdg3]
      ,[vdg4]
      ,[vdg5]
      ,[vdg6]
      ,[vdg7]
      ,[vdg8]
      ,[vdg9]
      ,[vdg10]
      ,[vdg11]
      ,[vdg12]
      ,[vdg13]
      ,[vdg14]
      ,[vyk1]
      ,[vyk2]
      ,[vyk3]
      ,[vyk4]
      ,[vyk5]
      ,[vyk6]
      ,[vyk7]
      ,[vyk8]
      ,[vyk9]
      ,[vyk10]
      ,[vyk11]
      ,[vyk12]
      ,[vyk13]
      ,[vyk14]
      ,[vyk15]
      ,[vyk16]
      ,[vyk17]
      ,[vyk18]
      ,[vyk19]
      ,[vyk20]
      ,[vyk21]
      ,[vyk22]
      ,[vyk23]
      ,[vyk24]
      ,[vyk25]
      ,[por_hmot]
      ,[body]
      ,[zulp]
      ,[zum]
      ,[nakl_mat]
      ,[doklad]
      ,[zdroj]
      ,[upv]
      ,[in_ni_upv]
      ,[cel_body]
      ,[icz]
      ,[cvsp]
      ,[statut]
      ,[urgent]
      ,[skore_zav]
      ,[typ]
      ,[koef_zs]
      ,[odbpro]
     ,[dwCurrentFlag]														
     ,[dwDateFrom]															
     ,[dwDateTo]															
     ,[dwInserted]															
     ,[dwModified]															

)
where action=''UPDATE''
  ;	
	--END OF MERGE

	-- UPDATE [dwLineage_Key] After Inssert with null values
UPDATE [dbo].[L1_SWLab_Pripady]
    SET [dwLineage_Key] = @dwLineageKey
    WHERE [dwLineage_Key] IS NULL'				 -- Update only if the column is currently NULL

    EXEC sp_executesql 
			@sql, 
			N'@dwLineageKey int, @effectiveDate DATETIME2',
			@dwLineageKey,
			@effectiveDate = @effectiveDate;

    -- Parameterize your dynamic SQL to safely include @YearUctarna and @dwLineageKey
    EXEC sp_executesql @sql_deleted, N'@dwLineageKeyParam int', @dwLineageKey;

	COMMIT;

END TRY
	  BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		    SET @ErrorMessage = ERROR_MESSAGE();					-- Retrieves the specific error message
		
		        IF @@TRANCOUNT > 0
		        BEGIN	
		            ROLLBACK;
		        END					--
		EXEC LW.sp_Lineage_Fail @dwLineageKey, @ErrorMessage;		-- Re-throw the error to the client application
				
		     THROW;
		    END CATCH;

	    RETURN 0;
END

