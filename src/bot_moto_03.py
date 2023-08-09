#### chrome options {{{
start_time = time.time()
options = Options()
options.add_argument("disable-infobars")
browser = webdriver.Chrome(chrome_options=options)
browser.set_window_position(0, 0)
browser.set_window_size(1920/2, 1080)
browser.set_page_load_timeout(100)
browser.get(enlaces["strlnk03"])
time.sleep(10)
#### }}}

