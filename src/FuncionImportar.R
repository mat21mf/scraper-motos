
#### Importar datos y verificar duplicados {{{
  ImportarDataframe <- function( strdfm , strcsv ) {
  if( file.size( strcsv ) > 0 ){
    # strdfm <- do.call( rbind, lapply(
    #           list.files( path="../motos/csv/",
    #           pattern="Reporte_Precio_Motos" ),
    #           read.csv, header=TRUE, sep="|",
    #           colClasses = c(
    #           rep( "character" , 2 ) ,
    #           rep( "integer"   , 3 ) ,
    #           rep( "character" , 2 ) ) ,
    #           na.strings = "NA" ) )
    strdfm <- read.csv( strcsv , header = T ,
                  sep = '|' ,
                  colClasses = c(
                  rep( "character" , 2 ) ,
                  rep( "integer"   , 3 ) ,
                  rep( "character" , 2 ) ) ,
                  na.strings = "NA" )
    return( strdfm )
  }
  }
#### }}}
