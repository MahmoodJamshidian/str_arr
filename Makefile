PYTHON=python3.11
INCLUDE_DIR=/usr/include/python3.11
LIBRARY_DIR=/usr/lib/python3.11
LIBRARY_NAME=python311
CPYC=cython
CPPC=g++

build: py_str_arr.* str_arr.hpp
	mkdir -p build
	$(PYTHON) -m $(CPYC) -3 -v --cplus -o build/py_str_arr.cpp py_str_arr.pyx
	$(CPPC) -c -fPIC -Ofast -I$(INCLUDE_DIR) -o build/py_str_arr.o build/py_str_arr.cpp -I.
ifeq ($(OS),Windows_NT)
	$(CPPC) -shared -L$(LIBRARY_DIR) -o py_str_arr.pyd build/py_str_arr.o -l$(LIBRARY_NAME)
else
	$(CPPC) -shared -L$(LIBRARY_DIR) -o py_str_arr.so build/py_str_arr.o
endif

clean:
ifeq ($(OS),Windows_NT)
	rmdir build
else
	rm -rf build
endif
