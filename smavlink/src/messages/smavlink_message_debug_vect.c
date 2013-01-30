/* This file has been autogenerated by Ivory
 * Compiler version  Version {versionBranch = [0,1,0,0], versionTags = []}
 */
#include <smavlink/pack.h>
#include "smavlink_message_debug_vect.h"
void smavlink_send_debug_vect(struct debug_vect_msg* n_var0,
                              struct smavlink_out_channel* n_var1,
                              struct smavlink_system* n_var2)
{
    uint8_t n_local0[30U] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                             0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    uint8_t* n_ref1 = n_local0;
    uint64_t n_deref2 = *&n_var0->time_usec;
    
    smavlink_pack_uint64_t((uint8_t*) n_ref1, 0U, n_deref2);
    
    float n_deref3 = *&n_var0->x;
    
    smavlink_pack_float((uint8_t*) n_ref1, 8U, n_deref3);
    
    float n_deref4 = *&n_var0->y;
    
    smavlink_pack_float((uint8_t*) n_ref1, 12U, n_deref4);
    
    float n_deref5 = *&n_var0->z;
    
    smavlink_pack_float((uint8_t*) n_ref1, 16U, n_deref5);
    
    uint8_t* n_let6 = n_var0->name;
    
    for (uint8_t n_ix7 = 0U % 10U; n_ix7 <= 9U % 10U; n_ix7 = n_ix7 + 1U %
         10U) {
        uint8_t n_deref8 = *&n_let6[n_ix7];
        
        smavlink_pack_uint8_t((uint8_t*) n_ref1, 20U + n_ix7, n_deref8);
    }
    smavlink_send_ivory(n_var1, n_var2, 250U, (uint8_t*) n_ref1, 30U, 49U);
    return;
}
void smavlink_unpack_debug_vect(struct debug_vect_msg* n_var0, const
                                uint8_t** n_var1)
{
    uint64_t n_r0 = smavlink_unpack_uint64_t(n_var1, 0U);
    
    *&n_var0->time_usec = n_r0;
    
    float n_r1 = smavlink_unpack_float(n_var1, 8U);
    
    *&n_var0->x = n_r1;
    
    float n_r2 = smavlink_unpack_float(n_var1, 12U);
    
    *&n_var0->y = n_r2;
    
    float n_r3 = smavlink_unpack_float(n_var1, 16U);
    
    *&n_var0->z = n_r3;
    for (uint8_t n_ix4 = 0U % 10U; n_ix4 <= 9U % 10U; n_ix4 = n_ix4 + 1U %
         10U) {
        uint8_t n_r5 = smavlink_unpack_uint8_t(n_var1, 20U + n_ix4);
        
        *&n_var0->name[n_ix4] = n_r5;
    }
}
