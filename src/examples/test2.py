import clips6

e = clips6.ENV()
print e.RouterIO("out")
s = e.SHELL()
s.EXEC('(printout out "Hello World" crlf)')
r = clips6.ROUTERS.router("out")
print r.Read()