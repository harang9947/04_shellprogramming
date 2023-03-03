#!/bin/bash

# 1. PV
# 2. VG
# 3. LV
export TMP1=/tmp/tmp1
export TMP2=/tmp/tmp2
export TMP3=/tmp/tmp3
export TMP4=/tmp/tmp4

Start(){
    echo " 프로그램을 시작합니다."
}

echo "########################## PV 생성 ##########################"
###########################
# 1. PV
#   (1) View
fdisk -l | grep LVM | awk '{print$1}' > $TMP1
pvs | tail -n +2 | awk '{print$1}' > $TMP2

cat << EOF
############## PV VIEW ###############
$(cat $TMP1 $TMP2 | sort | uniq -u)
######################################

EOF
echo -n "PV를 생성하시겠습니까? (yes: 실행 , no: 종료, skip: 건너뛰기): "
read CHOICE
case $CHOICE in
    yes) MakePv ;;
    no) Start ;;
    skip) break ;;
    *) Start ;;
esac

MakePv(){
#   (2) Works
echo " => 위의 목록에서 PV로 생성하고 싶은 볼륨을 선택합니다. <="
echo -n "볼륨선택(ex : /dev/sdb1 /dev/sdc1 ...) : "
read VOLUME 

pvcreate $VOLUME >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Physical volume $VOLUME successfully created."
    pvs
else
    echo "[ FAIL ] Physical volume not created."
    exit 1
fi
}
echo "########################## VG 생성 ##########################"
###########################
# 2. VG
#   (1) View
vgs | tail -n +2 | awk '{print $1}' > $TMP3
pvs > $TMP4

for i in $(cat $TMP3)
do
    sed -i "/$i/d" $TMP4
done

cat << EOF
################### PV List ###################
$(cat $TMP4)
###############################################

EOF
#   (2) Works
# vgcreate vg1 /dev/sdb1 /dev/sdc1
echo -n "VG 이름 (ex: vg1) : "
read VGNAME

echo -n "선택가능한 PV 목록을 적어주세요(다중선택가능). (ex: /dev/sdb1  /dev/sdc1  ...)"
read PVLIST

vgcreate $VGNAME $PVLIST >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Volume group $VGNAME successfuly created"
    vgs
else
    echo "[ FAIL ] Vloume group not created."
    exit 2
fi

echo "########################## LV 생성 ##########################"
###########################
# 3. LV
#   (1) View
cat << EOF
################### VG List ###################
$(vgs | awk '$7 != '0' {print $0}')
###############################################

EOF
#   (2) Works
# lvcreate vg1 -n [v] -L 500M
###########################

echo -n "LV를 생성할 VG의 이름 (ex : vg1) : "
read VGLV

echo -n "생성할 LV 이름은? (ex : lv1) : "
read LVNAME

echo -n "LV의 용량 (ex : 500M) : "
read LVSIZE

lvcreate $VGLV -n $LVNAME -L $LVSIZE
if [ $? -eq 0 ] ; then
    echo "[ OK ] Logical Volume $LVNAME successfully created."
    lvs
else
    echo " [ FAIL ] Logical Volume not created. "
    exit 3
fi


