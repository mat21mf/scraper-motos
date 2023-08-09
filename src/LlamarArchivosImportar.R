load(".RData")

source("FuncionImportar.R")

Reporte_Precio_Motos_2018_04_17 <- ImportarDataframe( "Reporte_Precio_Motos_2018_04_17" , "../csv/Reporte_Precio_Motos_2018_04_17.csv" ) ; PreciosMotos <- data.frame(rbind(Reporte_Precio_Motos_2018_04_17))
Reporte_Precio_Motos_2018_04_22 <- ImportarDataframe( "Reporte_Precio_Motos_2018_04_22" , "../csv/Reporte_Precio_Motos_2018_04_22.csv" ) ; PreciosMotos <- data.frame(rbind(Reporte_Precio_Motos_2018_04_22))
Reporte_Precio_Motos_2018_04_23 <- ImportarDataframe( "Reporte_Precio_Motos_2018_04_23" , "../csv/Reporte_Precio_Motos_2018_04_23.csv" ) ; PreciosMotos <- data.frame(rbind(Reporte_Precio_Motos_2018_04_23))
Reporte_Precio_Motos_2018_04_25 <- ImportarDataframe( "Reporte_Precio_Motos_2018_04_25" , "../csv/Reporte_Precio_Motos_2018_04_25.csv" ) ; PreciosMotos <- data.frame(rbind(Reporte_Precio_Motos_2018_04_25))
Reporte_Precio_Motos_2018_04_26 <- ImportarDataframe( "Reporte_Precio_Motos_2018_04_26" , "../csv/Reporte_Precio_Motos_2018_04_26.csv" ) ; PreciosMotos <- data.frame(rbind(Reporte_Precio_Motos_2018_04_26))
Reporte_Precio_Motos_2018_04_27 <- ImportarDataframe( "Reporte_Precio_Motos_2018_04_27" , "../csv/Reporte_Precio_Motos_2018_04_27.csv" ) ; PreciosMotos <- data.frame(rbind(Reporte_Precio_Motos_2018_04_27))

PreciosMotos <- PreciosMotos[!duplicated(PreciosMotos),]

save.image()
