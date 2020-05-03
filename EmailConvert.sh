#!/bin/bash

function Conv {
        for i in $(echo "${W}" |sed 's/./& /g')
        do
                P=$(echo ${A} |grep -aob "${i,,}")
                if [[ ${P%:*} -le ${S} ]]
                then
                        G=$((${#A}-${P%:*}))
                else
                        G=$((${P%:*}-${S}))
                fi
                [[ ${i/${i^^}/} ]] && echo ${A} |cut -c ${G}
                [[ ${i/${i,,}/} ]] && echo ${A^^} |cut -c ${G}
        done
}

function Staps {
        for I in ${1/=/ }
        do
                echo ${A} |grep -aob "${I,,}"
        done
}

S=${1:? use ${0} \"x=y\" \"foo bar\"}
K=${2:? use ${0} \"x=y\" \"foo bar\"}
A=$(echo -E {a..z})
N=($(Staps ${S}))
S=$(echo ${N[0]%:*}-${N[1]%:*}-1 |bc -l)

for W in ${K} 
do
        B=$(Conv)
        echo -n ${B} |tr -d '\ '
        echo -n ' '

done
