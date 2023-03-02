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
    def __setitem__(self, _i, _val):
        if(_i < 0):
            _i = len(self) - (_i * -1)
        self.arr.set(_i, _val)
    def __getitem__(self, _i):
        if(_i < 0):
            _i = len(self) - (_i * -1)
        cdef result res = self.arr.get(_i)
        return res.data[:res.len]
    def append(self, _val):
        self.arr.append(_val)
    def __len__(self):
        return self.arr.lenght()