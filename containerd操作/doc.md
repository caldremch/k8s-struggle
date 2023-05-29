工具: nerdctl


```shell
nerdctl tag caldremch/android-sdk:0.0.1 192.168.20.150:30014/app/android-sdk:0.0.1
docker tag caldremch/android-sdk:0.0.1 192.168.20.150:30014/app/android-sdk:0.0.1
nerdctl login --username admin --password Harbor12345 192.168.20.150:30014
nerdctl push 192.168.20.150:30014/app/android-sdk:0.0.1
```


报错: 
```text
root@node1:~# nerdctl push 192.168.20.150:30014/app/android-sdk:0.0.1
INFO[0000] pushing as a reduced-platform image (application/vnd.docker.distribution.manifest.v2+json, sha256:a324c7b9141cc93f48c915eb9cc28d7e5e8f14458f653f9369dfc580a74d6b73) 
WARN[0000] skipping verifying HTTPS certs for "192.168.20.150:30014" 
manifest-sha256:a324c7b9141cc93f48c915eb9cc28d7e5e8f14458f653f9369dfc580a74d6b73: waiting        |--------------------------------------| 
config-sha256:c9e4e32fefc6cead6701e1fa76a956538c59491e50d2edf3be7b06a6bd66370c:   waiting        |--------------------------------------| 
elapsed: 0.1 s                                                                    total:   0.0 B (0.0 B/s)                                         
WARN[0000] server "192.168.20.150:30014" does not seem to support HTTPS, falling back to plain HTTP  error="failed to do request: Head \"https://192.168.20.150:30014/v2/app/android-sdk/blobs/sha256:ed895a290e72e8cd4b67ae1e23d453dd51eb7dcefb748da9dc0016814b8ad552\": http: server gave HTTP response to HTTPS client"
manifest-sha256:a324c7b9141cc93f48c915eb9cc28d7e5e8f14458f653f9369dfc580a74d6b73: waiting        |--------------------------------------| 
config-sha256:c9e4e32fefc6cead6701e1fa76a956538c59491e50d2edf3be7b06a6bd66370c:   waiting        |--------------------------------------| 
elapsed: 9.1 s                                                                    total:   0.0 B (0.0 B/s)                                         
FATA[0009] failed to copy: unexpected status from PUT request to http://192.168.20.150:30014/v2/app/android-sdk/blobs/uploads/96c23d5a-391e-403d-bd73-19608a71221c?_state=oY-6el5lt0xB-5pXfo8dptopHsKwwkjHvFOmlgBFWOF7Ik5hbWUiOiJhcHAvYW5kcm9pZC1zZGsiLCJVVUlEIjoiOTZjMjNkNWEtMzkxZS00MDNkLWJkNzMtMTk2MDhhNzEyMjFjIiwiT2Zmc2V0IjowLCJTdGFydGVkQXQiOiIyMDIzLTA0LTI5VDEzOjA5OjU3LjgxNTQ1NzM1WiJ9&digest=sha256%3A0b2cf5639b01ff1552775a5a61ac2f02ce71cf6acf46cb810c139bea318a039b: 500 Internal Server Error 
```

# solve 
```shell
vim /etc/nerdctl/nerdctl.toml
```

add 
```text
insecure_registry = "192.168.20.150:30014"
```

结论, 没有用, 未解决