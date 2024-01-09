resource "aws_instance" "web" {
  ami           = "ami-03265a0778a880afb"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.roboshop-all.id]
  
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> inventory"
  }

  tags = {
    Name = "provisioner "
  }
 # How to integrate terraform with Ansible 
  # provisioner "local-exec" {
  #   command = "ansible-playbook -i inventory web.yaml"
  # }
   provisioner "local-exec" {
    command = "echo running at terraform destroy command execution"
    when = destroy
  }

   provisioner "local-exec" {
    command = "echo running at terraform apply command execution"
  }

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'this is from remote exec' > /tmp/remote.txt",
      "sudo yum install nginx -y",
      "sudo systemctl restart nginx"

    ]
  }
  
}
resource "aws_security_group" "roboshop-all" {
  name        = "provisioner"
  ingress {
    description      = "Allow 22 ports"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow 22 ports"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "provisioner"
  }
}
