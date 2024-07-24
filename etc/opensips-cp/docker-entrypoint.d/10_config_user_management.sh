#!/bin/bash

cd "$(dirname "$0")"
. functions

echo "Configuring OpenSIPS CP User Management Tool ..."

# Password Mode
add_parameter user_management passwd_mode '1'

# ACLs
cp -u user_management/acls.inc.php /var/www/html/opensips-cp/config/tools/users/user_management/
cp -u user_management/user_management_acls.php /var/www/html/opensips-cp/web/tools/users/user_management/

add_column subscriber acls 'varchar(32) DEFAULT "" NOT NULL'
add_column subscriber cfaw_uri
add_column subscriber cfbs_uri
add_column subscriber cfna_uri
add_column subscriber cfnf_uri

add_parameter user_management subs_extra_actions "UNHEX('7B2261636C73223A7B22686561646572223A2241434C73222C2269636F6E223A222E2E5C2F2E2E5C2F2E2E5C2F696D616765735C2F73686172655C2F6163636573732E706E67222C22616374696F6E223A225365742041434C73222C22616374696F6E5F66696C65223A22757365725F6D616E6167656D656E745F61636C732E706870222C22616374696F6E5F66756E63223A2266756E6374696F6E202824726573756C7429207B2072657475726E205C226A6176617363726970743A3B5C5C5C22206F6E636C69636B3D5C5C5C2272756E5F696E5F77696E646F772827757365725F6D616E6167656D656E745F61636C732E7068703F7569643D5C222E24726573756C745B276964275D2E5C2227295C223B7D227D7D')"

add_parameter user_management subs_extra "UNHEX('7B22636661775F757269223A7B22686561646572223A22416C7761797320466F7277617264222C22696E666F223A22416C7761797320666F72776172642063616C6C7320746F207468697320555249222C2273686F775F696E5F6D61696E5F666F726D223A747275652C2273686F775F696E5F6164645F666F726D223A747275652C2273686F775F696E5F656469745F666F726D223A747275652C2269735F6F7074696F6E616C223A2279222C2273656172636861626C65223A66616C73657D2C22636662735F757269223A7B22686561646572223A224275737920466F7277617264222C22696E666F223A225768656E20627573792C20666F7277617264207468652063616C6C20746F207468697320555249222C2273686F775F696E5F6D61696E5F666F726D223A747275652C2273686F775F696E5F6164645F666F726D223A747275652C2273686F775F696E5F656469745F666F726D223A747275652C2269735F6F7074696F6E616C223A2279222C2273656172636861626C65223A66616C73657D2C2263666E615F757269223A7B22686561646572223A224E6F20416E7377657220466F7277617264222C22696E666F223A225768656E207468657265206973206E6F20616E737765722C20666F7277617264207468652063616C6C20746F207468697320555249222C2273686F775F696E5F6D61696E5F666F726D223A747275652C2273686F775F696E5F6164645F666F726D223A747275652C2273686F775F696E5F656469745F666F726D223A747275652C2269735F6F7074696F6E616C223A2279222C2273656172636861626C65223A66616C73657D2C2263666E665F757269223A7B22686561646572223A224E6F7420466F756E6420466F7277617264222C22696E666F223A225768656E2063616C6C6565206973206E6F7420666F756E642C20666F7277617264207468652063616C6C20746F207468697320555249222C2273686F775F696E5F6D61696E5F666F726D223A747275652C2273686F775F696E5F6164645F666F726D223A747275652C2273686F775F696E5F656469745F666F726D223A747275652C2269735F6F7074696F6E616C223A2279222C2273656172636861626C65223A66616C73657D7D')"

add_parameter user_management user_format_func "UNHEX('66756E6374696F6E28247573657229207B0D0A202020207265717569726528226D695F636F6D6D2E70687022293B0D0A202020207265717569726528226366675F636F6D6D2E70687022293B0D0A0D0A20202020246D695F636F6E6E6563746F7273203D206765745F70726F7879735F62795F6173736F635F6964286765745F73657474696E67735F76616C7565282774616C6B5F746F5F746869735F6173736F635F69642729293B0D0A0D0A20202020246572726F7273203D205B5D3B0D0A0D0A2020202069662028656D70747928246D695F636F6E6E6563746F72732929207B0D0A202020202020202072657475726E2066616C73653B0D0A202020207D0D0A0D0A2020202024726573756C74203D206D695F636F6D6D616E64282264705F7472616E736C617465222C205B226470696422203D3E20312C2022696E70757422203D3E2024757365725D2C20246D695F636F6E6E6563746F72735B305D2C20246572726F7273293B0D0A0D0A202020206966202821656D70747928246572726F72732929207B0D0A202020202020202072657475726E2066616C73653B0D0A202020207D0D0A0D0A2020202072657475726E20747275653B0D0A7D')"
