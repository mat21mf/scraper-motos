load(".RData")

source("FuncionExportar.R")

ExportarDataframe( Reporte_Precio_Motos_2018_04_17 , "../xlsx/Reporte_Precio_Motos_2018_04_17.xlsx" , "PreciosMotos" ) ; rm(Reporte_Precio_Motos_2018_04_17)
ExportarDataframe( Reporte_Precio_Motos_2018_04_22 , "../xlsx/Reporte_Precio_Motos_2018_04_22.xlsx" , "PreciosMotos" ) ; rm(Reporte_Precio_Motos_2018_04_22)
ExportarDataframe( Reporte_Precio_Motos_2018_04_23 , "../xlsx/Reporte_Precio_Motos_2018_04_23.xlsx" , "PreciosMotos" ) ; rm(Reporte_Precio_Motos_2018_04_23)
ExportarDataframe( Reporte_Precio_Motos_2018_04_25 , "../xlsx/Reporte_Precio_Motos_2018_04_25.xlsx" , "PreciosMotos" ) ; rm(Reporte_Precio_Motos_2018_04_25)
ExportarDataframe( Reporte_Precio_Motos_2018_04_26 , "../xlsx/Reporte_Precio_Motos_2018_04_26.xlsx" , "PreciosMotos" ) ; rm(Reporte_Precio_Motos_2018_04_26)
ExportarDataframe( PreciosMotos                    , "../xlsx/Reporte_Precio_Motos_2018_04_27.xlsx" , "PreciosMotos" ) ; rm(Reporte_Precio_Motos_2018_04_27)

save.image()
