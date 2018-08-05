mysql -u root <<-EOF
  UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';
  DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
  DELETE FROM mysql.user WHERE User='';
  DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
  GRANT ALL PRIVILEGES ON *.* TO 'silverstripe' IDENTIFIED BY 'silverstripe' WITH GRANT OPTION;
  FLUSH PRIVILEGES;
  CREATE DATABASE IF NOT EXISTS test;
  CREATE DATABASE IF NOT EXISTS SS_mysite CHARACTER SET utf8;
EOF