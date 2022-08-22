#include "Helpers.h"

// v1.02
const uint64_t dof_pv_set_enable_address = 0x000000014049F700;

HOOK(void, __fastcall, _dof_pv_set_enable, dof_pv_set_enable_address, __int64, __int8) {
    // v1.02
    *(uint8_t*)0x000000014CC2CFE8 = 0;
}

extern "C" __declspec(dllexport) void init() {
    INSTALL_HOOK(_dof_pv_set_enable);
}
