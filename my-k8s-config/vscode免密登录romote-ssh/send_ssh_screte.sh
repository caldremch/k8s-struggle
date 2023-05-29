#!/usr/bin/expect
set password "123456"
set env(HOME) $env(HOME)
spawn scp $env(HOME)/.ssh/leon.pub root@192.168.80.245:/root/.ssh

expect  "*assword*"
send "$password\n"

interact