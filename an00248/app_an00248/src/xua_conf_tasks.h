// Copyright 2025-2026 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.

on tile[0]: {
                xk_evk_xu316_AudioHwRemote(c_i2c);
            }


on tile[1]: {
                xk_evk_xu316_AudioHwChanInit(c_i2c);
            }
