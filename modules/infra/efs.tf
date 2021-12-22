resource "aws_efs_file_system" "efs" {
  tags = {
    Name        = "Web-EFS"
    Environment = "${var.env}"
  }
}

resource "aws_efs_mount_target" "mount" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.private_subnets[0].id
  security_groups = [aws_security_group.efs.id]
}
