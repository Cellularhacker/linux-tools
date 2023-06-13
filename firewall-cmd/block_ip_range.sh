#!/bin/bash

######
#
# Created at 2023-06-13 13:00:00 KST ~ 2023-06-13 14:50:00 KST
# by Cellularhacker (wva3cdae@gmail.com)
# Github @Cellularhacker
#
# Check Updates at : https://github.com/Cellularhacker/linux-tools/blob/main/firewall-cmd/block_ip_range.sh
#
#####

##########
# ※ 주의사항 : 절대로 reject를 쓰시면 안됩니다. reject는 CPU연산을 시간을 사용하기 때문에, 트래픽이 대량으로 들어오게 되면 System이 부하가 걸려서 서버가 뻗습니다. 반드시 차단할 IP혹은 IP 범위는 drop으로 하셔야 합니다.
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

IP_RANGE_IN_CIDRS=("182.112.0.0/12" "220.174.0.0/16" "220.178.0.0/15" "209.141.32.0/19" "152.89.196.0/24" "62.233.50.0/24" "31.41.244.0/24" "143.42.16.0/20" "143.42.16.0/20" "45.79.16.0/20" "113.188.208.0/20")

for value in "${IP_RANGE_IN_CIDRS[@]}";do
	echo "Adding blocking '${value} ...'"
	firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${value}' drop"
done
	echo "Refreshing Firewall ..."
firewall-cmd --reload
exit;



#####
#
# 한개만 할 때
#
#####

IP_RANGE_IN_CIDR='183.221.160.0/20'

echo "Adding blocking '${IP_RANGE_IN_CIDR} ...'"
firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${IP_RANGE_IN_CIDR}' drop"
echo "Refreshing Firewall ..."
firewall-cmd --reload
exit;
