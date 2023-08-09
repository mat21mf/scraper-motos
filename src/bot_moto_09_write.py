#### Pendiente:
#### - regla jq para tasa cae que esta en distintas posiciones
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak09"]
strext = '.html'
xpttoc = '//*[@id="mobile-bars"]/span'
xptbtn = '//*[@id="mobile-submenu"]/ul/li[2]'
xptmod = '//*[@id="mobile-submenu"]/ul/li[2]/ul/li'

#### Crear elementos lista 'chile.benelli.com' {{{
lstmod = browser.find_elements_by_xpath(xptmod)
lsttoc = browser.find_elements_by_xpath(xpttoc)
lstbtn = browser.find_elements_by_xpath(xptbtn)
for nummod in range(0,len(lstmod)):
    # Definir items por modelo
    xptitm = '//*[@id="mobile-submenu"]/ul/li[2]/ul/li['+str(nummod+1)+']/ul/li'
    lstitm = browser.find_elements_by_xpath(xptitm)
    for numitm in range(0,len(lstitm)):
        # Abrir toc
        lsttoc = browser.find_elements_by_xpath(xpttoc)
        lsttoc[0].click()
        time.sleep(3)
        # Expandir nivel 1 modelos
        lstbtn = browser.find_elements_by_xpath(xptbtn)
        lstbtn[0].click()
        time.sleep(3)
        # Expandir nivel 2 items
        lstmod = browser.find_elements_by_xpath(xptmod)
        lstmod[nummod].click()
        time.sleep(3)
        # Ingresar nivel 2
        lstitm = browser.find_elements_by_xpath(xptitm)
        lstitm[numitm].click()
        time.sleep(10)
        # Escribir pagina a disco
        strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numitm).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
        strcnt = browser.page_source.encode('utf-8')
        with open(str(strfnm),'wb') as fle:
                fle.write(strcnt)
        # Regresar
        browser.back()
        time.sleep(3)
#### }}}

#### Generar linea {{{
# lstlon = [None] * len(lstmod)
# for numlon in range(0,len(lstmod)):
#     lstlon[numlon] = lstmod[numlon].get_attribute('title')
#### }}}
browser.quit()
