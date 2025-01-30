variable "RABBITMQ_USER" {
  type = string
  sensitive = true
}

variable "RABBITMQ_PASSWORD" {
  type = string
  sensitive = true
}

resource "aws_mq_broker" "broker" {
  broker_name                  = "vfc_mq_broker"
  engine_type                  = "RabbitMQ"
  engine_version               = "3.13"
  auto_minor_version_upgrade   = true
  deployment_mode              = "SINGLE_INSTANCE"
  subnet_ids                   = [aws_subnet.public_subnet_1.id]
  host_instance_type           = "mq.t3.micro"
  publicly_accessible          = true
  user {
    username                   = "${var.RABBITMQ_USER}"
    password                   = "${var.RABBITMQ_PASSWORD}"
    console_access             = true
  }
}