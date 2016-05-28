# This module assumes:
# - That the ELB will be associated to an Auto Scale Group (ASG) which will instantiate the instances, therefore instances are not associated to the ELB
# - That all traffic is HTTPS

resource "aws_elb" "elb" {
  name = "${var.elb_name}"
  subnets = "${var.subnets}"
  internal = "${var.internal}"
  security_groups = ["${var.security_groups}"]
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  idle_timeout = "${var.subnets}"
  connection_draining = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  
  access_logs {
    bucket = "${var.access_logs_S3_bucket}"
    bucket_prefix = "${var.access_logs_S3_bucket_prefix}"
    interval = "${var.access_logs_interval}"
  }

  listener {
    instance_port = "${var.listener_instance_port}"
    instance_protocol = "${var.listener_instance_protocol}"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.listener_ssl_certificate_id}"
  }

  health_check {
    healthy_threshold = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
    timeout = "${var.health_check_timeout}"
    target = "${var.health_check_target}"
    interval = "${var.health_check_interval}"
  }

  tags {
    Name = "${var.elb_name}"
    Owner = "${var.owner}"
  }
}