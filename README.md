# chained_copy

A simple bash script that uses the commonly used commands "tar" and "nc" to copy files to many servers.

Usage: 

1. Create the chain of servers. For example: server1 -> server2 -> server3

On the last server(server3): 

```
./chained_copy.sh up
```

On server2:

```
./chained_copy.sh up server3
```

On server1: 

```
./chained_copy.sh up server2
```

2. Send files to the first server(server1).
```
tar cf - * | nc server1 11208
```
---

一个简单的bash脚本，使用常用命令“ tar”和“ nc”将文件复制到许多服务器。

用法: 

1. 创建服务器链. 例如: server1 -> server2 -> server3

在最后一个服务器上(server3): 

```
./chained_copy.sh up
```

在server2上:

```
./chained_copy.sh up server3
```

在server1上: 

```
./chained_copy.sh up server2
```

2. 发送文件到第一个服务器(server1).
```
tar cf - * | nc server1 11208
```
