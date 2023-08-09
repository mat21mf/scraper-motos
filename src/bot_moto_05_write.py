#### Pendiente:
#### - regla jq para tasa cae que esta en distintas posiciones
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak05"]
strext = '.html'
xptmod = '//*[@id="home_micrositio"]/div/div/div/div/a'
xptitm = '//*[@id="home_micrositio"]/div/div/div/div/a'
xpttoc = '/html/body/div[2]/header/nav/div[4]/a'
xptbtn = '//*[@id="navbar"]/div/ul/li[3]/a'

#### Crear elementos lista 'www.honda.cl' {{{
lsttoc = browser.find_elements_by_xpath(xpttoc)
lstbtn = browser.find_elements_by_xpath(xptbtn)
lstmod = browser.find_elements_by_xpath(xptmod)
lstmod = lstmod[:8]
lstitm = browser.find_elements_by_xpath(xptitm)
for nummod in range(0,len(lstmod)):
    lstmod = browser.find_elements_by_xpath(xptmod)
    lstmod = lstmod[:8]
    lstmod[nummod].click()
    time.sleep(8)
    lstitm = browser.find_elements_by_xpath(xptitm)
    for numitm in range(0,len(lstitm)):
        lstitm = browser.find_elements_by_xpath(xptitm)
        lstitm[numitm].location_once_scrolled_into_view
        lstitm[numitm].click()
        time.sleep(10)
        # Escribir pagina a disco
        strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numitm).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
        strcnt = browser.page_source.encode('utf-8')
        with open(str(strfnm),'wb') as fle:
                fle.write(strcnt)
        # Regresar nivel 2
        browser.back()
        time.sleep(4)
    # Regresar nivel 1
    lsttoc = browser.find_elements_by_xpath(xpttoc)
    lsttoc[0].click()
    lstbtn = browser.find_elements_by_xpath(xptbtn)
    lstbtn[0].click()
    time.sleep(4)
#### }}}

#### Generar linea {{{
lstmod = browser.find_elements_by_xpath(xptmod)
lstmod = lstmod[:8]
lstlon = [None] * len(lstmod)
lstlin = [None] * len(lstmod)
for numlon in range(0,len(lstmod)):
    lstlon[numlon] = lstmod[numlon].get_attribute('href')
    lstlin[numlon] = re.search('.*\/(.*)', lstlon[numlon]).group(1)
#### }}}
browser.quit()
