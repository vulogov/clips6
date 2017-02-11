#include "clips.h"
#include "clips6_io.h"

int  cRegisterIO(void* theEnv, char *logicalName) {

    cDropIO(theEnv, logicalName);
    printf ("%s dropped\n", logicalName);
    return EnvAddRouter(theEnv, logicalName,0,
            FindCLP6IO,
            PrintCLP6IO,
            GetcCLP6IO,
            UngetcCLP6IO,
            ExitCLP6IO);
}

int cDropIO(void *theEnv, char *logicalName) {
    if (EnvDeactivateRouter(theEnv, logicalName) != 0) {
        printf("1\n");
        return EnvDeleteRouter(theEnv, logicalName);
    } else {
        printf("2 %s\n", logicalName);
        return 0;
    }
}