resource "aws_ecs_cluster" "dad_ecs" {
  name = "${var.environment}-cluster"
  
  setting {
    name  = "containerInsights"
    value = var.container_insight_status.disable ? "disabled" : "enabled"
  }
  
  tags = {
    Environment = var.environment
    Team        = "Devops-bootcamp"
  }
}
