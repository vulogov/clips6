__author__ = 'Vladimir Ulogov'
import sys
import clips6
e = clips6.ENV()
print "ENV()",e,"READY?",e.isReady()
e.RouterIO("t")
print "Testing SHELL()"
s = e.SHELL()
print "EVAL: (float 3.14):",s.EVAL("(float 3.14)")
print "EVAL: (integer 42):",s.EVAL("(integer 42)")
print "EVAL: 'This is a test':",s.EVAL('"This is a test"')
print 'EVAL: (create$ 3.14 42 "Boo"):',s.EVAL('(create$ 3.14 42 "Boo")')
print 'EVAL: (+ 2 2):',s.EVAL('(+ 2 2)')
#print "EXEC():",s.EXEC('(printout t "Before the exception!" crlf )')
#print 'Bad expression EVAL: (2 2):',
#try:
#    s.EVAL('( 2 2)')
#except clips6.EvalError, msg:
#    print "Error caguht in the expression",msg
print "EXEC():",s.EXEC("(facts)")
print "EXEC():",s.EXEC('(printout t "Hello World !" crlf )')
print 'STRATEGY()',s.STRATEGY(clips6._BREADTH_STRATEGY)
print 'STRATEGY()',s.STRATEGY() == clips6._BREADTH_STRATEGY

print "e.DLmodule(...): "
res = e.DLmodule("../modules/testmodule/testmod.so")
print "e.DLmodule(...) outcome:",res
#print "EVAL:"
print "="*30
s.EXEC('(printout t "EXEC:" (getclock) crlf)')
s.EVAL('(create$ (getclock))')
print "EVAL('(print_params ...)')"
res = s.EVAL('(print_params 42 3.14 hello "world" (create$ the list))')
print "The result is ",res
print "EVAL('(makeA)')"
res = s.EVAL('(makeA)')
print "As VOID:",res
a = res.object()
print "As Object",a
print dir(a)


m = e.currentModule()
print "Testing MODULE().currentModule()",m
print "Testing MODULE().Print()",m.Print()
print "Testing MODULE().currentModule()",m.currentModule()
print "Testing ENV()['MAIN']",e['MAIN']
print "Testing ENV()['MODULENOTEXISTS']",
try:
    e['MODULENOTEXISTS']
    print "FAIL"
except KeyError:
    print "OK"

fcts = e.FACTS()
print "Testing ENV().CLEAR()",e.CLEAR()
print "Testing ENV().LOAD()",e.LOAD("clips/test1.clp")
print "Testing ENV().BUILD()",e.BUILD("(deffunction bar ())")
print "Testing ENV().IS_CHANGED()",e.IS_CHANGED()
f = fcts.ASSERT("(example (x 3) (y red) (z 1.5 b))")
print "ASSERT()",f
f2 = fcts.ASSERT("(example (x 2) (y blue) (z 42.0 a))")
print "ASSERT()",f2
f3 = fcts.ASSERT("(example (x 1) (y black) (z 41.0 c))")
print "ASSERT()",f3
f4 = fcts.ASSERT("(hello world)")
print "ASSERT()",f4
print "IMPLIED()",f4.IMPLIED()
print "Testing ASSERTS()",fcts.ASSERTS("(example (x 4) (y pink) (z 40.0 d)) (example (x 5) (y yellow) (z 400.0 v))")
print "Testing ENV().IS_CHANGED()",e.IS_CHANGED()
print "Testing Facts"

print "Testing FACT().Print()", repr(f)
print "Testing FACT().EXISTS()", f.EXISTS()
print "Testing FACT().KEYS()", f.KEYS()
print "Testing FACT()['y']",f['y']
print "Testing FACT()['z']",f['z']

facts = fcts.FACTS()
print "Testing ENV.FACTS()"
for fact in facts:
    print fact
print "Will RETRACT()",f
print "FACT().RETRACT()",f.RETRACT()
print "Testing FACT().EXISTS() after RETRACT()", f.EXISTS()
print "Updated list of FACTS()"
for f in fcts.FACTS():
    print f
print "Work with FACTS() transaction"
trid = fcts.BEGIN()
print "BEGIN()",trid
fcts.ASSERT("(example (x 81) (y mauve) (z 13.5 v))", trid)
print "COMMIT()",fcts.COMMIT(trid)
print "Updated list of FACTS()"
for f in fcts.FACTS():
    print f