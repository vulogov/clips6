__author__ = 'Vladimir Ulogov'
import sys
import clips6
e = clips6.ENV()
print "ENV()",e,"READY?",e.isReady()
print "Testing SHELL()"
s = e.SHELL()
print "EVAL: (float 3.14):",s.EVAL("(float 3.14)")
print "EVAL: (integer 42):",s.EVAL("(integer 42)")
print "EVAL: 'This is a test':",s.EVAL('"This is a test"')
print 'EVAL: (create$ 3.14 42 "Boo"):',s.EVAL('(create$ 3.14 42 "Boo")')
print 'EVAL: (+ 2 2):',s.EVAL('(+ 2 2)')
print 'Bad expression EVAL: (2 2):',
try:
    s.EVAL('( 2 2)')
except clips6.EvalError, msg:
    print "Error caguht in the expression",msg
print "EXEC():",s.EXEC("(facts)")
print "EXEC():",s.EXEC('(printout t "Hello World !")')
print 'STRATEGY()',s.STRATEGY(clips6._BREADTH_STRATEGY)
print 'STRATEGY()',s.STRATEGY() == clips6._BREADTH_STRATEGY

print e.DLmodule("../modules/testmodule/testmod.so")
#print "EVAL:"
s.EXEC('(printout t "EXEC:" (getclock) crlf)')