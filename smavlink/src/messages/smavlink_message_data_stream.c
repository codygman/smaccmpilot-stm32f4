/* This file has been autogenerated by Ivory
 * Compiler version  5326f414a5a63af59269d31f823a2e142af0b2c9
 */
#include <out.h>
#include <smavlink/pack.h>
#include "smavlink_message_data_stream.h"
void smavlink_send_data_stream(struct data_stream_msg* n_var0,
                               struct smavlink_out_channel* n_var1,
                               struct smavlink_system* n_var2)
{
    uint8_t n_local0[4U] = {0, 0, 0, 0};
    uint8_t(* n_ref1)[4U] = &n_local0;
    uint16_t n_deref2 = *&n_var0->message_rate;
    
    smavlink_pack_uint16_t(n_ref1, 0U, n_deref2);
    
    uint8_t n_deref3 = *&n_var0->stream_id;
    
    smavlink_pack_uint8_t(n_ref1, 2U, n_deref3);
    
    uint8_t n_deref4 = *&n_var0->on_off;
    
    smavlink_pack_uint8_t(n_ref1, 3U, n_deref4);
    smavlink_send_ivory(n_var1, n_var2, 67U, n_ref1, 4U, 21U);
    return;
}