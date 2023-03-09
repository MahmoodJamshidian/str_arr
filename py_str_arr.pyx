from libc.stdint cimport *
from libcpp.vector cimport vector
import warnings
cdef extern from "str_arr.hpp":
    cdef cppclass str_arr:
        str_arr()
        void _destruct()
        void append(char *)
        const char *get(size_t) except +IndexError const
        const char *operator[](size_t) except +IndexError const
        void set(size_t _i, char *) except +IndexError
        size_t lenght() const
        size_t index(char *) except +ValueError
        vector[size_t] index_all(char *) const
        void pop(size_t) except +IndexError


def NullCharWarning():
    warnings.warn("note that if there is a \\0 character in the string, it will not be saved from that character onwards")

cdef class StrArray:
    cdef str_arr arr
    def __init__(self):
        pass
    def __setitem__(self, int _i, str _val):
        if "\0" in _val:
            NullCharWarning()
        if(_i < 0):
            _i = len(self) - (_i * -1)
        self.arr.set(_i, _val.encode())
    def __getitem__(self, int _i):
        if(_i < 0):
            _i = len(self) - (_i * -1)
        return self.arr.get(_i).decode()
    def append(self, str _val):
        if "\0" in _val:
            NullCharWarning()
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
    def __iter__(self):
        return StrArrayIterator(self)
    def __delitem__(self, int _i):
        self.arr.pop(_i)
    def __del__(self):
        self.arr._destruct()

cdef class StrArrayIterator:
    cdef size_t _index
    cdef StrArray _arr
    def __init__(self, StrArray arr):
        self._arr = arr
        self._index = 0
    def __next__(self):
        self._index += 1
        if self._index <= len(self._arr):
            return self._arr[self._index-1]
        else:
            raise StopIteration