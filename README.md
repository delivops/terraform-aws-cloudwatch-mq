[![DelivOps banner](https://raw.githubusercontent.com/delivops/.github/main/images/banner.png?raw=true)](https://delivops.com)

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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.confirm_ack_proportion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_cpu_system](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.slow_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.slow_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_all_alarms_sns_arns"></a> [all\_alarms\_sns\_arns](#input\_all\_alarms\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_broker_name"></a> [broker\_name](#input\_broker\_name) | The name of the RabbitMQ broker | `string` | `null` | no |
| <a name="input_high_cpu_system_enabled"></a> [high\_cpu\_system\_enabled](#input\_high\_cpu\_system\_enabled) | Enable high CPU system alarm | `bool` | `true` | no |
| <a name="input_high_cpu_system_sns_arns"></a> [high\_cpu\_system\_sns\_arns](#input\_high\_cpu\_system\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_high_cpu_system_threshold"></a> [high\_cpu\_system\_threshold](#input\_high\_cpu\_system\_threshold) | The threshold for high CPU system usage | `number` | `90` | no |
| <a name="input_high_memory_enabled"></a> [high\_memory\_enabled](#input\_high\_memory\_enabled) | Enable high memory alarm | `bool` | `true` | no |
| <a name="input_high_memory_sns_arns"></a> [high\_memory\_sns\_arns](#input\_high\_memory\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_high_memory_threshold"></a> [high\_memory\_threshold](#input\_high\_memory\_threshold) | The threshold for high memory usage | `number` | `85` | no |
| <a name="input_rate_proportion_enabled"></a> [rate\_proportion\_enabled](#input\_rate\_proportion\_enabled) | Enable rate proportion alarm | `bool` | `true` | no |
| <a name="input_rate_proportion_sns_arns"></a> [rate\_proportion\_sns\_arns](#input\_rate\_proportion\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_rate_proportion_threshold"></a> [rate\_proportion\_threshold](#input\_rate\_proportion\_threshold) | The threshold for rate proportion | `number` | `3` | no |
| <a name="input_slow_read_enabled"></a> [slow\_read\_enabled](#input\_slow\_read\_enabled) | The threshold for slow reads | `bool` | `true` | no |
| <a name="input_slow_read_sns_arns"></a> [slow\_read\_sns\_arns](#input\_slow\_read\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_slow_write_enabled"></a> [slow\_write\_enabled](#input\_slow\_write\_enabled) | The threshold for slow writes | `bool` | `true` | no |
| <a name="input_slow_write_sns_arns"></a> [slow\_write\_sns\_arns](#input\_slow\_write\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->