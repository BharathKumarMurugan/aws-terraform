resource "aws_lb" "exampleALB" {
  name               = var.alb_name
  internal           = false         # making it as Internet Facing
  load_balancer_type = "application" # Application Load Balancer
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = true

  tags = {
    Environment = var.env
  }
}

resource "aws_lb_target_group" "exampleALBtargetGrp" {
  name        = var.target_grp_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_listener" "exampleALBlistener" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.exampleALB.arn
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
