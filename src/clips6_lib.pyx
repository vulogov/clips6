##
##
##
import os

def rchop(thestring, ending):
    """Chopping a string ending:

    1. thestring: source string
    2. ending: the tail which shall be removed"""
    if thestring.endswith(ending):
        return thestring[:-len(ending)]
    return thestring

def check_file(fname, mode):
    """
    Check if file exists and we can access it.

    1. :param fname: Filename
    2. :param mode: Access mode
    3. :return: True/False
    """
    fname = os.path.expandvars(fname)
    if os.path.exists(fname) and os.path.isfile(fname) and os.access(fname, mode):
        return True
    return False

def check_directory(dname):
    """
    Check if parameter is directory and we do have READ access to it

    1. :param dname: Directory name
    2. :return: True/False
    """
    dname = os.path.expandvars(dname)
    if os.path.exists(dname) and os.path.isdir(dname) and os.access(dname, os.R_OK):
        return True
    return False

def check_directory_write(dname):
    """
    Check if parameter is directory and we do have WRITE access to it

    1. :param dname: Directory name
    2. :return: True/False
    """
    dname = os.path.expandvars(dname)
    if os.path.exists(dname) and os.path.isdir(dname) and os.access(dname, os.W_OK):
        return True
    return False


def check_file_read(fname):
    """
    Check if parameter is a file and we do have READ access to it

    1. :param fname: Filename
    2. :return: True/False
    """
    return check_file(fname, os.R_OK)

def check_module(fname):
    """
    Check if parameter is a file, we do have READ access to it and it's size is greater than '0'

    1. :param fname: Filename
    2. :return: True/False
    """
    if not check_file_read(fname):
        return False
    if os.path.getsize(fname) > 0:
        return True
    return False

def check_file_write(fname):
    """
    Check if parameter is a file and we do have WRITE access to it

    1. :param fname: Filename
    2. :return: True/False
    """
    return check_file(fname, os.W_OK)

def check_file_exec(fname):
    """
    Check if parameter is a file and we do have EXEC access to it

    1. :param fname: Filename
    2. :return: True/False
    """
    return check_file(fname, os.X_OK)

def get_dir_content(dname):
    """
    Returning the list with directory content to which we do have READ access to

    1. :param dname: Directory name
    2. :return: List
    """
    if not check_directory(dname):
        return []
    ret = []
    for f in os.listdir(dname):
        if not check_file_read("%s/%s"%(dname, f)):
            continue
        ret.append((f, "%s/%s"%(dname, f), os.path.splitext(f)))
    return ret

def repeat(fun, log_fun, max_attempts, msg="Attempt: "):
    """
    Repeat function X until it returned True, otherwise number of times, with logging

    1. :param fun: Function
    2. :param log_fun: Logging function
    3. :param max_attempts: Maximum number of attempts
    4. :param msg: Add to a message
    5. :return: True/False
    """
    c = 0
    while c < max_attempts:
        log_fun("info", "%s (# %d)"%(msg, c))
        c += 1
        try:
            res = fun()
        except:
            continue
        if res != False:
            return True
    return False
