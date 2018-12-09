//  A load balancer target group for the ms-otp service.
resource "aws_alb_target_group" "ms-otp" {
  name                = "ms-otp"
  port                = "80"
  protocol            = "HTTP"
  vpc_id              = "${aws_vpc.ecs_cluster.id}"

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200"
    path                = "/healthcheck"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on      = ["aws_alb.ecs_cluster"]
}

//  A listener, which forwards traffic to the ms-otp target group.
resource "aws_alb_listener" "ms-otp-listener" {
  load_balancer_arn = "${aws_alb.ecs_cluster.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.ms-otp.arn}"
    type             = "forward"
  }
}

//  Attach the target group to the cluster nodes auto-scaling group.
resource "aws_autoscaling_attachment" "ms-otp-service-attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.ecs_cluster_node.id}"
  alb_target_group_arn   = "${aws_alb_target_group.ms-otp.arn}"
}

# The OTP Service role.
data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ms-otp-service-role" {
  name                = "ms-otp-service-role"
  path                = "/"
  assume_role_policy  = "${data.aws_iam_policy_document.ecs-service-policy.json}"
}

resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
  role       = "${aws_iam_role.ms-otp-service-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

# The OTP Service task.
resource "aws_ecs_task_definition" "ms-otp-service-task" {
  family                = "service"
  container_definitions = "${file("${path.module}/files/ms-otp-task.json")}"

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [${join(", ", keys(var.subnets))}]"
  }
}

# The OTP Service.
resource "aws_ecs_service" "ms-otp-service" {
  name            = "ms-otp-service"
  cluster         = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.ms-otp-service-task.arn}"
  desired_count   = 3
  iam_role        = "${aws_iam_role.ms-otp-service-role.name}"
  depends_on      = ["aws_iam_role.ms-otp-service-role"]

  load_balancer {
    target_group_arn = "${aws_alb_target_group.ms-otp.arn}"
    container_name   = "ms-otp"
    container_port   = 3000
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [${join(", ", keys(var.subnets))}]"
  }
}

