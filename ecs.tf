resource "aws_ecs_cluster" "hello_world" {
  name = "hello_world"
}

resource "aws_ecs_task_definition" "hello_world" {
  family                   = "hello_world"
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
    "name": "hello_world",
    "networkMode": "awsvpc"
  }
]
DEFINITION
}

resource "aws_ecs_service" "hello_world" {
  name               = "hello_world"
  cluster            = "${aws_ecs_cluster.hello_world.id}"
  task_definition    = "${aws_ecs_task_definition.hello_world.arn}"
  desired_count      = "${var.container_count}"
  launch_type        = "FARGATE"

  network_configuration {
    subnets          = ["${aws_subnet.public.id}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.http_access.id}"]
  }
}
