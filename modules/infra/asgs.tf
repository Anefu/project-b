resource "aws_launch_template" "nginx_lt" {
  depends_on = [
    aws_lb.nginx_lb
  ]
  name          = "Nginx-LT"
  image_id      = var.nginx_ami
  instance_type = var.nginx_instance_type
  key_name      = aws_key_pair.ssh.key_name
  user_data = templatefile("${path.module}/files/setup-nginx.sh", {
    domain_name = var.domain_name,
    alb         = aws_lb.web_lb.dns_name
    }
  )
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      encrypted   = false
      volume_type = "gp2"
      volume_size = "50"
    }
  }
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "Nginx"
      Environment = var.env
    }
  }

  tags = {
    Name        = "Nginx-LT"
    Environment = var.env
  }
}

resource "aws_launch_template" "web_lt" {
  depends_on = [
    aws_efs_file_system.efs,
  ]
  name          = "Webservers-LT"
  image_id      = var.web_ami
  instance_type = var.web_instance_type
  key_name      = aws_key_pair.ssh.key_name
  user_data = templatefile("${path.module}/files/setup-web.sh", {
    file_system = aws_efs_file_system.efs.id,
  })
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      encrypted   = false
      volume_type = "gp2"
      volume_size = "50"
    }
  }
  vpc_security_group_ids = [aws_security_group.webservers.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "Webservers"
      Environment = var.env
    }
  }

  tags = {
    Name        = "Webservers-LT"
    Environment = var.env
  }
}

resource "aws_autoscaling_group" "nginx_asg" {
  name                = "Nginx-ASG"
  desired_capacity    = var.nginx_min
  max_size            = var.nginx_max
  min_size            = var.nginx_min
  target_group_arns   = [aws_lb_target_group.nginx_tg.arn]
  vpc_zone_identifier = [aws_subnet.public_subnet.id]

  launch_template {
    id      = aws_launch_template.nginx_lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                = "Web-ASG"
  desired_capacity    = var.web_min
  max_size            = var.web_max
  min_size            = var.web_min
  target_group_arns   = [aws_lb_target_group.web_tg.arn]
  vpc_zone_identifier = [aws_subnet.private_subnets[0].id]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
}

