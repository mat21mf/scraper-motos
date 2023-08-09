#### Pendiente:
#### - regla jq para tasa cae que esta en distintas posiciones
#### - solo se extrajo motos de calle hay que subir nivel tags
dirhtm = os.path.abspath(os.path.join(os.getcwd(),'../motos/html/'))
strfle = marcas["strmak04"]
strext = '.html'
xptmod = '/html/body/div[2]/ul/li[2]/div/dl/li/a'
xptitm = '//*[@id="content"]/ul/li/a'
xptotm = '//*[@id="content"]/ul/li'
xpttoc = '/html/body/nav[2]/div[2]'
xptbtn = '/html/body/div[2]/ul/li[2]/a'

#### Objetos
#### - xptitm: almacena cada moto
#### - xptotm: almacena clase con linea de las motos
#### - xptmod: almacena enlace con linea de las motos
#### Falta
#### - loop externo solo para elementos listados en desorden
####   en lstitm pero ordenados en lstlab
#### - loop externo solo itera en elementos de lstitm que
####   estan previamente obtenidos de la lista lstlab
#### - lstmod contiene los elementos ordenados, pero con 2
####   regex extras que hay que eliminar
#### Relacion
#### - lstotm --> lstlon, lstrep (7) --> lstlab (3)
#### - lstmod --> lstlin (3)

#### Objetos lista {{{
lsttoc = browser.find_elements_by_xpath(xpttoc)
lstbtn = browser.find_elements_by_xpath(xptbtn)
lstmod = browser.find_elements_by_xpath(xptmod)
lstitm = browser.find_elements_by_xpath(xptitm)
lstotm = browser.find_elements_by_xpath(xptotm)
#### }}}

#### Generar clase (3) desde (7) {{{
lstcls = [None] * len(lstotm)
for numcls in range(0,len(lstotm)):
    lstcls[numcls] = lstotm[numcls].get_attribute('class')
#### }}}

#### Limpiar clase {{{
lstrep = [None] * len(lstcls)
for numrep in range(len(lstcls)):
    lstrep[numrep] = lstcls[numrep].replace('motos','')
    lstrep[numrep] = lstrep[numrep].replace('productos','')
    lstrep[numrep] = lstrep[numrep].replace('itemprod','')
    lstrep[numrep] = lstrep[numrep].replace(' ','')
   #print lstrep[numrep]
lstlab = list(sorted(set(lstrep),reverse=True))
#### }}}

#### Generar linea (3) {{{
lstlin = [None] * len(lstmod)
for numlin in range(0,len(lstmod)):
    lstlin[numlin] = re.search('.*\/#(.*)',lstmod[numlin].get_attribute('href')).group(1)
   #print lstlin[numlin]
#### }}}

#### No usar {{{
lstfak = [None] * len(lstitm)
for numfak in range(0,len(lstitm)):
    lstfak[numfak] = re.search('.*\/(.*)\/',lstitm[numfak].get_attribute('href')).group(1)
   #print lstfak[numfak]
#### }}}

#### Crear elementos lista 'www.euromot.cl' {{{
try:
    for nummod in range(0,len(lstmod)):
        lsttoc = browser.find_elements_by_xpath(xpttoc)
        lsttoc[0].click()
        time.sleep(3)
        lstbtn = browser.find_elements_by_xpath(xptbtn)
        lstbtn[0].click()
        time.sleep(3)
        lstmod = browser.find_elements_by_xpath(xptmod)
        lstmod[nummod].click()
        time.sleep(4)
        lstitm = browser.find_elements_by_xpath(xptitm)
        lstotm = browser.find_elements_by_xpath(xptotm)
        lsttar = [numtar for numtar in range(0,len(lstrep)) if lstrep[numtar] == lstlab[nummod]]
        for numobj in range(0,len(lsttar)):
            lstitm[lsttar[numobj]].location_once_scrolled_into_view
            lstitm[lsttar[numobj]].send_keys(Keys.SPACE)
            print ""
            print "Clickando en "+str(lstrep[lsttar[numobj]])+' '+str(lstfak[lsttar[numobj]])+' '+str(lsttar[numobj])
            time.sleep(2)
           ## Escribir pagina a disco metodo 1 opcional
           #strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numobj).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
           #strcnt = browser.page_source.encode('utf-8')
           #with open(str(strfnm),'wb') as fle:
           #        fle.write(strcnt)
            # Escribir pagina a disco metodo 2 definitivo
            strfnm = str(dirhtm)+'/'+str(strfle)+'_'+str(nummod).zfill(2)+'_'+str(numobj).zfill(2)+'_'+time.strftime("%Y_%m_%d")+str(strext)
            strlnk = urllib2.urlopen(lstitm[numobj].get_attribute('href'))
            strcnt = strlnk.read()
            with open(str(strfnm),'wb') as fle:
                    fle.write(strcnt)
        # Regresar 1
        browser.back()
        time.sleep(3)
        # Regresar 2
        browser.back()
        time.sleep(3)
#### }}}

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

