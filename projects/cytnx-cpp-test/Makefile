CYTNX_ROOT := ../../Cytnx_lib
CYTNX_INC := $(shell python -c "exec(\"import sys\nsys.path.append(\'$(CYTNX_ROOT)\')\nimport cytnx\nprint(cytnx.__cpp_include__)\")")
CYTNX_LDFLAGS := $(shell python -c "exec(\"import sys\nsys.path.append(\'$(CYTNX_ROOT)\')\nimport cytnx\nprint(cytnx.__cpp_linkflags__)\")")
CYTNX_LIB := $(shell python -c "exec(\"import sys\nsys.path.append(\'$(CYTNX_ROOT)\')\nimport cytnx\nprint(cytnx.__cpp_lib__)\")")/libcytnx.a
CYTNX_CXXFLAGS := $(shell python -c "exec(\"import sys\nsys.path.append(\'$(CYTNX_ROOT)\')\nimport cytnx\nprint(cytnx.__cpp_flags__)\")")

CC := g++
exe := cytnx-test
src := cytnx-test.cpp

all: $(src)
	    $(CC) -I$(CYTNX_INC) $(CYTNX_CXXFLAGS) $^ $(CYTNX_LIB) $(CYTNX_LDFLAGS) -o $(exe)

clean:
	    rm -rf $(exe)

