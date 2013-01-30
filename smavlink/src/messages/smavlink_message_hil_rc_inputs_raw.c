/* This file has been autogenerated by Ivory
 * Compiler version  Version {versionBranch = [0,1,0,0], versionTags = []}
 */
#include <smavlink/pack.h>
#include "smavlink_message_hil_rc_inputs_raw.h"
void smavlink_send_hil_rc_inputs_raw(struct hil_rc_inputs_raw_msg* n_var0,
                                     struct smavlink_out_channel* n_var1,
                                     struct smavlink_system* n_var2)
{
    uint8_t n_local0[33U] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                             0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    uint8_t* n_ref1 = n_local0;
    uint64_t n_deref2 = *&n_var0->time_usec;
    
    smavlink_pack_uint64_t((uint8_t*) n_ref1, 0U, n_deref2);
    
    uint16_t n_deref3 = *&n_var0->chan1_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 8U, n_deref3);
    
    uint16_t n_deref4 = *&n_var0->chan2_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 10U, n_deref4);
    
    uint16_t n_deref5 = *&n_var0->chan3_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 12U, n_deref5);
    
    uint16_t n_deref6 = *&n_var0->chan4_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 14U, n_deref6);
    
    uint16_t n_deref7 = *&n_var0->chan5_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 16U, n_deref7);
    
    uint16_t n_deref8 = *&n_var0->chan6_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 18U, n_deref8);
    
    uint16_t n_deref9 = *&n_var0->chan7_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 20U, n_deref9);
    
    uint16_t n_deref10 = *&n_var0->chan8_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 22U, n_deref10);
    
    uint16_t n_deref11 = *&n_var0->chan9_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 24U, n_deref11);
    
    uint16_t n_deref12 = *&n_var0->chan10_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 26U, n_deref12);
    
    uint16_t n_deref13 = *&n_var0->chan11_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 28U, n_deref13);
    
    uint16_t n_deref14 = *&n_var0->chan12_raw;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 30U, n_deref14);
    
    uint8_t n_deref15 = *&n_var0->rssi;
    
    smavlink_pack_uint8_t((uint8_t*) n_ref1, 32U, n_deref15);
    smavlink_send_ivory(n_var1, n_var2, 92U, (uint8_t*) n_ref1, 33U, 54U);
    return;
}
void smavlink_unpack_hil_rc_inputs_raw(struct hil_rc_inputs_raw_msg* n_var0,
                                       const uint8_t** n_var1)
{
    uint64_t n_r0 = smavlink_unpack_uint64_t(n_var1, 0U);
    
    *&n_var0->time_usec = n_r0;
    
    uint16_t n_r1 = smavlink_unpack_uint16_t(n_var1, 8U);
    
    *&n_var0->chan1_raw = n_r1;
    
    uint16_t n_r2 = smavlink_unpack_uint16_t(n_var1, 10U);
    
    *&n_var0->chan2_raw = n_r2;
    
    uint16_t n_r3 = smavlink_unpack_uint16_t(n_var1, 12U);
    
    *&n_var0->chan3_raw = n_r3;
    
    uint16_t n_r4 = smavlink_unpack_uint16_t(n_var1, 14U);
    
    *&n_var0->chan4_raw = n_r4;
    
    uint16_t n_r5 = smavlink_unpack_uint16_t(n_var1, 16U);
    
    *&n_var0->chan5_raw = n_r5;
    
    uint16_t n_r6 = smavlink_unpack_uint16_t(n_var1, 18U);
    
    *&n_var0->chan6_raw = n_r6;
    
    uint16_t n_r7 = smavlink_unpack_uint16_t(n_var1, 20U);
    
    *&n_var0->chan7_raw = n_r7;
    
    uint16_t n_r8 = smavlink_unpack_uint16_t(n_var1, 22U);
    
    *&n_var0->chan8_raw = n_r8;
    
    uint16_t n_r9 = smavlink_unpack_uint16_t(n_var1, 24U);
    
    *&n_var0->chan9_raw = n_r9;
    
    uint16_t n_r10 = smavlink_unpack_uint16_t(n_var1, 26U);
    
    *&n_var0->chan10_raw = n_r10;
    
    uint16_t n_r11 = smavlink_unpack_uint16_t(n_var1, 28U);
    
    *&n_var0->chan11_raw = n_r11;
    
    uint16_t n_r12 = smavlink_unpack_uint16_t(n_var1, 30U);
    
    *&n_var0->chan12_raw = n_r12;
    
    uint8_t n_r13 = smavlink_unpack_uint8_t(n_var1, 32U);
    
    *&n_var0->rssi = n_r13;
}
