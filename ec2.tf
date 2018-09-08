resource "aws_instance" "server" {
  ami                    = "ami-0bdb1d6c15a40392c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.demo_sg.id}"]
  key_name               = "pete-eu-west-1"
  subnet_id              = "${aws_subnet.public_subnet_a.id}"

  tags {
    Name = "Web Server"
  }
}
