#!/usr/bin/expect
set password "123456"
set env(HOME) $env(HOME)
spawn scp root@192.168.80.225:/root/.ssh/work1 $env(HOME)/.ssh #（本地目录）
expect  "*assword*"

send "$password\n"

interact