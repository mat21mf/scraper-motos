#### librerias {{{
from portales_motos import enlaces,marcas,navegacion,extraccion
import sys, urllib2
import time, re, os
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
#### }}}

# def FuncionPrueba( script01 , script02 ):
#     try:
#         start_time = time.time()
#         execfile( script01 )
#         execfile( script02 )
#         end_time = time.time()
#         print ""
#         print "Tiempo de duracion exitoso de {:.2f} minutos.".format((end_time - start_time) / 60.)
#     except:
#         start_time = start_time
#         end_time = time.time()
#         print ""
#         print "Tiempo de duracion con errores de {:.2f} minutos. Notificar.".format((end_time - start_time) / 60.)
#         pass

# print marcas["strmak04"]
# print enlaces["strlnk04"]
# print navegacion["strnav04"]
# print extraccion["strext04"]

# FuncionPrueba( navegacion["strnav04"] , extraccion["strext04"] )
execfile('./bot_moto_01.py')
execfile('./bot_moto_01_write.py')
execfile('./bot_moto_04.py')
execfile('./bot_moto_04_write.py')
