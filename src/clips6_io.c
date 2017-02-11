#include "clips.h"
#include "clips6_io.h"

int  cRegisterIO(void* theEnv, char *logicalName) {
    printf ("Registering %s\n", logicalName);
    return EnvAddRouter(theEnv, logicalName,0,
            FindCLP6IO,
            PrintCLP6IO,
            GetcCLP6IO,
            UngetcCLP6IO,
            ExitCLP6IO);
}