#ifndef CLIPS6_IO
#define CLIPS6_IO
extern int  FindCLP6IO(void *theEnv, char *logicalName);
extern int  ExitCLP6IO(void *,int);
extern int  PrintCLP6IO(void *,const char *,const char *);
extern int  GetcCLP6IO(void *,const char *);
extern int  UngetcCLP6IO(void *,int,const char *);
extern int RegisterIO(char *logicalName);
extern int _RegisterIO(char *logicalName);
#endif