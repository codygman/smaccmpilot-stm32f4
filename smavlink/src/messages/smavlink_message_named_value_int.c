/* This file has been autogenerated by Ivory
 * Compiler version  Version {versionBranch = [0,1,0,0], versionTags = []}
 */
#include <smavlink/pack.h>
#include "smavlink_message_named_value_int.h"
void smavlink_send_named_value_int(struct named_value_int_msg* n_var0,
                                   struct smavlink_out_channel* n_var1,
                                   struct smavlink_system* n_var2)
{
    uint8_t n_local0[18U] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                             0};
    uint8_t* n_ref1 = n_local0;
    uint32_t n_deref2 = *&n_var0->time_boot_ms;
    
    smavlink_pack_uint32_t((uint8_t*) n_ref1, 0U, n_deref2);
    
    int32_t n_deref3 = *&n_var0->value;
    
    smavlink_pack_int32_t((uint8_t*) n_ref1, 4U, n_deref3);
    
    uint8_t* n_let4 = n_var0->name;
    
    for (uint8_t n_ix5 = 0U % 10U; n_ix5 <= 9U % 10U; n_ix5 = n_ix5 + 1U %
         10U) {
        uint8_t n_deref6 = *&n_let4[n_ix5];
        
        smavlink_pack_uint8_t((uint8_t*) n_ref1, 8U + n_ix5, n_deref6);
    }
    smavlink_send_ivory(n_var1, n_var2, 252U, (uint8_t*) n_ref1, 18U, 44U);
    return;
}
void smavlink_unpack_named_value_int(struct named_value_int_msg* n_var0, const
                                     uint8_t** n_var1)
{
    uint32_t n_r0 = smavlink_unpack_uint32_t(n_var1, 0U);
    
    *&n_var0->time_boot_ms = n_r0;
    
    int32_t n_r1 = smavlink_unpack_int32_t(n_var1, 4U);
    
    *&n_var0->value = n_r1;
    for (uint8_t n_ix2 = 0U % 10U; n_ix2 <= 9U % 10U; n_ix2 = n_ix2 + 1U %
         10U) {
        uint8_t n_r3 = smavlink_unpack_uint8_t(n_var1, 8U + n_ix2);
        
        *&n_var0->name[n_ix2] = n_r3;
    }
}
