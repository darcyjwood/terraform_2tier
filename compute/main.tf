# compute main.tf

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_launch_template" "demo_bastion" {
  name_prefix            = "demo_bastion"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.bastion_instance_type
  vpc_security_group_ids = [var.public_sg]
  key_name               = var.key_name

  tags = {
    Name = "demo_bastion"
  }
}

resource "aws_autoscaling_group" "demo_bastion" {
  name                = "demo_bastion"
  vpc_zone_identifier = tolist(var.public_subnet)
  min_size            = 1
  max_size            = 1
  desired_capacity    = 1

  launch_template {
    id      = aws_launch_template.demo_bastion.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "demo_database" {
  name_prefix            = "demo_database"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.database_instance_type
  vpc_security_group_ids = [var.private_sg]
  key_name               = var.key_name
  user_data              = filebase64("nginx.sh")

  tags = {
    Name = "demo_database"
  }
}

resource "aws_autoscaling_group" "demo_database" {
  name                = "demo_database"
  vpc_zone_identifier = tolist(var.public_subnet)
  min_size            = 2
  max_size            = 5
  desired_capacity    = 5

  launch_template {
    id      = aws_launch_template.demo_database.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.demo_database.id
  lb_target_group_arn = var.lb_tg
}

# resource "aws_autoscaling_schedule" "business_hours_scale_up" {
#   scheduled_action_name  = "business_hours_scale_up"
#   min_size               = 2
#   max_size               = 10
#   desired_capacity       = 5
#   start_time             = "2016-12-11T18:00:00Z"
#   end_time               = "2016-12-12T06:00:00Z"
#   autoscaling_group_name = aws_autoscaling_group.business_hours_scale_up.name
# }

# resource "aws_autoscaling_schedule" "n0n_business_hours_scale_down" {
#   scheduled_action_name  = "non_business_hours_scale_down"
#   min_size               = 2
#   max_size               = 5
#   desired_capacity       = 2
#   start_time             = "2016-12-11T18:00:00Z"
#   end_time               = "2016-12-12T06:00:00Z"
#   autoscaling_group_name = aws_autoscaling_group.non_business_hours_scale_down.name
#}