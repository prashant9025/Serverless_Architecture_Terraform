/*
#To Create an SNS Topic  

resource "aws_sns_topic" "instance_termination" {
  name = "instance-termination-topic"
}

# Email Subscription
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.instance_termination.arn
  protocol  = "email"
  endpoint  = "prashant.pawar01@writerinformation.com"  # Replace with your email address
}


#To Create an event bridge rule

resource "aws_cloudwatch_event_rule" "ec2_rule" {
  name        = "ec2-termination-rule"
  description = "Triggers when an EC2 instance is terminated"
  
  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    "detail-type": ["EC2 Instance State-change Notification"],
    "detail": {
      "state": ["terminated"]
    }
  })
}

# To Add SNS as the Target in EventBridge Rule

resource "aws_cloudwatch_event_target" "my_target" {
  rule      = aws_cloudwatch_event_rule.ec2_rule.name
  arn       = aws_sns_topic.instance_termination.arn
}

# To give Permission to publish messages to SNS topic
resource "aws_sns_topic_policy" "sns_policy" {
  arn = aws_sns_topic.instance_termination.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        },
        Action = "sns:Publish",
        Resource = aws_sns_topic.instance_termination.arn
      }
    ]
  })
}
*/
