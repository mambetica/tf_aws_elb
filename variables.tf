# Base ELB
variable "name" {
  description = "The name of the ELB"
}
variable "owner" {
  description = "Owner tag added to resource to identify who build the resource"
  default = "Terraform"
}
variable "subnets" { }
variable "internal" {
  description = "Is the ELB internal (true) or external (false)"
  default = false
}
variable "security_group" {
  description = "A security group to assign to the ELB"
}
variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  default = true
}
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  default = 60
}
variable "connection_draining" {
  description = "Enable connection draining"
  default = true
}
variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain"
  default = 400
}
# Access Logs
variable "access_logs_S3_bucket" {
  description = "The S3 bucket name where logs are stored"
  default = "elb_logs"
}
variable "access_logs_S3_bucket_prefix" {
  description = "The S3 bucket prefix. Logs are stored in the root if not configured"
  default = ""
}
variable "access_logs_interval" {
  description = "The publishing interval in minutes"
  default = 60
}
# Listener
variable "listener_instance_port" {
  description = "The port on the instance to route to"
  default = 443
}
variable "listener_instance_protocol" {
  description = "The protocol to use to the instance. Valid values are HTTP, HTTPS, TCP, or SSL"
  default = "https"
}
variable "lb_port" {
  description = "The port to listen on for the load balancer"
  default = 443
}
variable "lb_protocol" {
  description = "The protocol to listen on. Valid values are HTTP, HTTPS, TCP, or SSL"
  default = "https"
}
/*variable "listener_ssl_certificate_id" {
  description = "The ARN of an SSL certificate you have uploaded to AWS IAM. Only valid when lb_protocol is either HTTPS or SSLs"
} */
# Health Check
variable "health_check_healthy_threshold" {
  description = "The number of checks before the instance is declared healthy"
  default = 2
}
variable "health_check_unhealthy_threshold" {
  description = "The number of checks before the instance is declared unhealthy"
  default = 2
}
variable "health_check_timeout" {
  description = "The length of time before the check times out"
  default = 3
}
variable "health_check_target" {
  description = "The target of the check"
}
variable "health_check_interval" {
  description = "The interval between checks"
  default = 30
}
# Route 53
variable "route53_zone_name" {
  description = "External domain name used"
}