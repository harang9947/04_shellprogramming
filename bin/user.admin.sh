#!/bin/bash

PASSWD=/etc/passwd

Menu(){
cat << EOF
(관리 목록)
---------------------------------
1) 사용자 추가
2) 사용자 확인
3) 사용자 삭제
4) 종료
---------------------------------

EOF
}

UserAdd(){
    echo
    echo "(사용자 추가)"
    echo -n "추가할 사용자 이름 : "
    read UNAME
    useradd $UNAME >/dev/nul 2>&1
    echo $UNAME | passwd --stdin $UNAME >/dev/null 2>&1
    [ $? -eq 0 ] && echo " [ OK ] 정상적으로 추가되었습니다. " \
                 || echo " [ FAIL ] 정상적으로 추가되지 않았습니다. "
    echo
}

UserVerify(){
cat << EOF
(사용자 확인)
---------------------------------
$(awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' $PASSWD | nl)
---------------------------------

EOF
}

UserDel(){
    echo
    echo "(사용자 삭제)"
    echo -n "삭제할 사용자 : "
    read UNAME

    userdel -r $UNAME >/dev/null 2>&1
    [ $? -eq 0 ] && echo "[ OK ] 정상적으로 삭제되었습니다." \
                 || echo "[ FAIL ] 정상적으로 삭제되지 않았습니다."
    echo
}

while true
do
    Menu
    echo -n "선택 번호? (1|2|3|4) : "
    read NUM

    case $NUM in
        1) UserAdd ;;
        2) UserVerify ;;
        3) UserDel ;;
        4) break ;;
        *) echo "[ WARN ] 잘못된 선택을 했습니다." 
    esac
done
