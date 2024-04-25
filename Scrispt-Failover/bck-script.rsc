# apr/25/2024 12:44:12 by RouterOS 6.46.8
# software id = NVA5-V2W4
#
# model = RouterBOARD 750 r2
# serial number = 67D2076C7FFC
/system script
add dont-require-permissions=yes name=02-Latencia owner=mrh policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    ########## Altere conforme sua necessidade ################\r\
    \n:global HELipteste 8.8.4.4\r\
    \n:global HELlatenciAceitavel 40\r\
    \n:global HELtempoEntrePings 2\r\
    \n:global HELNumPings 4\r\
    \n\r\
    \n##################################################\r\
    \n\r\
    \n:global HELmsg\r\
    \n:global HELstatus\r\
    \n:global HELoldstatus \$HELstatus\r\
    \n:global HELsomaLatencia 0\r\
    \n:global HELsomaRecebidos 0 \r\
    \n##################################################\r\
    \n\r\
    \n\r\
    \n\r\
    \nfor i from=1 to=\$HELNumPings do={\r\
    \n/tool flood-ping \$HELipteste size=100 count=1 do={\r\
    \n:if (\$received = 1) do={\r\
    \n:set HELsomaLatencia (\$HELsomaLatencia + \$\"avg-rtt\")\r\
    \n}\r\
    \n:set HELsomaRecebidos (\$HELsomaRecebidos + \$received)\r\
    \n}\r\
    \ndelay \$HELtempoEntrePings\r\
    \n}\r\
    \n\r\
    \n#################################### A\C7OES TOMADA SE HOST ESTIVER FORA\
    \_DE ALCANCE #############################\r\
    \n:if (\$HELsomaRecebidos = 0 ) do={\r\
    \n:global HELstatus \"HOST \$HELipteste HEL FORA DE ALCANCE\"\r\
    \n:if (\$HELoldstatus = \$LHELstatus) do={quit} else={\r\
    \n/ip route set distance=28 numbers=[find where comment=\"link02-vivo\"]\r\
    \n:log warning \$HELstatus\r\
    \n:global HELmsg \r\
    \nquit\r\
    \n}\r\
    \n}\r\
    \n\r\
    \n#################################### CALCULA LATENCIA E PERDA DE PACOTES\
    \_#############################\r\
    \n\r\
    \n:global HELmedia (\$HELsomaLatencia/\$HELsomaRecebidos)\r\
    \n:global HELpercaPacotes (100 - ((\$HELsomaRecebidos * 100) / \$HELNumPin\
    gs))\r\
    \n\r\
    \n:global HELmsg (\"M\E9dia de PING para o IP \$HELipteste foi de \".[:tos\
    tr \$HELmedia].\"ms e PERDA DE PACOTES foi de \". [:tostr \$HELpercaPacote\
    s].\"%. Foram \".\$HELNumPings.\" PINGs enviados e \".\$HELsomaRecebidos.\
    \" recebidos.\")\r\
    \n\r\
    \n\r\
    \n\r\
    \n#################################### A\C7OES TOMADA SE A LATENCIA ESTIVE\
    R ABAIXO OU ACIMA DO ESPECIFICADO #############################\r\
    \n:if (\$HELmedia < \$HELlatenciAceitavel ) do={\r\
    \n:global HELstatus \"LATENCIA link02-vivo BOA\"\r\
    \n:if (\$HELoldstatus = \$HELstatus) do={quit} else={\r\
    \n\r\
    \n/ip route set distance=1 numbers=[find where comment=\"link02-vivo\"]\r\
    \n:log warning \$HELmsg\r\
    \n:log warning \$HELstatus\r\
    \n\r\
    \n}\r\
    \n} else={\r\
    \n:global HELstatus \"LATENCIA link02-vivo RUIM\"\r\
    \n:if (\$HELoldstatus = \$HELstatus) do={quit} else={\r\
    \n\r\
    \n/tool fetch url=\"https://api.telegram.org/bot480877836:AAFaxotPTz1vG0el\
    NIpAWJl0f5JsFUV14ls/sendMessage\?chat_id=-1001355184711&text=Help Latencia\
    \_Ruim\" keep-result=no\r\
    \n/ip route set distance=2 numbers=[find where comment=\"link02-vivo\"]\r\
    \n:log error \$HELmsg\r\
    \n:log error \$HELstatus\r\
    \n}\r\
    \n\r\
    \n}\r\
    \n\r\
    \n"
add dont-require-permissions=yes name=01-Latencia owner=mrh policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    ########## Altere conforme sua necessidade ################\r\
    \n:global HELipteste 8.8.8.8\r\
    \n:global HELlatenciAceitavel 40\r\
    \n:global HELtempoEntrePings 2\r\
    \n:global HELNumPings 4\r\
    \n\r\
    \n##################################################\r\
    \n\r\
    \n:global HELmsg\r\
    \n:global HELstatus\r\
    \n:global HELoldstatus \$HELstatus\r\
    \n:global HELsomaLatencia 0\r\
    \n:global HELsomaRecebidos 0 \r\
    \n##################################################\r\
    \n\r\
    \n\r\
    \n\r\
    \nfor i from=1 to=\$HELNumPings do={\r\
    \n/tool flood-ping \$HELipteste size=100 count=1 do={\r\
    \n:if (\$received = 1) do={\r\
    \n:set HELsomaLatencia (\$HELsomaLatencia + \$\"avg-rtt\")\r\
    \n}\r\
    \n:set HELsomaRecebidos (\$HELsomaRecebidos + \$received)\r\
    \n}\r\
    \ndelay \$HELtempoEntrePings\r\
    \n}\r\
    \n\r\
    \n#################################### A\C7OES TOMADA SE HOST ESTIVER FORA\
    \_DE ALCANCE #############################\r\
    \n:if (\$HELsomaRecebidos = 0 ) do={\r\
    \n:global HELstatus \"HOST \$HELipteste HEL FORA DE ALCANCE\"\r\
    \n:if (\$HELoldstatus = \$LHELstatus) do={quit} else={\r\
    \n/ip route set distance=28 numbers=[find where comment=\"link01-brt\"]\r\
    \n:log warning \$HELstatus\r\
    \n:global HELmsg \r\
    \nquit\r\
    \n}\r\
    \n}\r\
    \n\r\
    \n#################################### CALCULA LATENCIA E PERDA DE PACOTES\
    \_#############################\r\
    \n\r\
    \n:global HELmedia (\$HELsomaLatencia/\$HELsomaRecebidos)\r\
    \n:global HELpercaPacotes (100 - ((\$HELsomaRecebidos * 100) / \$HELNumPin\
    gs))\r\
    \n\r\
    \n:global HELmsg (\"M\E9dia de PING para o IP \$HELipteste foi de \".[:tos\
    tr \$HELmedia].\"ms e PERDA DE PACOTES foi de \". [:tostr \$HELpercaPacote\
    s].\"%. Foram \".\$HELNumPings.\" PINGs enviados e \".\$HELsomaRecebidos.\
    \" recebidos.\")\r\
    \n\r\
    \n\r\
    \n\r\
    \n#################################### A\C7OES TOMADA SE A LATENCIA ESTIVE\
    R ABAIXO OU ACIMA DO ESPECIFICADO #############################\r\
    \n:if (\$HELmedia < \$HELlatenciAceitavel ) do={\r\
    \n:global HELstatus \"LATENCIA link01-brt BOA\"\r\
    \n:if (\$HELoldstatus = \$HELstatus) do={quit} else={\r\
    \n\r\
    \n/ip route set distance=1 numbers=[find where comment=\"link01-brt\"]\r\
    \n:log warning \$HELmsg\r\
    \n:log warning \$HELstatus\r\
    \n\r\
    \n}\r\
    \n} else={\r\
    \n:global HELstatus \"LATENCIA link01-brt RUIM\"\r\
    \n:if (\$HELoldstatus = \$HELstatus) do={quit} else={\r\
    \n\r\
    \n/tool fetch url=\"https://api.telegram.org/bot480877836:AAFaxotPTz1vG0el\
    NIpAWJl0f5JsFUV14ls/sendMessage\?chat_id=-1001355184711&text=Help Latencia\
    \_Ruim\" keep-result=no\r\
    \n/ip route set distance=2 numbers=[find where comment=\"link01-brt\"]\r\
    \n:log error \$HELmsg\r\
    \n:log error \$HELstatus\r\
    \n}\r\
    \n\r\
    \n}\r\
    \n\r\
    \n"
