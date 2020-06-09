resource "aws_ecs_cluster" "hello_world" {
  name = "hello_world"
}

resource "aws_ecs_task_definition" "hello_world" {
  family                   = "hello_world"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = <<DEFINITION
[
  {
    "cpu": 256,
    "image": "devopsmixtape/hello_world_docker:latest",
    "memory": 512,
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
  desired_count      = 1
  launch_type        = "FARGATE"

  network_configuration {
    subnets          = ["${aws_subnet.public.id}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.http_access.id}"]
  }
}
