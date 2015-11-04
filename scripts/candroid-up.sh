#!/system/bin/sh

setup_can(){
	ip link set can0 type can bitrate 250000
	ip link set can1 type can bitrate 250000
	ip link set up can0
	ip link set up can1
}

setup_can
echo "can is up"
