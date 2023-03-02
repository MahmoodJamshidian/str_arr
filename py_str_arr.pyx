from libc.stdint cimport *
cdef extern from "py_str_arr.hpp":
    cdef struct result:
        char *data
        size_t len
    cdef cppclass py_str_arr:
        str_arr()
        void append(char *)
        result get(size_t) const
        result operator[](size_t) const
        void set(size_t _i, const char *)
        size_t lenght() const


cdef class StrArray:
    cdef py_str_arr arr
    def __init__(self):
        pass
    def __setitem__(self, int _i, str _val):
        if(_i < 0):
            _i = len(self) - (_i * -1)
        self.arr.set(_i, _val.encode())
    def __getitem__(self, int _i):
        if(_i < 0):
            _i = len(self) - (_i * -1)
        cdef result res = self.arr.get(_i)
        return res.data[:res.len].decode()
    def append(self, str _val):
        self.arr.append(_val.encode())
    def __len__(self):
        return self.arr.lenght()