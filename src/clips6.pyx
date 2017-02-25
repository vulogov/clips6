##
## This is main file for the clips6.so Python module
##

include "clips6_version.pyx"
include "clips_definitions.pyx"
include "clips6_imp.pyx"
##
## Check the required default modules
##
check_python_modules(default_python_modules, False)
include "userfun.pyx"
include "clips6_lib.pyx"
include "clp2py.pyx"
include "clips6_crypto.pyx"
include "clips6_package.pyx"
include "clips6_modldr.pyx"
include "clips6_env.pyx"
include "clips6_shell.pyx"
include "clips6_dynlib.pyx"
include "clips6_bufrouters.pyx"
include "clips6_facts.pyx"
include "clips6_module.pyx"


