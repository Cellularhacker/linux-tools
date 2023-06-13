#!/bin/bash

######
#
# Created at 2023-06-13 13:00:00 KST ~ 2023-06-13 14:50:00 KST
# by Cellularhacker (wva3cdae@gmail.com)
# Github @Cellularhacker
#
# Check Updates at : https://github.com/Cellularhacker/linux-tools/blob/main/firewall-cmd/whitelist_ssh.sh
#
#####

##########
# - 허용할 IP는 drop 대신에 allow 를 사용 합니다.
# - CIDIR(192.168.10.0/24 에서 /24 를 포함하여 확인하는 방법)
#     i) https://bgp.tools 에 접속하여 웹페이지내 "Start here..." 라고 적힌 Text box내에 IP주소를 입력한다.
#    ii) 잠시후 웹 페이지에 크게 나오는 x.x.x.x/n 형태의 주소를 복사한다.
#   iii) 아래의 배열에 ""로 감싸서 붙여넣기 한 후, 저장하고 나가서 실행한다.
##########

#####
#
# 여러개를 동시에 할 때
#
#####

ALLOW_PORT_PROTOCOL='tcp' # SSH는 OSI 7 Layer 중 4 계층인 Transport 레이어의 두 개인 tcp와 udp 중 'tcp'를 기반으로 세션을 맺고 데이터를 중간중간에 상호 검증을 하는 과정이 포함되어 있습니다.
ALLOW_PORT_NUM=7722

IP_RANGE_IN_CIDRS=("127.0.0.1/32" "127.0.0.2/32")

for value in "${IP_RANGE_IN_CIDRS[@]}";do
	echo "Adding allow '${ALLOW_PORT_PROTOCOL}/${ALLOW_PORT_NUM}' to '${IP_RANGE_IN_CIDR} ...'"
	firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${value}' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' accept"
done

# MARK: Default rules
# Rule-Priority 32764(== -4) : (Allow)Chung-Ang University Public IP Range
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' priority='32764' source address='165.194.0.0/16' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' accept"
# Rule-Priority 32765(== -3) : (Allow)OpenPBS Cluster Internal Private IP Range
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' priority='32765' source address='10.0.0.0/24' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' accept"
# Rule-Priority 32766(== -2) : (Allow)Localhost Loopback IP Range
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' priority='32766' source address='127.0.0.0/8' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' accept"
# Rule-Priority 32767(== -1) : (Drop)Rest of the IP Range ※ MUST BE ALWAYS LOCATED ON THE BOTTOM !!!
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' priority='32767' source address='0.0.0.0/0' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' drop"

echo "Refreshing Firewall ..."
firewall-cmd --reload
exit;



#####
#
# 한개만 할 때
#
#####

IP_RANGE_IN_CIDR='127.0.0.1/32'

echo "Adding allow '${ALLOW_PORT_PROTOCOL}/${ALLOW_PORT_NUM}' to '${IP_RANGE_IN_CIDR} ...'"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${IP_RANGE_IN_CIDR}' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' accept"

# MARK: Default rules
# Rule-Priority 32764(== -4) : (Allow)Chung-Ang University Public IP Range
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' priority='32764' source address='165.194.0.0/16' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' accept"
# Rule-Priority 32765(== -3) : (Allow)OpenPBS Cluster Internal Private IP Range
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' priority='32765' source address='10.0.0.0/24' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' accept"
# Rule-Priority 32766(== -2) : (Allow)Localhost Loopback IP Range
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' priority='32766' source address='127.0.0.0/8' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' accept"
# Rule-Priority 32767(== -1) : (Drop)Rest of the IP Range ※ MUST BE ALWAYS LOCATED ON THE BOTTOM !!!
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' priority='32767' source address='0.0.0.0/0' port protocol='${ALLOW_PORT_PROTOCOL}' port='${ALLOW_PORT_NUM}' drop"

echo "Refreshing Firewall ..."
firewall-cmd --reload
exit;
