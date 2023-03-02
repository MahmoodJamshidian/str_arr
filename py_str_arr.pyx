from libc.stdint cimport *
from libcpp.vector cimport vector
cdef extern from "str_arr.hpp":
    cdef cppclass str_arr:
        str_arr()
        void append(char *)
        const char *get(size_t) except +IndexError const
        const char *operator[](size_t) except +IndexError const
        void set(size_t _i, char *) except +IndexError
        size_t lenght() const
        size_t index(char *) except +ValueError
        vector[size_t] index_all(char *) const
        void pop(size_t) except +IndexError


cdef class StrArray:
    cdef str_arr arr
    def __init__(self):
        pass
    def __setitem__(self, int _i, str _val):
        if(_i < 0):
            _i = len(self) - (_i * -1)
        self.arr.set(_i, _val.encode())
    def __getitem__(self, int _i):
        if(_i < 0):
            _i = len(self) - (_i * -1)
        return self.arr.get(_i).decode()
    def append(self, str _val):
        self.arr.append(_val.encode())
    def __len__(self):
        return self.arr.lenght()
    def index(self, str _val):
        return self.arr.index(_val.encode())
    def index_all(self, str _val):
        return list(self.arr.index_all(_val.encode()))
    def pop(self, int _i):
        if(_i < 0):
            _i = len(self) - (_i * -1)
        self.arr.pop(_i)