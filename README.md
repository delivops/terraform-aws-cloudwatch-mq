![image info](logo.jpeg)

# Terraform-aws-mq-cloudwatch

Terraform-aws-mq-cloudwatch is a Terraform module for setting up a notification system about cloudwatch mq metrics.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage

The module will create a notification system about your mq broker.
Use this module multiple times to create repositories with different configurations.

Include this repository as a module in your existing terraform code:

```python

################################################################################
# AWS mq
################################################################################


provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "sns_topic" {
  name         = "sns"
  display_name = "sns"
}

module "mq_alarms" {
  source              = "delivops/mq-alerts/aws"
  #version            = "0.0.1"

  broker_name        = "your-broker-name"
  all_alarms_sns_arns   = [aws_sns_topic.sns_topic.arn]
  tags = {
    Environment = "production"
  }
}

```
