
resource "aws_appautoscaling_target" "ecs_scaling" {
  service_namespace  = "ecs"  
  resource_id        = "service/${aws_ecs_cluster.dad_ecs.name}/${aws_ecs_service.nginx_service.name}"  
  scalable_dimension = "ecs:service:DesiredCount"  
  min_capacity       = 1  
  max_capacity       = 5  
}

resource "aws_appautoscaling_policy" "cpu_scaling" {
  name                = "cpu-scaling"  
  policy_type         = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value       = 50.0  
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"  
    }
    scale_in_cooldown   = 300  
    scale_out_cooldown  = 300  
  }

  service_namespace    = "ecs"  
  resource_id          = "service/${aws_ecs_cluster.dad_ecs.name}/${aws_ecs_service.nginx_service.name}"  
  scalable_dimension   = "ecs:service:DesiredCount" 

  depends_on = [aws_appautoscaling_target.ecs_scaling] 
}