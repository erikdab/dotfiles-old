#!/bin/sh
QUERY=""
PAD=0
case "$1" in
	memory)
		MEM_USED=$(nvidia-smi --query-gpu='memory.used' --format=csv,noheader | awk '{print $1}' )
		MEM_TOTAL=$(nvidia-smi --query-gpu='memory.total' --format=csv,noheader | awk '{print $1}')
		RESULT=$(echo "scale=0; $MEM_USED * 100/ $MEM_TOTAL" | bc)
		PAD=3
		;;
	clocks)
		CLOCK_GR_MHZ=$(nvidia-smi --query-gpu='clocks.gr' --format=csv,noheader | awk '{print $1}')
		RESULT=$(echo "scale=2; $CLOCK_GR_MHZ / 1000" | bc | sed 's/^\./0./')
		;;
	utilization.gpu)
		RESULT=$(nvidia-smi --query-gpu=$1 --format=csv,noheader | awk '{print $1}')
		PAD=3
		;;
	temperature.gpu)
		PAD=3
		;;
esac

if [ "$RESULT" = "" ]; then
	RESULT="$(nvidia-smi --query-gpu=$1 --format=csv,noheader)"
fi

printf "%*s" $PAD "$RESULT"
# if [ $PAD -new 0 ]; then
# 	printf "%*s" $PAD "$RESULT"
# else
# 	echo $RESULT
# fi

        # temperature.gpu)
        #     QUERY="temperature.gpu"
        #     ;;
         
        # driver_version)
        #     QUERY="driver_version"
        #     ;;
         
        # name)
        #     QUERY="name"
        #     ;;
        # fan.speed)
        #     QUERY="fan.speed"
        #     ;;
        # pstate)
        #     QUERY="pstate"
#     ;;
	
		# memory.used)
		# 	QUERY="memory.used"
		# 	;;
		# memory.total)
		# 	QUERY="memory.total"
		# 	;;
		# utilization.gpu)
		# 	QUERY="utilization.gpu"
		# 	;;

