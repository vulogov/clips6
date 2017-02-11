#ifndef CLIPS6_IO
#define CLIPS6_IO

extern int  FindCLP6IO(void *theEnv, const char *logicalName);
extern int  ExitCLP6IO(void *,int);
extern int  PrintCLP6IO(void *,const char *,const char *);
extern int  GetcCLP6IO(void *,const char *);
extern int  UngetcCLP6IO(void *,int,const char *);
extern int RegisterIO(void* theEnv, char *logicalName);
extern int cRegisterIO(void *theEnv, char *logicalName);
extern int cDropIO(void *theEnv, char *logicalName);

#endif