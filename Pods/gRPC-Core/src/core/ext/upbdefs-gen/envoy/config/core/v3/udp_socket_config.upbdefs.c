/* This file was generated by upb_generator from the input file:
 *
 *     envoy/config/core/v3/udp_socket_config.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include "upb/reflection/def.h"
#include "envoy/config/core/v3/udp_socket_config.upbdefs.h"
#include "envoy/config/core/v3/udp_socket_config.upb_minitable.h"

extern _upb_DefPool_Init google_protobuf_wrappers_proto_upbdefinit;
extern _upb_DefPool_Init udpa_annotations_status_proto_upbdefinit;
extern _upb_DefPool_Init validate_validate_proto_upbdefinit;
static const char descriptor[474] = {'\n', ',', 'e', 'n', 'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 'i', 'g', '/', 'c', 'o', 'r', 'e', '/', 'v', '3', '/', 'u', 'd', 
'p', '_', 's', 'o', 'c', 'k', 'e', 't', '_', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'p', 'r', 'o', 't', 'o', '\022', '\024', 'e', 'n', 
'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '\032', '\036', 'g', 'o', 'o', 'g', 'l', 
'e', '/', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '/', 'w', 'r', 'a', 'p', 'p', 'e', 'r', 's', '.', 'p', 'r', 'o', 't', 'o', 
'\032', '\035', 'u', 'd', 'p', 'a', '/', 'a', 'n', 'n', 'o', 't', 'a', 't', 'i', 'o', 'n', 's', '/', 's', 't', 'a', 't', 'u', 's', 
'.', 'p', 'r', 'o', 't', 'o', '\032', '\027', 'v', 'a', 'l', 'i', 'd', 'a', 't', 'e', '/', 'v', 'a', 'l', 'i', 'd', 'a', 't', 'e', 
'.', 'p', 'r', 'o', 't', 'o', '\"', '\250', '\001', '\n', '\017', 'U', 'd', 'p', 'S', 'o', 'c', 'k', 'e', 't', 'C', 'o', 'n', 'f', 'i', 
'g', '\022', 'Z', '\n', '\024', 'm', 'a', 'x', '_', 'r', 'x', '_', 'd', 'a', 't', 'a', 'g', 'r', 'a', 'm', '_', 's', 'i', 'z', 'e', 
'\030', '\001', ' ', '\001', '(', '\013', '2', '\034', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 'o', 't', 'o', 'b', 'u', 'f', '.', 
'U', 'I', 'n', 't', '6', '4', 'V', 'a', 'l', 'u', 'e', 'B', '\013', '\372', 'B', '\010', '2', '\006', '\020', '\200', '\200', '\004', ' ', '\000', 'R', 
'\021', 'm', 'a', 'x', 'R', 'x', 'D', 'a', 't', 'a', 'g', 'r', 'a', 'm', 'S', 'i', 'z', 'e', '\022', '9', '\n', '\n', 'p', 'r', 'e', 
'f', 'e', 'r', '_', 'g', 'r', 'o', '\030', '\002', ' ', '\001', '(', '\013', '2', '\032', '.', 'g', 'o', 'o', 'g', 'l', 'e', '.', 'p', 'r', 
'o', 't', 'o', 'b', 'u', 'f', '.', 'B', 'o', 'o', 'l', 'V', 'a', 'l', 'u', 'e', 'R', '\t', 'p', 'r', 'e', 'f', 'e', 'r', 'G', 
'r', 'o', 'B', '\210', '\001', '\n', '\"', 'i', 'o', '.', 'e', 'n', 'v', 'o', 'y', 'p', 'r', 'o', 'x', 'y', '.', 'e', 'n', 'v', 'o', 
'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', 'B', '\024', 'U', 'd', 'p', 'S', 'o', 'c', 'k', 
'e', 't', 'C', 'o', 'n', 'f', 'i', 'g', 'P', 'r', 'o', 't', 'o', 'P', '\001', 'Z', 'B', 'g', 'i', 't', 'h', 'u', 'b', '.', 'c', 
'o', 'm', '/', 'e', 'n', 'v', 'o', 'y', 'p', 'r', 'o', 'x', 'y', '/', 'g', 'o', '-', 'c', 'o', 'n', 't', 'r', 'o', 'l', '-', 
'p', 'l', 'a', 'n', 'e', '/', 'e', 'n', 'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 'i', 'g', '/', 'c', 'o', 'r', 'e', '/', 'v', 
'3', ';', 'c', 'o', 'r', 'e', 'v', '3', '\272', '\200', '\310', '\321', '\006', '\002', '\020', '\002', 'b', '\006', 'p', 'r', 'o', 't', 'o', '3', 
};

static _upb_DefPool_Init *deps[4] = {
  &google_protobuf_wrappers_proto_upbdefinit,
  &udpa_annotations_status_proto_upbdefinit,
  &validate_validate_proto_upbdefinit,
  NULL
};

_upb_DefPool_Init envoy_config_core_v3_udp_socket_config_proto_upbdefinit = {
  deps,
  &envoy_config_core_v3_udp_socket_config_proto_upb_file_layout,
  "envoy/config/core/v3/udp_socket_config.proto",
  UPB_STRINGVIEW_INIT(descriptor, 474)
};
