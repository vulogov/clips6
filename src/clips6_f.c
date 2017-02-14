#include "clips.h"

int  cIsImplied(void* vTheFact) {
    struct fact *theFact = (struct fact *) vTheFact;

    printf("FFF: %s\n", theFact->whichDeftemplate->header.ppForm);

    if (theFact->whichDeftemplate->implied) {
        return 1;
    } else {
        return 0;
    }
}