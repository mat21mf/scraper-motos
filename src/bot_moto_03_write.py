#### Pendiente:
#### - regla jq para tasa cae que esta en distintas posiciones
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak03"]
strext = '.html'
xptmod = '/html/body/div[1]/ul/li[2]/div/dl/li/a'
xptitm = '//*[@id="content"]/ul/li/a'
xpttoc = '/html/body/nav[2]/div[2]'
xptbtn = '/html/body/div[1]/ul/li[2]/a'

#### Crear elementos lista 'www.yamahamotos.cl' {{{
lsttoc = browser.find_elements_by_xpath(xpttoc)
lstbtn = browser.find_elements_by_xpath(xptbtn)
lstmod = browser.find_elements_by_xpath(xptmod)
for nummod in range(0,len(lstmod)):
    lsttoc = browser.find_elements_by_xpath(xpttoc)
   #lsttoc[0].location_once_scrolled_into_view
    lsttoc[0].click()
    time.sleep(2)
    lstbtn = browser.find_elements_by_xpath(xptbtn)
    lstbtn[0].click()
    time.sleep(2)
    lstmod = browser.find_elements_by_xpath(xptmod)
    lstmod[nummod].click()
    time.sleep(5)
    lstitm = browser.find_elements_by_xpath(xptitm)
    for numitm in range(0,len(lstitm)):
        lstitm = browser.find_elements_by_xpath(xptitm)
        lstitm[numitm].location_once_scrolled_into_view
        print ""
        print "Clickando en item "+str(numitm).zfill(2)
        time.sleep(2)
       ## Escribir pagina a disco metodo 1 opcional
       #strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numitm).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
       #strcnt = browser.page_source.encode('utf-8')
       #with open(str(strfnm),'wb') as fle:
       #        fle.write(strcnt)
        # Escribir pagina a disco metodo 2
        strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numitm).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
        strlnk = urllib2.urlopen(lstitm[numitm].get_attribute('href'))
        strcnt = strlnk.read()
        with open(str(strfnm),'wb') as fle:
                fle.write(strcnt)
#### }}}

#### Generar linea {{{
# lstlon = [None] * len(lstmod)
# for numlon in range(0,len(lstmod)):
#     lstlon[numlon] = lstmod[numlon].get_attribute('text')
#### }}}
browser.quit()
