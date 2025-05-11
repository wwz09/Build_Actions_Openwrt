#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-par4.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改默认IP

sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate


##更改主机名
sed -i "s/hostname='.*'/hostname='CM520'/g" package/base-files/files/bin/config_generate


##删除lede部分包'
rm -rf ./feeds/extraipk/theme/luci-theme-argon-18.06
rm -rf ./feeds/extraipk/theme/luci-app-argon-config-18.06
rm -rf ./feeds/extraipk/theme/luci-theme-design
rm -rf ./feeds/extraipk/theme/luci-theme-edge
rm -rf ./feeds/extraipk/theme/luci-theme-ifit
rm -rf ./feeds/extraipk/theme/luci-theme-opentopd
rm -rf ./feeds/extraipk/theme/luci-theme-neobird
rm -rf ./feeds/luci/applications/luci-app-upnp
rm -rf ./feeds/luci/applications/luci-app-ddns
rm -rf ./feeds/luci/applications/luci-app-passwall
rm -rf ./feeds/luci/applications/luci-app-passwall2
rm -rf ./feeds/luci/applications/luci-app-shadowsocks-libev



rm -rf ./package/feeds/extraipk/luci-theme-argon-18.06
rm -rf ./package/feeds/extraipk/luci-app-argon-config-18.06
rm -rf ./package/feeds/extraipk/theme/luci-theme-design
rm -rf ./package/feeds/extraipk/theme/luci-theme-edge
rm -rf ./package/feeds/extraipk/theme/luci-theme-ifit
rm -rf ./package/feeds/extraipk/theme/luci-theme-opentopd
rm -rf ./package/feeds/extraipk/theme/luci-theme-neobird
rm -rf ./package/feeds/mzwrt_package/luci-app-shadowsocks


# '删除kenzok部分包'

rm -rf feeds/kenzok/luci-theme-atmaterial_new
rm -rf feeds/kenzok/luci-theme-opentopd
rm -rf feeds/kenzok/luci-theme-tomato
rm -rf feeds/mzwrt_packag/luci-app-ssr-plus
rm -rf feeds/mzwrt_packag/luci-app-passwall2
rm -rf feeds/mzwrt_packag/luci-app-passwall
rm -rf feeds/mzwrt_packag/luci-app-shadowsocks
rm -rf feeds/kenzok/luci-app-openclash
rm -rf feeds/kenzok/luci-theme-argon
rm -rf feeds/kenzok/luci-app-argon-config

# 修改 luci-theme-argon 为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile



# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

## 添加额外插件

git_sparse_clone main https://github.com/mzwrt/mzwrt_package_Lite  luci-app-ikoolproxy luci-app-store luci-app-quickstart luci-app-openclash luci-app-easymesh luci-app-ddnsto  luci-theme-argon luci-theme-design luci-app-design-config luci-app-argon-config luci-app-lucky luci-app-smartdns luci-lib-xterm luci-lib-taskd luci-lib-iform

git_sparse_clone main https://github.com/mzwrt/mzwrt_package_Lite  quickstart ucl upx taskd ddnsto filebrowser lua-maxminddb  smartdns upx-static docker lucky luci-app-homeproxy vlmcsd

git_sparse_clone LEDE https://github.com/wwz09/LEDE-IMM-package luci-app-control-timewol luci-app-control-webrestriction luci-app-control-weburl luci-app-timecontrol luci-app-parentcontrol relevance



# weburl 文件加执行权限
# chmod 7777 files/etc/init.d/weburl 



# 修改插件名字
sed -i 's/"挂载点"/"磁盘挂载"/g' `grep "挂载点" -rl ./`
sed -i 's/"Argonne 主题设置"/"主题设置"/g' `grep "Argonne 主题设置" -rl ./`
sed -i 's/"状态"/"系统状态"/g' `grep "状态" -rl ./`
sed -i 's/"系统"/"系统设置"/g' `grep "系统" -rl ./`
sed -i 's/"Hello World"/"世界你好"/g' `grep "Hello World" -rl ./`
sed -i 's/"iKoolProxy 滤广告"/"广告屏蔽"/g' `grep "iKoolProxy 滤广告" -rl ./`
sed -i 's/"DDNSTO 远程控制"/"远程控制"/g' `grep "DDNSTO 远程控制" -rl ./`
sed -i 's/"网络存储"/"存储设置"/g' `grep "网络存储" -rl ./`
sed -i 's/"重启"/"系统重启"/g' `grep "重启" -rl ./`
sed -i 's/"服务"/"应用服务"/g' `grep "服务" -rl ./`
sed -i 's/"CPU 性能优化调节"/"CPU 设置"/g' `grep "CPU 性能优化调节" -rl ./`
sed -i 's/"网络"/"网络设置"/g' `grep "网络" -rl ./`
sed -i 's/"接口"/"接口设置"/g' `grep "接口" -rl ./`
sed -i 's/"无线"/"无线设置"/g' `grep "无线" -rl ./`
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' `grep "Turbo ACC 网络加速" -rl ./`
sed -i 's/"实时流量监测"/"流量监测"/g' `grep "实时流量监测" -rl ./`
sed -i 's/"KMS 服务器"/"KMS激活"/g' `grep "KMS 服务器" -rl ./`
sed -i 's/"USB 打印服务器"/"打印服务"/g' `grep "USB 打印服务器" -rl ./`

# 设置ttyd免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

# 设置 root 密码

sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$KejhO3Om$wf8JAUSNHj0y2RiewTObe1:20185:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings


#'修改WIFI国家区域'
sed -i 's/US/CN/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改默认无线名称
sed -i 's/LEDE/CM520B-2.4G/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#开启MU-MIMO
sed -i 's/mu_beamformer=0/mu_beamformer=1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#修改无线加密及密码
sed -i 's/encryption=none/encryption=psk-mixed+ccmp\n            set wireless.default_radio${devidx}.key=abc5124937,\n/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改输出文件名
# sed -i 's/IMG_PREFIX:=$(VERSION_DIST_SANITIZED)/IMG_PREFIX:=KKT-$(shell date +%Y%m%d)-CM520/g' include/image.mk

# '修改连接数数'
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# '修改概览里时间显示为中文数字'
sed -i 's/os.date()/os.date("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/arm/index.htm



