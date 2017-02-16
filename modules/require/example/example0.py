import clips6

env = clips6.ENV()
env.DLmodule("require.so")
s = env.SHELL()
print s.EVAL('(require-python "a" "b")')