str_arr (String Array)
======================

A library for managing arrays of string values, developed for C++ and Python

How does this library work?
---------------------------

This library uses a variable to store all the data, and when a value is given to the array for storage, `the number of characters + 1` (I will explain later) is added to the value of the variable space, then the value given in one byte after the last byte before adding the storage space (in the example I will explain, you will understand exactly what happens) writes the values and in the last remaining byte the value null (0x0) is written (so that the values separated)

### Consider the following example:

Suppose we want to store `all` and `py` values in a cart.

At the time of creating the array, the storage variable is created, but no space has been allocated.

When the first value (`all`) is stored, the memory looks like this:

| index | value | hax  | decimal |
| ----- | ----- | ---- | ------- |
| 0     | a     | 0x61 | 97      |
| 1     | l     | 0x6c | 108     |
| 2     | l     | 0x6c | 108     |
| 3     | NULL  | 0x0  | 0       |

Then the next statement (`py`) will be stored as:

| index | value | hax  | decimal |
| ----- | ----- | ---- | ------- |
| 0     | a     | 0x61 | 97      |
| 1     | l     | 0x6c | 108     |
| 2     | l     | 0x6c | 108     |
| 3     | NULL  | 0x00 | 0       |
| 4     | p     | 0x70 | 112     |
| 5     | y     | 0x79 | 121     |
| 6     | NULL  | 0x00 | 0       |

And this process will continue

also, there are other operations such as extracting and making changes, but due to the complexity, there is no need to explain.

How to use this?
----------------

### use for C++
If you want to use it in C++, you must put the str_arr.hpp file next to your program or put it in the include path.

### use for Python
If you want to use it in Python, you have to do a build operation, ensure that python, cython and g++ (minGW) and make are installed.

If you want to use it in Python, there are two solutions for you, you can download the build version or build it yourself (if the Python version you want is not available, you have to build it)

If the version you want exists, download and extract it and put the `py_str_arr.so` or `py_str_arr.pyd` files (based on the type of operating system) and the `py_str_arr.pyi` file next to your project and import it.
If you need to build, you must install the following programs:

- Python (version you want)
- Cython
- g++ (minGW for windows)
- Make (It is installed in Windows along with minGW)

After cloning, enter its path and enter the following commands:
```console
$ make
$ make clean
```

If the operation is successful, copy and use the files `py_str_arr.so` or `py_str_arr.pyd` (based on the type of operating system) and `py_str_arr.pyi` in the desired project path.
