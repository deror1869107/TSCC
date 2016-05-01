#!/bin/bash

swapoff -a
sync; echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
echo 0 > /proc/sys/kernel/randomize_va_space

for NODE in node2 node3 node4; do
	ssh "root@${NODE}" 'swapoff -a'
	ssh "root@${NODE}" 'sync; echo 3 > /proc/sys/vm/drop_caches'
	ssh "root@${NODE}" 'echo 1 > /proc/sys/vm/compact_memory'
	ssh "root@${NODE}" 'echo 0 > /proc/sys/kernel/randomize_va_space'
	scp xhpl "root@${NODE}:~/hpl-2.2/bin/Linux_Intel64/"
done

mpirun --rsh=rsh -hostfile ~/hostfile -n 16 nice -n -20 ./xhpl

