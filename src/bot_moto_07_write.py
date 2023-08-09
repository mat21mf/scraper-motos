#### Pendiente:
#### - regla jq para tasa cae que esta en distintas posiciones
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak07"]
strext = '.html'
xptmod = '//*[@id="page"]/div/section/div/div/div/div/div/article/div[2]/h2/a'
xptitm = '//*[@id="page"]/div/div/section[2]/div[2]/div/div/div[2]/article/div[3]/a[1]'
xpttoc = '//*[@id="barmenu"]/a/span'
xptbck = '//*[@id="menu-item-30"]/a'

#### Crear elementos lista 'www.kymcomotos.cl' {{{
lstmod = browser.find_elements_by_xpath(xptmod)
lstitm = browser.find_elements_by_xpath(xptitm)
lsttoc = browser.find_elements_by_xpath(xpttoc)
lstbck = browser.find_elements_by_xpath(xptbck)
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
        # Regresar nivel 2
        browser.back()
        time.sleep(4)
    # Regresar nivel 1
    lsttoc = browser.find_elements_by_xpath(xpttoc)
    lsttoc[0].click()
    time.sleep(3)
    lstbck = browser.find_elements_by_xpath(xptbck)
    lstbck[0].click()
    time.sleep(4)
#### }}}

#### Generar linea {{{
# lstlon = [None] * len(lstmod)
# for numlon in range(0,len(lstmod)):
#     lstlon[numlon] = lstmod[numlon].get_attribute('title')
#### }}}
browser.quit()
