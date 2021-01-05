# NodeMcu-IRIG
## 文件目录介绍
- bin: NodeMcu固件
- src: Lua代码
- software: 相关软件
## 基础环境部署
### Scoop
> scoop是windows上的软件管理工具,对于小白可以一键安装配置
#### 安装方法
打开powershell后输入以下命令:
```powershell
set-executionpolicy remotesigned -scope currentuser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```
安装完成输入`scoop help`测试
### Java安装
输入以下命令安装java7
```cmd
scoop install **git**
scoop bucket add java
scoop install openjdk7-unofficial
```
输入`java -version`测试
### CP210x驱动安装
运行驱动安装软件安装驱动
## 代码下载
- 初次下载在文件夹下打开cmd输入`git clone https://github.com/bishisimo/nodemcu-irig.git`下载nodemcu-irig文件夹
- 后续更新只需要在nodemcu-irig文件夹下使用cmd输入`git checkout .`(放弃所有修改),然后输入`git pull`(拉取远程仓库)
## 固件烧录
- 打开ESP8266Flasher
- 点击齿轮按钮找到要烧录固件,点击Flash按钮,若等待一会没有反应需按下nodemcu按钮.
## 代码写入
- 双击打开ESPlorer.bat(本质为java -jar "ESPlorer.jar"命令)
- 波特率为115200,打开对应端口
- 打开src里所有文件,对应文件点击左下角Save To ESP写入NodeMcu
- 重启NodeMcu
## 接线
- GPIO16为Tx端口,发送信息,Rx端口可不接(无法接受信息),Vcc对应电源,Gnd对应接地
## 附件
- IRIG协议原文:http://www.irigb.com/pdf/wp-irig-200-04.pdf