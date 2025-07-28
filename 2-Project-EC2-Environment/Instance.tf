resource "aws_instance" "web" {
  ami                    = var.aws_ami_id[var.aws_region]
  key_name               = aws_key_pair.dove.key_name
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone      = var.aws_availability_zone
  instance_type          = "t2.micro"

  tags = {
    Name    = "dove-web-instance"
    Project = "dove-project"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }
  connection {
    type        = "ssh"
    user        = var.web_user
    private_key = file("dove-key")
    host        = self.public_ip

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

}

resource "aws_ec2_instance_state" "web-state" {
  instance_id = aws_instance.web.id
  state       = "running"
}