
#### Crear Excel con formato {{{
  ExportarDataframe <- function( strdfm , strfle , strsht ) {
    require( openxlsx )
    numberStyle <- createStyle( numFmt = "#,#0" )
    texttoStyle <- createStyle( numFmt = "TEXT"    )
    headerStyle <- createStyle(
    fontSize = 12 ,
    fontColour = "#FFFFFF" ,
    halign = "center" ,
    fgFill = "#4F81BD" ,
    border = "TopBottom" ,
    borderColour = "#4F81BD" ,
    wrapText = FALSE )
    dfmsht = strdfm
    rpnup = strfle
    spnup = strsht
    if( file.exists( rpnup ) ) file.remove( rpnup )
    wbnup <- createWorkbook( rpnup )
    addWorksheet( wbnup , spnup           )
    writeData(    wbnup , spnup            , dfmsht      , startCol = 1 )
    addStyle(     wbnup ,  1 , headerStyle , rows = 1 , cols = 1:ncol( dfmsht )          , gridExpand = TRUE )
    addStyle(     wbnup ,  1 , numberStyle , rows = 2:nrow( dfmsht ) , cols = c(3,4,5)   , gridExpand = TRUE )
    addStyle(     wbnup ,  1 , texttoStyle , rows = 2:nrow( dfmsht ) , cols = c(1,2,6,7) , gridExpand = TRUE )
    freezePane(   wbnup ,  1 , firstActiveRow = 2 )
    setColWidths( wbnup ,  1 , cols = c(1,2,3,4,5,6,7) , widths = c(15,40,15,15,15,15,15) )
    saveWorkbook( wbnup , file = rpnup , overwrite = TRUE )
  }
#### }}}

