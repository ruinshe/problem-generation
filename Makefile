CPP ?= g++
CPP_FLAGS ?= -O3 -Wall -std=gnu++0x -DONLINE_JUDGE -I.
LD_FLAGS ?= -O3 -Wall -std=gnu++0x -DONLINE_JUDGE
USER_LIBRARY_PATH ?= .
TARGETS = generator.bin
ifeq ($(OS), Windows_NT)
GENERATOR_DEPS = main.o ${USER_LIBRARY_PATH}/generator.dll \
								 ${USER_LIBRARY_PATH}/verifier.dll ${USER_LIBRARY_PATH}/solver.dll
else
GENERATOR_DEPS = main.o ${USER_LIBRARY_PATH}/libgenerator.so \
								 ${USER_LIBRARY_PATH}/libverifier.so ${USER_LIBRARY_PATH}/libsolver.so
endif
DATA_COUNT ?= 100
DATA_FOLDER ?= data
all: ${TARGETS}

generate: generator.bin
	seed=$$RANDOM; \
	for i in `seq 1 ${DATA_COUNT}`; \
	do \
		./generator.bin $$seed $$i ${DATA_FOLDER} ; \
		seed=`expr $$seed + 1`; \
	done

lib%.so: %.o
	${CPP} $< -o $@ -shared -fPIC ${CPP_FLAGS}

%.dll: %.o
	${CPP} $< -o $@ -shared -fPIC ${CPP_FLAGS}

generator.bin: ${GENERATOR_DEPS}
	${CPP} main.o -o $@ ${LD_FLAGS} -L${USER_LIBRARY_PATH} -lgenerator -lverifier -lsolver

${USER_LIBRARY_PATH}/%.o: %.cc
	${CPP} $< -c -o $@ ${CPP_FLAGS}

%.o: %.cc
	${CPP} $< -c -o $@ ${CPP_FLAGS}

clean:
	rm -f *.dll *.o *.so *.in *.out *.bin ${DATA_FOLDER}/* \
		${USER_LIBRARY_PATH}/*.so ${USER_LIBRARY_PATH}/*.dll

