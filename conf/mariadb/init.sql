UPDATE mysql.user SET host = '172.28.%.%' WHERE host NOT LIKE '172.28.%.%' AND user != 'root';
UPDATE mysql.db SET host = '172.28.%.%' WHERE host NOT LIKE '172.28.%.%' AND user != 'root';
FLUSH PRIVILEGES;
