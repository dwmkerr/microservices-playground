#!/usr/bin/env bash

echo ECS_CLUSTER=${ecs_cluster_name} >> /etc/ecs/ecs.config

# Log everything we do.
set -x
exec > /var/log/user-data.log 2>&1

#   TODO: we need to set the availability zone, in the form below.
# mkdir -p /etc/aws/
# cat > /etc/aws/aws.conf <<- EOF
# [Global]
# Zone = ${availability_zone}
# EOF

# Create initial logs config.
cat > ./awslogs.conf <<- EOF
[general]
state_file = /var/awslogs/state/agent-state

[/var/log/messages]
log_stream_name = ecs_cluster_node_{instance_id}
log_group_name = /var/log/messages
file = /var/log/messages
datetime_format = %b %d %H:%M:%S
buffer_duration = 5000
initial_position = start_of_file

[/var/log/user-data.log]
log_stream_name = ecs_cluster_node_{instance_id}
log_group_name = /var/log/user-data.log
file = /var/log/user-data.log

[/var/log/ecs]
log_stream_name = ecs_instance_container_logs
file = /var/log/ecs
EOF

# Download and run the AWS logs agent.
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
python ./awslogs-agent-setup.py --non-interactive --region ${region} -c ./awslogs.conf

# Start the awslogs service, also start on reboot.
# Note: Errors go to /var/log/awslogs.log
service awslogs start
chkconfig awslogs on
