import unittest

class TestExtFun(unittest.TestCase):
    def test_dlmod(self):
        import clips6
        e = clips6.ENV()
        self.assertTrue(e.DLmodule("../modules/testmodule/testmod.so"))
    def test_call_fun(self):
        import clips6
        e = clips6.ENV()
        e.DLmodule("../modules/testmodule/testmod.so")
        s = e.SHELL()
        self.assertEqual(s.EVAL('(TheAnswer)'), 42)
    def test_load_dir(self):
        import clips6
        e = clips6.ENV()
        e.DLmodule("../modules/example")
        s = e.SHELL()
        self.assertEqual(s.EVAL('(answer)'), 42)


if __name__ == '__main__':
    unittest.main()