# This module assumes:
# - That the ELB will be associated to an Auto Scale Group (ASG) which will instantiate the instances, therefore instances are not associated to the ELB
# - That all traffic is HTTPS

resource "aws_elb" "elb" {
  name = "${var.name}"
  subnets = ["${split(",", var.subnets)}"]
  internal = "${var.internal}"
  security_groups = ["${var.security_group}"]
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  idle_timeout = "${var.idle_timeout}"
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
    lb_port = 80
    lb_protocol = "http"
#    ssl_certificate_id = "${var.listener_ssl_certificate_id}"
  }

  health_check {
    healthy_threshold = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
    timeout = "${var.health_check_timeout}"
    target = "${var.health_check_target}"
    interval = "${var.health_check_interval}"
  }

  tags {
    Name = "${var.name}"
    Owner = "${var.owner}"
  }
}

resource "aws_route53_zone" "primary" {
  name = "${var.route53_zone_name}"
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name = "${var.route53_zone_name}"
  type = "A"

  alias {
    name = "${aws_elb.elb.dns_name}"
    zone_id = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }
}