#! /bin/bash
# by:chenran (apiziliao@gmail.com) 生成 ngrok 
# www.apizl.com
echo "create ngrok to window linux mac"
echo "快速生成ngrok可执行文件！"
echo "1.生成windows"
echo "2.生成linux"
echo "3.生成Mac"
read createType
echo "平台架构32、64、arm:(默认64回车键即可)"
read amdType
echo "生成的域名:(为空使用上次证书)"   
read domain   
echo "loading..."
x=`rpm -qa | grep golang`
if [ `rpm -qa | grep golang |wc -l` -eq 0 ];then
	yum install go #检测下载go
fi
x=`rpm -qa | grep git`
if [ `rpm -qa | grep git |wc -l` -eq 0 ];then
	yum install git #检测下载git
fi
git clone https://github.com/inconshreveable/ngrok.git
cd ngrok/ 
if [ -n "$domain" ];then
	openssl genrsa -out base.key 2048 &&
	openssl req -new -x509 -nodes -key base.key -days 10000 -subj "/CN=$domain" -out base.pem &&
	openssl genrsa -out server.key 2048 &&
	openssl req -new -key server.key -subj "/CN=$domain" -out server.csr &&
	openssl x509 -req -in server.csr -CA base.pem -CAkey base.key -CAcreateserial -days 10000 -out server.crt && echo "crt ok"	
	echo y | cp base.pem assets/client/tls/ngrokroot.crt
	echo y | cp server.crt assets/server/tls/snakeoil.crt
	echo y | cp server.key assets/server/tls/snakeoil.key
fi
amd="amd64"
if [ $amdType = "32" ];then
	amd="386"
elif [ $amdType = "arm" ];then
	amd="arm"
fi
if [ $createType = "1" ];then
    GOOS=windows GOARCH=$amd make release-server release-client
	echo "window生成成功 查看/bin/windows_$amd"
fi
if [ $createType = "2" ];then
    make release-server release-client
	echo "linux生成成功 查看/bin/"
fi
if [ $createType = "3" ];then
    GOOS=darwin  GOARCH=$amd make release-server release-client
	echo "indow生成成功 查看/bin/darwin_$amd"
fi
printf  "\e[34m 生成完成结束\n"
echo -e "\033[0m"