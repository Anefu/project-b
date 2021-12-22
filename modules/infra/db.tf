resource "aws_instance" "db" {
  ami                    = var.db_ami
  key_name               = aws_key_pair.ssh.key_name
  instance_type          = var.db_instance_type
  subnet_id              = aws_subnet.private_subnets[1].id
  vpc_security_group_ids = [aws_security_group.mysql.id]
  tags = {
    Name        = "DB"
    Environment = var.env
  }
}