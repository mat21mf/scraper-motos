#### Pendiente:
#### - cargar mas de 12 items por pagina
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak12"]
strext = '.html'
xpttoc = '//*[@id="header"]/div[2]/ul/li/a'
xptmov = '//*[@id="pagination"]/ul/li/a'

#### Crear elementos lista 'www.motossym.cl' {{{
lsttoc = browser.find_elements_by_xpath(xpttoc)
lsttoc = lsttoc[:3]
lstmov = browser.find_elements_by_xpath(xptmov)
for numtoc in range(0,len(lsttoc)):
    lsttoc = browser.find_elements_by_xpath(xpttoc)
    lsttoc = lsttoc[:3]
    lsttoc[numtoc].click()
    time.sleep(3)
    lstmov = browser.find_elements_by_xpath(xptmov)
    if lstmov:
        for numitm in range(1,len(lstmov)-1):
            lstmov = browser.find_elements_by_xpath(xptmov)
            lstmov[numitm].click()
            time.sleep(3)
            # Grabar a disco
            strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(numtoc).zfill(2)+'_'+str(numitm).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
            strcnt = browser.page_source.encode('iso-8859-1')
            with open(str(strfnm),'wb') as fle:
                fle.write(strcnt)
    else:
        # Grabar a disco
        strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(numtoc).zfill(2)+'_'+str(0).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
        strcnt = browser.page_source.encode('iso-8859-1')
        with open(str(strfnm),'wb') as fle:
            fle.write(strcnt)
#### }}}

#### Generar linea {{{
# lstlon = [None] * len(lsttoc)
# for numlon in range(0,len(lsttoc)):
#     lstlon[numlon] = lsttoc[numlon].get_attribute('text')
#### }}}
browser.quit()
