#### Pendiente:
#### - regla jq para tasa cae que esta en distintas posiciones
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak11"]
strext = '.html'
xptbtn = '//*[@id="MRcon"]/div/div[2]/div'
xptmod = '//*[@id="MRcon"]/div/div[2]/div/div/a'
xptbck = '//*[@id="location"]/div[2]/span[2]/a/span'

#### Crear elementos lista 'www.linhai.cl' {{{
lstbtn = browser.find_elements_by_xpath(xptbtn)
lstmod = browser.find_elements_by_xpath(xptmod)
lstbck = browser.find_elements_by_xpath(xptbck)
for nummod in range(0,len(lstmod)):
    lstbtn = browser.find_elements_by_xpath(xptbtn)
    lstbtn[nummod].location_once_scrolled_into_view
    lstbtn[nummod].click()
    time.sleep(2)
    lstmod = browser.find_elements_by_xpath(xptmod)
    lstmod[nummod].click()
    time.sleep(5)
    # Escribir pagina a disco
    strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(0).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
    strcnt = browser.page_source.encode('utf-8')
    with open(str(strfnm),'wb') as fle:
            fle.write(strcnt)
    # Regresar menu principal
    lstbck = browser.find_elements_by_xpath(xptbck)
    lstbck[0].click()
    time.sleep(5)
#### }}}

#### Generar linea {{{
# lstlon = [None] * len(lstmod)
# for numlon in range(0,len(lstmod)):
#     lstlon[numlon] = re.search('.*\/(.*)\..*',lstmod[numlon].get_attribute('title')).group(1)
#### }}}
browser.quit()
