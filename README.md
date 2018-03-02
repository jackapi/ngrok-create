## Ngrok-Create 快速创建ngrok

- 为了方便生成ngrok可执行文件架设ngrok服务。

```shell
下载sh
sh ./ngrok-create.sh 
或
 wget https://raw.githubusercontent.com/jackapi/ngrok-create/master/ngrok-create.sh
 sh ./ngrok-create.sh 
```
>1.windows 2.linux 3.mac 生成对应不同可执行文件

>生成可执行文件构架32/64/arm

### 启动或使用
```shell
启动服务：ngrokd -tlsKey=server.key -tlsCrt=server.crt -domain="ngrok.xxxx.com" -httpAddr=":8081" -httpsAddr=":8082"

创建配置文件：
ngrok.cfg
    server_addr: ngork.xxx.com:4443
    trust_host_root_certs: false

启动客户端映射内网：
ngrok -subdomain test -proto=http -config=ngrok.cfg 80

```

#### 截图

[![](https://raw.githubusercontent.com/jackapi/ngrok-create/master/main.png)](https://raw.githubusercontent.com/jackapi/ngrok-create/master/main.png)
