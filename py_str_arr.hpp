#include "str_arr.hpp"
#include <python3.11/Python.h>

struct result
{
    char *data;
    size_t len;
};


class py_str_arr: public str_arr
{
    public:
    py_str_arr(){}
    result get(size_t _i)
    {
        char *res;
        try
        {
            res = str_arr::get(_i);
        }
        catch(...)
        {
            PyErr_SetString(PyExc_IndexError, "index out of range");
            return {};
        }
        return {res, strlen(res)};
    }

    void set(size_t _i, const char *_val)
    {
        try
        {
            str_arr::set(_i, _val);
        }
        catch(...)
        {
            PyErr_SetString(PyExc_IndexError, "index out of range");
            return;
        }
    }

    result operator[](size_t _i) { return this->get(_i); }
};