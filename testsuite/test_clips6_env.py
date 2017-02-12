import unittest

class TestEnv(unittest.TestCase):
    def test_env_creation(self):
        import clips6
        e = clips6.ENV()
        self.assertTrue(e.isReady())
    def test_shell_creation(self):
        import clips6
        e = clips6.ENV()
        s = e.SHELL()
        self.assertTrue(s.isReady())

class TestStreams(unittest.TestCase):
    def test_routers(self):
        import clips6
        self.assertEqual(type(clips6.ROUTERS.routers),type({}))
    def test_register_router(self):
        import clips6
        e=clips6.ENV()
        self.assertTrue(e.RouterIO("test"))
        e.DropIO("test")
    def test_drop_router(self):
        import clips6
        e = clips6.ENV()
        e.RouterIO("test")
        self.assertTrue(e.DropIO("test"))


if __name__ == '__main__':
    unittest.main()