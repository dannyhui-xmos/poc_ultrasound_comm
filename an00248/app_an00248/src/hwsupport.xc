// Copyright 2017-2026 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.

#include <xs1.h>
#include <assert.h>
#include <platform.h>

#include "xua.h"
#include "xk_evk_xu316/board.h"

on tile[1]: out port p_tone_x1d36 = XS1_PORT_1M;
on tile[1]: out port p_tone_x1d38 = XS1_PORT_1O;

void AudioHwInit()
{
    xk_evk_xu316_config_t hw_config = {MCLK_48};
    xk_evk_xu316_AudioHwInit(hw_config);

    const int samFreq = XUA_PDM_MIC_FREQ; /* xk_evk_xu316_AudioHwConfig doesn't like rates below 22kHz so force to 48k which works OK */
    xk_evk_xu316_AudioHwConfig(samFreq, MCLK_48, 0, 32, 32);

    return;
}

/* Configures the external audio hardware for the required sample frequency */
void AudioHwConfig(unsigned samFreq, unsigned mClk, unsigned dsdMode,
    unsigned sampRes_DAC, unsigned sampRes_ADC)
{
    /* Do nothing - Audio HW already setup by AudioHwInit */
    return;
}

void ultrasound_output_task()
{
    timer tmr;
    unsigned t;
    // Convert delay from ms to 100 Mhz timer ticks
    //const int delay_ticks = delay_in_ms * 100000;
    //const int delay_ticks = 50000; // 1kHz
    //const int delay_ticks = 1667;   // 30kHz
    //const int delay_ticks = 1562;   // 32kHz
    //const int delay_ticks = 1515;   // 33kHz
    const int delay_ticks = 1428;   // 35kHz
    // The value we are going to output
    unsigned val = 0x1;
    // read the initial timer value
    tmr :> t;
    while (1) {
        select {
            // This case will event when the timer moves past (t + delay_ticks ) i.e
            // delay_ticks after when we took the timestamp t
            case tmr when timerafter (t + delay_ticks) :> void:
                p_tone_x1d36 <: val;
                p_tone_x1d38 <: val;
                val = ~val;
                // set up the next event
                t += delay_ticks;
                break;
        }
    }
}
