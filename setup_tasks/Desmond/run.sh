#!/bin/bash

swapoff -a
sync; echo 3 > /proc/sys/vm/drop_caches
echo 1 > /proc/sys/vm/compact_memory
echo noop > /sys/block/sda/queue/scheduler
echo 0 > /sys/block/sda/queue/add_random
echo 2 > /sys/block/sda/queue/rq_affinity

for NODE in node2 node3 node4; do
	ssh "root@${NODE}" 'swapoff -a'
	ssh "root@${NODE}" 'sync; echo 3 > /proc/sys/vm/drop_caches'
	ssh "root@${NODE}" 'echo 1 > /proc/sys/vm/compact_memory'
	ssh "root@${NODE}" 'echo noop > /sys/block/sda/queue/scheduler'
	ssh "root@${NODE}" 'echo 0 > /sys/block/sda/queue/add_random'
	ssh "root@${NODE}" 'echo 2 > /sys/block/sda/queue/rq_affinity'
done

### Multisim GPU ###
# nice -n -20 $SCHRODINGER/utilities/multisim -JOBNAME desmond_fep_job_1_solvent -HOST "node1:1 node2:1 node3:1 node4:1" -maxjob 4 -m desmond_fep_job_1_solvent.msj -o desmond_fep_job_1_solvent-out.mae -description 'Total Free Energy by FEP' desmond_fep_job_1_lig.mae -set stage[1].set_family.md.jlaunch_opt=["-gpu"]

### Multisim CPU ###
# nice -n -20 $SCHRODINGER/utilities/multisim -JOBNAME desmond_fep_job_1_solvent -HOST "node1:4 node2:4 node3:4 node4:4" -maxjob 16 -m desmond_fep_job_1_solvent.msj -o desmond_fep_job_1_solvent-out.mae -description 'Total Free Energy by FEP' desmond_fep_job_1_lig.mae

### Desmond GPU ###
# nice -n -20 $SCHRODINGER/desmond -HOST "node1:1 node2:1 node3:1 node4:1" -c desmond_md_job_1.cfg -in desmond_md_job_1.cms -gpu -overwrite -comm mpi

### Desmond CPU ###
# nice -n -20 $SCHRODINGER/desmond -HOST "node1:4 node2:4 node3:4 node4:4" -c desmond_md_job_1.cfg -in desmond_md_job_1.cms -gpu -overwrite -comm mpi

