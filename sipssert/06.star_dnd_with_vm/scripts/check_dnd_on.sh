mysql opensips -e "SELECT username FROM subscriber WHERE username = '$1' AND domain = '$2' AND acls LIKE '%D%';" | grep "$1"