resource "aws_dynamodb_table" "my_nosql_table" {
  name         = "MyNoSQLTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"

  attribute {
    name = "ID"
    type = "S"
  }

  tags = {
    Name = "MyNoSQLTable"
  }
}
