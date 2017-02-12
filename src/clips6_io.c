#include "clips.h"
#include "clips6_io.h"

int  cRegisterIO(void* theEnv, char *logicalName) {

    cDropIO(theEnv, logicalName);
    return EnvAddRouter(theEnv, logicalName,0,
            FindCLP6IO,
            PrintCLP6IO,
            GetcCLP6IO,
            UngetcCLP6IO,
            ExitCLP6IO);
}

int cDropIO(void *theEnv, char *logicalName) {
    if (EnvDeactivateRouter(theEnv, logicalName) != 0) {
        /* printf("D BOO1\n"); */
        return EnvDeleteRouter(theEnv, logicalName);
    } else {
        /* printf("D BOO2\n"); */
        return 0;
    }
}