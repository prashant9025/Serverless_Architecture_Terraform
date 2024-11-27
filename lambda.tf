/*
# To create a IAM role for lambda

resource "aws_iam_role" "lambda_dynamodb_role" {
  name = "lambda_dynamodb_full_access"

  assume_role_policy = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Effect : "Allow"
        Principal : {
          Service : "lambda.amazonaws.com"
        }
        Action : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "dynamodb_full_access_policy" {
  name        = "DynamoDBFullAccessPolicy"
  description = "Policy providing full access to DynamoDB"

  policy = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Effect : "Allow"
        Action : [
          "dynamodb:*"
        ]
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_dynamodb_policy" {
  role       = aws_iam_role.lambda_dynamodb_role.name
  policy_arn = aws_iam_policy.dynamodb_full_access_policy.arn
}

resource "aws_lambda_function" "my_lambda_function" {
  filename         = "function.zip" # Path to your Lambda deployment package
  function_name    = "MyLambdaFunction"
  role             = aws_iam_role.lambda_dynamodb_role.arn
  handler          = "function.lambda_handler"
  runtime          = "python3.8" # Replace with your Lambda runtime
  source_code_hash = filebase64sha256("function.zip") # Ensure this matches the Lambda code
}
*/