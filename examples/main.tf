provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "sns_topic" {
  name         = "sns"
  display_name = "sns"
}


module "mq_alarms" {
  source              = "../"
  broker_name         = "rabbitmq"
  all_alarms_sns_arns = [aws_sns_topic.sns_topic.arn]
}


