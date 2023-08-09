#### Pendiente:
#### - cargar mas de 12 items por pagina
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak01"]
strext = '.html'
xptban = '/html/body/div[12]/div[3]/div/div/div/div[2]/div[3]/a'
xptmov = '//*[@id="content_sec"]/div[2]/div/div[4]/div[2]/ul/li/a'
xptmos = '//*[@id="showProducts-menu"]'
xptmas = '//*[@id="showProducts-menu"]/li[4]/a'
xptmod = '//*[@id="content_sec"]/div[1]/div[1]/div[1]/ul[1]/li/a'
xptitm = '//*[@id="content_sec"]/div[1]/div[1]/div[1]/ul[1]/ul/li/a'

#### Crear elementos lista 'www.imoto.cl' {{{
try:
    lstban = browser.find_elements_by_xpath(xptban)
    if lstban:
        lstban[0].click()
    lstmod = browser.find_elements_by_xpath(xptmod)
    lstmov = browser.find_elements_by_xpath(xptmov)
    lstlon = [None] * len(lstmod)
    for nummod in range(0,len(lstmod)):
        lstmod = browser.find_elements_by_xpath(xptmod)
        lstlon[nummod] = lstmod[nummod].get_attribute('text')
        lstitr = re.search('.* \(([0-9]+?)\)', lstlon[nummod]).group(1)
        lstmod[nummod].click()
        time.sleep(4)
        lstmov = browser.find_elements_by_xpath(xptmov)
        if lstmov:
            for numitm in range(0,len(lstmov)):
                lstmov = browser.find_elements_by_xpath(xptmov)
                lstmov[numitm].click()
                time.sleep(4)
                # Grabar a disco
                strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numitm).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
                strcnt = browser.page_source.encode('iso-8859-1')
                with open(str(strfnm),'wb') as fle:
                    fle.write(strcnt)
        else:
            strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(0).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
            strcnt = browser.page_source.encode('iso-8859-1')
            with open(str(strfnm),'wb') as fle:
                fle.write(strcnt)
    browser.quit()
    end_time = time.time()
    print ""
    print "Tiempo de duracion exitoso de {:.2f} minutos.".format((end_time - start_time) / 60.)

except:
    browser.quit()
    start_time = start_time
    end_time = time.time()
    print ""
    print "Tiempo de duracion con errores de {:.2f} minutos. Notificar.".format((end_time - start_time) / 60.)
    pass

#### }}}

#### Generar linea {{{
# lstlon = [None] * len(lstmod)
# for numlon in range(0,len(lstmod)):
#     lstlon[numlon] = lstmod[numlon].get_attribute('text')
#### }}}
