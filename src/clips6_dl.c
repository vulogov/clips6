#include <dlfcn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "clips.h"

char* clips6_dl(void *env, char *dl_name, char *symname, char *fun_name, char *params, char *retval) {
    char *error;
    void *handle;
    void (*ffun)(void*);

    /* printf("!!! %x %s %s %s %s %s\n", env, dl_name, symname, fun_name, params, retval); */
    dlerror();
    if ((handle = dlopen(dl_name, RTLD_NOW)) == NULL) {
        error = dlerror();
        return error;
    }
    ffun = dlsym(handle, symname);
    if ((error = dlerror()) != NULL) {
        return error;
    }
    /* printf("FFUN: %x\n", ffun); */
    EnvDefineFunction2(env, fun_name, retval[0], PTIEF ffun, fun_name, params);
    return NULL;
}