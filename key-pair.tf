resource "aws_key_pair" "keys" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub")
}