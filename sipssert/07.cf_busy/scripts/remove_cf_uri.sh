mysql opensips -e "UPDATE subscriber SET cfbs_uri=NULL WHERE username='$1' AND domain='$2';"