import anydbm

class KEYRING:
    def __init__(self, loader):
        self.loader = loader
        self.db = None
        self.db = self.open()
        self.close()
    def open(self):
        if self.db != None:
            self.close()
        try:
            db = anydbm.open(self.loader.KEYRING, "c", 0600)
        except KeyboardInterrupt:
            return None
        return db
    def close(self):
        if self.db != None:
            self.db.close()
            self.db = None
    def isReady(self):
        return self.db != None