/* This file has been autogenerated by Ivory
 * Compiler version  5326f414a5a63af59269d31f823a2e142af0b2c9
 */
#include <out.h>
#include <smavlink/pack.h>
#include "smavlink_message_servo_output_raw.h"
void smavlink_send_servo_output_raw(struct servo_output_raw_msg* n_var0,
                                    struct smavlink_out_channel* n_var1,
                                    struct smavlink_system* n_var2)
{
    uint8_t n_local0[21U] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                             0, 0, 0, 0};
    uint8_t(* n_ref1)[21U] = &n_local0;
    uint32_t n_deref2 = *&n_var0->time_boot_ms;
    
    smavlink_pack_uint32_t(n_ref1, 0U, n_deref2);
    
    uint16_t n_deref3 = *&n_var0->servo1_raw;
    
    smavlink_pack_uint16_t(n_ref1, 4U, n_deref3);
    
    uint16_t n_deref4 = *&n_var0->servo2_raw;
    
    smavlink_pack_uint16_t(n_ref1, 6U, n_deref4);
    
    uint16_t n_deref5 = *&n_var0->servo3_raw;
    
    smavlink_pack_uint16_t(n_ref1, 8U, n_deref5);
    
    uint16_t n_deref6 = *&n_var0->servo4_raw;
    
    smavlink_pack_uint16_t(n_ref1, 10U, n_deref6);
    
    uint16_t n_deref7 = *&n_var0->servo5_raw;
    
    smavlink_pack_uint16_t(n_ref1, 12U, n_deref7);
    
    uint16_t n_deref8 = *&n_var0->servo6_raw;
    
    smavlink_pack_uint16_t(n_ref1, 14U, n_deref8);
    
    uint16_t n_deref9 = *&n_var0->servo7_raw;
    
    smavlink_pack_uint16_t(n_ref1, 16U, n_deref9);
    
    uint16_t n_deref10 = *&n_var0->servo8_raw;
    
    smavlink_pack_uint16_t(n_ref1, 18U, n_deref10);
    
    uint8_t n_deref11 = *&n_var0->port;
    
    smavlink_pack_uint8_t(n_ref1, 20U, n_deref11);
    smavlink_send_ivory(n_var1, n_var2, 36U, n_ref1, 21U, 242U);
    return;
}