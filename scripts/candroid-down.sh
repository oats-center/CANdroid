#!/system/bin/sh

down_can(){
	ip link set down can0
	ip link set down can1
}

kill_logger(){
	set `ps | grep can_log_raw`
	PID=$(echo $2)
	kill -9 $PID
}

kill_logger
echo "logger killed"
down_can
echo "can is down"
