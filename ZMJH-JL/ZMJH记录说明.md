## 一、使用方法
### （一）路由器端
#### 1.将ZHJH文件夹下所有文件拷入lede的/root/目录。
#### 2.安装pppoe服务端
安装自己路由器对应版本的ipk(这里以我的路由器为例)。

方法一(路由器可以上网)：
```sh
opkg update
opkg install rp-pppoe-server
```

方法二(路由器无法上网，自行下载对应ipk，<或者用hfs上传> 这里以tengda-ac9为例)：
```sh
opkg install rp-pppoe-common_3.12-1_arm_cortex-a9.ipk
opkg install rp-pppoe-server_3.12-1_arm_cortex-a9.ipk
```
#### 3.运行ZMJHconf.sh。
```sh
sh ZMJHconf.sh
```
### （二）查看路由器的拨号账号密码

1.网线由主路由的WAN口，接刷机路由器LAN口

2.进入刷机路由器的内部设置界面。

3.这个时候路由器会截取真实账号和密码，并进行拨号。

## 二、个人测试环境：
路由器：

tenda-ac9 [lede17.01.0](https://downloads.lede-project.org/releases/17.01.0/targets/bcm53xx/generic)固件

newifi mini [PandoraBox 17.01](http://downloads.pandorabox.com.cn/pandorabox-16-10-stable/targets/ralink/mt7620/)固件

hg255d/hc5661a PandoraBox固件 {Base on OpenWrt BARRIER BREAKER (14.09, r865)}

地点：CQUPT

## 三、ipk下载
可以在路由器里运行
```
opkg update
```
一般会返回类似网址，去网址里找包
```
Downloading http://downloads.openwrt.org.cn/PandoraBox/ralink/packages/routing/Packages.gz.
`
*** *** ***
( ZMJH-JL )这个文件夹里面的脚本是可以无时间间隔（1s）进行记录已经获取的 账号密码 方便查阅。
