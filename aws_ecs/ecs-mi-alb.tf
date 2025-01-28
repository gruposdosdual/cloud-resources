resource "aws_lb" "ejemplo-alb" {
  name               = "ecs-alb-dad"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]  
  
  # Subnets for the ALB (Make sure these are public subnets)
  subnets            = [data.aws_subnets.public_subnet_1.ids[0], data.aws_subnets.public_subnet_2.ids[0]]  
  
  enable_deletion_protection = false
  
  tags = {
    Name = "ecs-alb-dad"
  }
}

# Target Group for ECS Service
resource "aws_lb_target_group" "ecs_targets" {
  name     = "ecs-target-group-dad"
  port     = 80
  protocol = "HTTP"
  
  vpc_id = var.vpc_id  
  target_type = "ip"
  
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    protocol = "HTTP"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.ejemplo-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_targets.arn
  }
}