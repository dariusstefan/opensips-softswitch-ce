mysql opensips -e "REPLACE INTO dr_gateways (gwid, type, address, strip, pri_prefix, attrs, probe_mode, state, socket, description) VALUES ('$1', 1, '$2', 0, '', '', 0, 0, '', '$3');"
