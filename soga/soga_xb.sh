#!/bin/bash



# Step 2: Install soga
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/soga/master/install.sh)
if [ $? -eq 0 ]; then
    echo "soga安装成功"
else
    echo "安装出错"
    exit 1
fi

# Step 3: Update soga.conf
cat << EOF > /etc/soga/soga.conf
# 日志配置
log_level=info
log_file=

# 基础配置
type=xboard
server_type=ss

#对接配置
api=webapi
node_id=363
webapi_url=https://cloud.sxxxx.top
webapi_key=m2D0NcGX9mIFhde4uwy4Do
soga_key=

#redis_db=1
#conn_limit_expiry=60
#user_conn_limit=5
#redis_enable=true
#redis_addr=103.117.103.130:6888
#redis_password=2HkRyCDatEBCRssostK1

# DNS配置
dns_strategy=ipv4_first
default_dns=1.1.1.1,8.8.8.8

# 中转相关配置
proxy_protocol=true
udp_proxy_protocol=true
# 禁止BT
forbidden_bit_torrent=ture

EOF

# Step 4: Record node_id
read -p "请输入node_id: " node_id
sed -i "s/node_id=363/node_id=$node_id/" /etc/soga/soga.conf

# Step 5: Start soga
soga config node_id=$node_id
soga restart
