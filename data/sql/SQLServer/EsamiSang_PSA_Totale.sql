SELECT TOP (1000) [id]
      ,[codiss]
      ,[dtExam]
      ,[esame]
      ,[esito]
      ,[unMisura]
      ,[valRifMin]
      ,[valRifMax]
      ,[allarme]
  FROM [aass].[dbo].[EsamiSangue]
  where 1=1 
   -- and esame like '%psa%'
   and dtexam = '30/12/2024'