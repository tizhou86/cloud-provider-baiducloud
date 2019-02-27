#!/bin/bash

startTime=`date +%Y%m%d-%H:%M`
startTime_s=`date +%s`

for i in `seq 1 2`;
do
    kubectl create -f nginx.yaml
    status="Check: "
    while true
    do
        if [ `kubectl get service |grep "nginx-service"|grep -v "pending"|wc -l` -eq 5 ]; then
            break
        fi
        sleep 10
        status=$status"."
        echo $status
    done
    kubectl delete -f nginx.yaml
done

endTime=`date +%Y%m%d-%H:%M`
endTime_s=`date +%s`
sumTime=$[ $endTime_s - $startTime_s ]
echo "Test Finish: create-and-delete" "$startTime ---> $endTime" "Total: $sumTime s"