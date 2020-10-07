module "alb" {
    source = "terraform-aws-modules/alb/aws"
    version = "~>5.0"
    
    name = "new-alb"

    load_balancer_type = "application"
    vpc_id = var.vpc_id
    subnets = ["subnet-016ed1656771f9387","subnet-05a85f9384d55fb5f"]
   # access_logs = {
   #     bucket = "config-bucket-356700607205"
   # }

    target_groups = [
        {
            name_prefix = "pref-"
            backend_protocol = "HTTP"
            backend_port = 80
            target_type = "instance"
        }
    ]
    http_tcp_listeners = [
        {
            port = 80
            protocol = "HTTP"
            target_group_index = 0
        }
    ]
    tags = {
        Environment = "dev"
    }
}
