resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-task"
  network_mode             = "awsvpc"  
  requires_compatibilities = ["FARGATE"]

  # Specify CPU and Memory at the task level
  cpu                      = "256"   # 256 CPU units (adjust as necessary)
  memory                   = "512"   # 512 MiB of memory (adjust as necessary)

  container_definitions = jsonencode([{
    name      = "nginx"
    image     = "nginx:latest"  
    essential = true

    portMappings = [
      {
        containerPort = 80  
        hostPort      = 80  
      }
    ]

    # Configuracion de memoria
    memory        = 512      # Memoria limite del contenedor (in MB)
    memoryReservation = 256  # Memoria reservada para el contenedor (in MB)
  }])
}
