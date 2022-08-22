OUT = PotatoMM
CXX = clang++
TARGET = x86_64-pc-windows-gnu
SRC = $(wildcard Source/*.cpp)
SRC += $(filter-out Dependencies/Detours/src/uimports.cpp,$(wildcard Dependencies/Detours/src/*.cpp))
OBJ = ${addprefix ${TARGET}/,${SRC:.cpp=.o}}
INCLUDE = -ISource -IDependencies/Detours/src
DEFINES = -DWIN32_LEAN_AND_MEAN -D_WIN32_WINNT=0x501
CXXFLAGS = -Wall -Wextra -Ofast  -target ${TARGET}
LDFLAGS = -shared -static -static-libstdc++ -static-libgcc -s -pthread -lpsapi

all: options ${OUT}

.PHONY: options
options:
	@echo "CXXFLAGS	= ${CXXFLAGS}"
	@echo "LDFLAGS		= ${LDFLAGS}"
	@echo "CXX		= ${CXX}"

.PHONY: dirs
dirs:
	@mkdir -p ${TARGET}/Source
	@mkdir -p ${TARGET}/Dependencies/Detours/src

${TARGET}/%.o: %.cpp
	@echo "BUILD	$@"
	@${CXX} -c ${CXXFLAGS} ${DEFINES} ${INCLUDE} $< -o $@

.PHONY: ${OUT}
${OUT}: dirs ${OBJ}
	@echo "LINK	$@"
	@${CXX} ${CXXFLAGS} ${DEFINES} ${INCLUDE} -o ${TARGET}/$@.dll ${OBJ} ${LDFLAGS} ${LIBS}

.PHONY: clean
clean:
	rm -rf ${TARGET}
