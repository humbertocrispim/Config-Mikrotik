# apr/25/2024 12:44:48 by RouterOS 6.46.8
# software id = NVA5-V2W4
#
# model = RouterBOARD 750 r2
# serial number = 67D2076C7FFC
/system scheduler
add comment="Check Link01" interval=51s name=01-Latencia on-event=01-Latencia \
    policy=ftp,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add comment="Check Link02" interval=3m12s name=02-Latencia on-event=\
    02-Latencia policy=\
    ftp,read,write,policy,test,password,sniff,sensitive,romon start-time=\
    startup
