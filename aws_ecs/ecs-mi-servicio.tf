resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service-dad"
  cluster         = aws_ecs_cluster.dad_ecs.id  
  task_definition = aws_ecs_task_definition.nginx_task.arn  
  desired_count   = 1  # Numero de instancias
  launch_type     = "FARGATE"  

  network_configuration {
    subnets         = [data.aws_subnets.public_subnet_1.ids[0], data.aws_subnets.public_subnet_2.ids[0]]  
    security_groups = [aws_security_group.ec2_sg.id]  
    assign_public_ip = true  
  }

   load_balancer {
    target_group_arn = aws_lb_target_group.ecs_targets.arn
    container_name   = "nginx"
    container_port   = 80
  }

    depends_on = [
    aws_security_group.ec2_sg,  
    aws_lb.ejemplo-alb,
    aws_lb_listener.alb_listener,         
    aws_lb_target_group.ecs_targets  
  ]  
}
