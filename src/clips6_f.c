#include "clips.h"

int  cIsImplied(void* vTheFact) {
    struct fact *theFact = (struct fact *) vTheFact;

    if (theFact->whichDeftemplate->implied) {
        return 1;
    } else {
        return 0;
    }
}