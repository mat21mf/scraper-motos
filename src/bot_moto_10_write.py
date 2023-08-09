#### Pendiente:
#### - regla jq para tasa cae que esta en distintas posiciones
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak10"]
strext = '.html'
xptmod = '/html/body/div[3]/div/div/div/div[1]/a'
xptitm = '/html/body/div[3]/div/div/div[1]/div/div/a/p'

#### Crear elementos lista 'www.keeway.cl' {{{
lstmod = browser.find_elements_by_xpath(xptmod)
for nummod in range(0,len(lstmod)):
    lstmod = browser.find_elements_by_xpath(xptmod)
    lstmod[nummod].click()
    time.sleep(5)
    lstitm = browser.find_elements_by_xpath(xptitm)
    for numitm in range(0,len(lstitm)-1):
        lstitm = browser.find_elements_by_xpath(xptitm)
        lstitm[numitm].location_once_scrolled_into_view
        lstitm[numitm].click()
        time.sleep(5)
        # Escribir pagina a disco
        strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numitm).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
        strcnt = browser.page_source.encode('utf-8')
        with open(str(strfnm),'wb') as fle:
                fle.write(strcnt)
        # Regresar nivel 2
        browser.back()
        time.sleep(3)
    # Regresar nivel 1
    browser.back()
    time.sleep(3)
#### }}}

#### Generar linea {{{
# lstlon = [None] * len(lstmod)
# for numlon in range(0,len(lstmod)):
#     lstlon[numlon] = re.search('.*\/(.*)\/',lstmod[numlon].get_attribute('title')).group(1)
#### }}}
browser.quit()
