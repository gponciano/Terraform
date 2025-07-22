resource "aws_instance" "web" {
  ami           = data.aws_ami.amiID.id
  key_name      = aws_key_pair.dove.key_name
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone = "us-east-2a"
  instance_type = "t3.micro"

  tags = {
    Name = "dove-web-instance"
    Project = "dove-project"
  }
}