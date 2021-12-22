resource "aws_instance" "db" {
  ami                    = var.bastion_ami
  key_name               = aws_key_pair.ssh.key_name
  instance_type          = var.db_instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = {
    Name        = "Bastion"
    Environment = var.env
  }
}