resource "aws_security_group" "practica_recursos" { 
  name_prefix = "practica_recursos-" 
  description = "Allow inbound traffic" 
  vpc_id      = aws_vpc.main.id 
  ingress { 
    from_port   = 22 
    to_port     = 22 
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"] 
  } 
} 
resource "aws_instance" "practica_recursos_instancia" { 
  ami           = "busqueda en en aws" 
  instance_type = "t2.micro" 
  subnet_id     = aws_subnet.subnet.id 
  depends_on = [aws_security_group.practica_recursos]

  # Asegura que el grupo de seguridad se cree antes que la instancia 
}