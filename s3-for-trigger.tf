/*
# Create S3 bucket
resource "aws_s3_bucket" "lambda_trigger_bucket" {
  bucket = "my-lambda-trigger-bkt" # Replace with a unique bucket name
  
  # Force empty the bucket before destroying
  force_destroy = true
  
  tags = {
    Name        = "MyLambdaTriggerBucket"
    Environment = "Development"
  }
}

# Add bucket notification configuration for Lambda
resource "aws_s3_bucket_notification" "lambda_bucket_notification" {
  bucket = aws_s3_bucket.lambda_trigger_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.my_lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
    	
  }
  depends_on = [aws_lambda_permission.allow_s3_invoke]
}

# Grant S3 permission to invoke the Lambda function
resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.lambda_trigger_bucket.arn
}

# Update IAM Role for Lambda to include S3 access
resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "S3FullAccessPolicy"
  description = "Policy providing full access to S3"

  policy = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Effect : "Allow"
        Action : [
          "s3:*"
        ]
        Resource : [
          aws_s3_bucket.lambda_trigger_bucket.arn,
          "${aws_s3_bucket.lambda_trigger_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.lambda_dynamodb_role.name
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}
*/