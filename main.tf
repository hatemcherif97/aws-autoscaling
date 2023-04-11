# create security group for the ec2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 80 and 22"
  vpc_id      = var.vpc_id 

  # allow access on port 80
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow access on port 22
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "apache server security group" #you can choose any name you like
  }
}

resource "aws_autoscaling_group" "tf" {
  desired_capacity    = 2  
  max_size            = 4  
  min_size            = 2
  vpc_zone_identifier = [var.subnet_id_2, var.subnet_id_1]   #two subnets

  launch_template {
    id      = aws_launch_template.tf_launch_template.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "tf_launch_template" {
  name_prefix            = "tf-launch_template"
  image_id               = var.image_id                 #in variable file
  instance_type          = var.instance_type            #in variable file
  key_name               = var.key_name                 #in variable file
  user_data              = filebase64("${path.root}/apache.sh")
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "terraform_auto_scaling"
    }
  }
}

