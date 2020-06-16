resource "aws_ecs_cluster" "node_actions" {
  name = "node_actions"
}

resource "aws_ecs_task_definition" "node_actions" {
  family                   = "node_actions"
  execution_role_arn       = "${aws_iam_role.ecs_execution.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.fargate_cpu}"
  memory                   = "${var.fargate_memory}"

  container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "memory": ${var.fargate_memory},
    "image": "${var.container_image}",
    "name": "node_actions",
    "networkMode": "awsvpc"
  }
]
DEFINITION
}

resource "aws_ecs_service" "node_actions" {
  name               = "node_actions"
  cluster            = "${aws_ecs_cluster.node_actions.id}"
  task_definition    = "${aws_ecs_task_definition.node_actions.arn}"
  desired_count      = "${var.container_count}"
  launch_type        = "FARGATE"

  network_configuration {
    subnets          = ["${aws_subnet.public.id}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.http_access.id}"]
  }
}
