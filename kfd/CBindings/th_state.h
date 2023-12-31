
/*
 * Copyright (c) 2006, 2008 Apple,Inc. All rights reserved.
 *
 * @APPLE_LICENSE_HEADER_START@
 *
 * This file contains Original Code and/or Modifications of Original Code
 * as defined in and that are subject to the Apple Public Source License
 * Version 2.0 (the 'License'). You may not use this file except in
 * compliance with the License. Please obtain a copy of the License at
 * http://www.opensource.apple.com/apsl/ and read it before using this
 * file.
 *
 * The Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
 * Please see the License for the specific language governing rights and
 * limitations under the License.
 *
 * @APPLE_LICENSE_HEADER_END@
 */

#ifndef TH_STATE_H_
#define TH_STATE_H_

#include <stdint.h>
#include <mach/mach.h>

#ifdef __arm64__

uint64_t thread_state64_get_pc(const arm_thread_state64_t *ts);
void thread_state64_set_pc(arm_thread_state64_t *ts, uint64_t pc);
uint64_t thread_state64_get_lr(const arm_thread_state64_t *ts);
void thread_state64_set_lr(arm_thread_state64_t *ts, uint64_t lr);

#endif /* defined __arm64__ */

struct exception_message_reply {
    mach_msg_header_t hdr;
    NDR_record_t NDR;
    kern_return_t result;
};

#endif /* !defined TH_STATE_H_ */
