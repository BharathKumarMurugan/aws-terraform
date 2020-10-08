resource "aws_launch_configuration" "exampleLaunchConfig" {
  name          = var.launch_config_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.keyname
}
resource "aws_placement_group" "examplePlacement" {
  name     = var.placement_grp_name
  strategy = "cluster"
}

resource "aws_autoscaling_group" "example_ASG" {
  name                      = var.autoscaling_grp_name
  max_size                  = var.max     # required
  min_size                  = var.min     # required
  desired_capacity          = var.desired # required
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  placement_group           = aws_placement_group.examplePlacement.id
  launch_configuration      = aws_launch_configuration.exampleLaunchConfig.name
  vpc_zone_identifier       = var.subnet_ids

  tags = concat(
    [
      {
        "key"                 = "Name",
        "value"               = var.autoscaling_grp_name
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Environment",
        "value"               = var.env
        "propagate_at_launch" = false
      }
    ]
  )
}
