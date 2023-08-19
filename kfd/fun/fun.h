//
//  fun.h
//  kfd
//
//  Created by Seo Hyun-gyu on 2023/07/25.
//

#ifndef fun_h
#define fun_h

#include <stdbool.h>

void do_fun(char** enabledTweaks, int numTweaks, int res_y, int res_x, int subtype);
void backboard_respring(void);
void respring(void);
void DynamicKFD(int subtype);
void supervised(bool is);

#endif /* fun_h */
