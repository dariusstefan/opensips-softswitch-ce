#!/bin/bash

echo "Configuring OpenSIPS CP User Management Tool ..."

# Password Mode
mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -D ${MYSQL_DATABASE} -e \
	"INSERT INTO ocp_tools_config (module, param, value)
	 SELECT 'user_management', 'passwd_mode', '1'
		 WHERE NOT EXISTS (
		 SELECT 1 FROM ocp_tools_config WHERE module = 'user_management' AND param = 'passwd_mode');"

# ACLs
cp -u /docker-entrypoint.d/user_management/acls.inc.php /var/www/html/opensips-cp/config/tools/users/user_management/
cp -u /docker-entrypoint.d/user_management/user_management_acls.php /var/www/html/opensips-cp/web/tools/users/user_management/

add_column() {
    table_name=$1
    column_name=$2
    column_options=$3

    COLUMN_EXISTS=$(mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -D ${MYSQL_DATABASE} -e \
        "SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '${table_name}' AND COLUMN_NAME = '${column_name}';")

    [ -z "$COLUMN_EXISTS" ] && mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -D ${MYSQL_DATABASE} -e \
        "ALTER TABLE ${table_name} ADD COLUMN ${column_name} ${column_options};"
}

add_column subscriber acls 'VARCHAR(64) DEFAULT "" NOT NULL'

mysql -h ${MYSQL_IP} -u ${MYSQL_USER} -p"${MYSQL_PASSWORD}" -D ${MYSQL_DATABASE} -e \
	"INSERT INTO ocp_tools_config (module, param, value)
	 SELECT 'user_management', 'subs_extra_actions', UNHEX('7B2261636C73223A7B22686561646572223A2241434C73222C2269636F6E223A222E2E5C2F2E2E5C2F2E2E5C2F696D616765735C2F73686172655C2F6163636573732E706E67222C22616374696F6E223A225365742041434C73222C22616374696F6E5F66696C65223A22757365725F6D616E6167656D656E745F61636C732E706870222C22616374696F6E5F66756E63223A2266756E6374696F6E202824726573756C7429207B2072657475726E205C226A6176617363726970743A3B5C5C5C22206F6E636C69636B3D5C5C5C2272756E5F696E5F77696E646F772827757365725F6D616E6167656D656E745F61636C732E7068703F7569643D5C222E24726573756C745B276964275D2E5C2227295C223B7D227D7D')
		 WHERE NOT EXISTS (
		 SELECT 1 FROM ocp_tools_config WHERE module = 'user_management' AND param = 'subs_extra_actions');"
