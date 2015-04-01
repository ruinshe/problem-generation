#ifndef __CDOJ_GENERATION_H__
#define __CDOJ_GENERATION_H__

#include <cstdio>
#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#endif
namespace generator {

int generate(size_t seed, FILE* input, FILE* output);

}

#ifdef __cplusplus
}
#endif

#endif // __CDOJ_GENERATION_H__

