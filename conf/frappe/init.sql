UPDATE mysql.user SET host = '172.28.%.%' WHERE host != '172.28.%.%' AND user != 'root';
UPDATE mysql.db SET host = '172.28.%.%' WHERE host != '172.28.%.%' AND user != 'root' AND user = db AND db NOT LIKE 'temp%';
FLUSH PRIVILEGES;
