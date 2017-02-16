# How to create a clips6 extension package

### What is the package in a nutshell ?

clips6 extension package, is the way for the developer to put together and load together the varoups components of the code, the ones which is coded in Python or "C" and the ones in CLIPS.
 
### The structure of the package.

clips6 package is a directory in which yo are installing _"*.so"_, _"*.clp"_ and "<package name>.module" files. The file with extension ".module" is called a **Package manifest**. 

- When loading the package, first what's clips6 will search in the package directory is a **Package manifest**. Format of the manifest file is very simple: is it a list of the file-names which need's to be loaded into a clips6 environment. Emppty lines and lines beginning with _"#"_ (_hash sign_) will be ignored. The package content will be loaded in exact order as specified in the manifest. Please note, there shall be only one **Package manifest** per package.
- _*.so_ files, will be treated as _shared library modules_
- _*.clp_ files, will be treated as the files containing CLIPS constructs

### Example of the package

Please take a loook at the [sample package](../modules/example). Pay particular attention to the [CMakeLists.txt](../modules/example/CMakeLists.txt) as it containing specific clauses for the package installation
