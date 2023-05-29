1. 去github下载 https://github.com/Dreamacro/clash
2. 将解压出来的二进制文件重名为: clash, 放到一个地方(比如/usr/local/clash)
3. 创建 ~/.config/clash文件夹, 将[Country.mmdb](Country.mmdb)复制进去
4. 执行./clash命令, 就启动了, 然后关于设置开机启动, 网上有很多资料, 这里就不说了


# 如果想开启远程访问, ./clash执行后,  会在~/.config/clash目录下生成基本的配置文件cofig.yaml, 修改里面的external-container,  

127.0.0.1:9090 改为 0.0.0.0:9090

clash 是没有界面的, 所以需要安装

去 https://github.com/Dreamacro/clash-dashboard下载, 传到服务器上

需要安装node npm环境