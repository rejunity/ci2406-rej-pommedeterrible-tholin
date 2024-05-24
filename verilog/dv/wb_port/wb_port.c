/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include <defs.h>
#include <stub.c>

#define reg_mprj_proj_sel (*(volatile uint32_t*)0x30080000)
#define reg_mprj_counter (*(volatile uint32_t*)0x30040000)
#define reg_mprj_settings (*(volatile uint32_t*)0x30020000)
#define reg_mprj_invalid (*(volatile uint32_t*)0x30010000)

void delay(const int d) {
	reg_timer0_config = 0;
	reg_timer0_data = d;
	reg_timer0_config = 1;

	reg_timer0_update = 1;
	while (reg_timer0_value > 0) {
		reg_timer0_update = 1;
	}
}

void fail() {
    reg_mprj_datah = 0xFFFFFFFF;
    delay(4000000);
    while(1);
}

void main() {
    reg_wb_enable = 1;
    reg_gpio_mode1 = 1;
    reg_gpio_mode0 = 0;
    reg_gpio_ien = 1;
    reg_gpio_oe = 1;
    
    reg_mprj_io_37 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_datah = 0;
    reg_mprj_xfer = 1;
    while(reg_mprj_xfer == 1);
    
    reg_gpio_out = 0;
    reg_gpio_out = 1;
    reg_gpio_out = 0;
    
    reg_mprj_counter = 0;
    uint32_t prev_counter = reg_mprj_counter;
    uint32_t curr_counter = reg_mprj_counter;
    if(curr_counter <= prev_counter) fail();
    
    prev_counter = 0b10101; //Test value
    reg_mprj_proj_sel = prev_counter;
    prev_counter = 0b1110101;
    if(reg_mprj_proj_sel != prev_counter) fail();
    
    prev_counter = 0xDEADBEEF;
    reg_mprj_settings = prev_counter;
    if(reg_mprj_settings != prev_counter) fail();
    
    prev_counter = reg_mprj_counter;
    if(prev_counter <= curr_counter) fail();
    
    if(reg_mprj_invalid != 0xFFFFFFFF) fail();
    
    reg_gpio_out = 1;
    delay(4000000);
    reg_mprj_io_37 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_36 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_35 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_34 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_33 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_32 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_31 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_30 = GPIO_MODE_MGMT_STD_OUTPUT;
    while(1);
}
