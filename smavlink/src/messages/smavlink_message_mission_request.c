/* This file has been autogenerated by Ivory
 * Compiler version  Version {versionBranch = [0,1,0,0], versionTags = []}
 */
#include <smavlink/pack.h>
#include "smavlink_message_mission_request.h"
void smavlink_send_mission_request(struct mission_request_msg* n_var0,
                                   struct smavlink_out_channel* n_var1,
                                   struct smavlink_system* n_var2)
{
    uint8_t n_local0[4U] = {0, 0, 0, 0};
    uint8_t* n_ref1 = n_local0;
    uint16_t n_deref2 = *&n_var0->mission_request_seq;
    
    smavlink_pack_uint16_t((uint8_t*) n_ref1, 0U, n_deref2);
    
    uint8_t n_deref3 = *&n_var0->target_system;
    
    smavlink_pack_uint8_t((uint8_t*) n_ref1, 2U, n_deref3);
    
    uint8_t n_deref4 = *&n_var0->target_component;
    
    smavlink_pack_uint8_t((uint8_t*) n_ref1, 3U, n_deref4);
    smavlink_send_ivory(n_var1, n_var2, 40U, (uint8_t*) n_ref1, 4U, 230U);
    return;
}
void smavlink_unpack_mission_request(struct mission_request_msg* n_var0, const
                                     uint8_t** n_var1)
{
    uint16_t n_r0 = smavlink_unpack_uint16_t(n_var1, 0U);
    
    *&n_var0->mission_request_seq = n_r0;
    
    uint8_t n_r1 = smavlink_unpack_uint8_t(n_var1, 2U);
    
    *&n_var0->target_system = n_r1;
    
    uint8_t n_r2 = smavlink_unpack_uint8_t(n_var1, 3U);
    
    *&n_var0->target_component = n_r2;
}
