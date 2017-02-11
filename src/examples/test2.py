import clips6

e = clips6.ENV()
print e.RouterIO("out")
s = e.SHELL()
s.EXEC('(printout out "Hello World" crlf)')
print repr(clips6.ROUTERS.routers["out"].buffer)