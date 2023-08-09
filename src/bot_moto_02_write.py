#### Pendiente:
#### - regla jq para tasa cae que esta en distintas posiciones
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak02"]
strext = '.html'
xptbox = '//*[@id="barmenu"]/a/span'
xpttoc = '//*[@id="menu-item-159"]'
xptitm = '//*[@id="page"]/div/div/section[2]/div[2]/div/div/div[2]/article/div[3]/a[1]'
xptmod = '//*[@id="page"]/div/section/div/div/div/div/div/article/div[2]/h2/a'

#### Crear elementos lista 'www.suzukimotos.cl' {{{
lstmod = browser.find_elements_by_xpath(xptmod)
for nummod in range(0,len(lstmod)):
    lstmod = browser.find_elements_by_xpath(xptmod)
    lstmod[nummod].click()
    time.sleep(5)
    lstitm = browser.find_elements_by_xpath(xptitm)
    for numitm in range(0,len(lstitm)):
        lstitm = browser.find_elements_by_xpath(xptitm)
        lstitm[numitm].click()
        time.sleep(5)
        # Escribir pagina a disco
        strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numitm).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
        strcnt = browser.page_source.encode('utf-8')
        with open(str(strfnm),'wb') as fle:
                fle.write(strcnt)
        # Volver a items
        browser.back()
        time.sleep(5)
    # Volver a modelos
    lstbox = browser.find_elements_by_xpath(xptbox)
    lstbox[0].click()
    time.sleep(2)
    lsttoc = browser.find_elements_by_xpath(xpttoc)
    lsttoc[0].click()
    time.sleep(5)
#### }}}

#### Generar linea {{{
# lstlon = [None] * len(lstmod)
# for numlon in range(0,len(lstmod)):
#     lstlon[numlon] = lstmod[numlon].get_attribute('title')
#### }}}
browser.quit()
