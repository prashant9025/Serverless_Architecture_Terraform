/*
# To Create DyanamoDB Table

resource "aws_dynamodb_table" "my_table" {
    name = "newtable"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "unique"
    attribute {
        name = "unique"
        type = "S"
    }
}
*/