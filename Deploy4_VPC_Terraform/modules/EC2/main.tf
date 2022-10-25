# Create EC2 resources

resource "aws_security_group" "web_ssh" {
  name        = "ssh-access"
  description = "open ssh traffic"
  vpc_id = var.vpc_id
 

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "Web server001"
    "Terraform" : "true"
  }
  
}

resource "aws_instance" "web_server1" {
    ami = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
    subnet_id = var.public_subnet_az1_id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.web_ssh.id]

    user_data = "${file("deploy.sh")}"

    tags = {
        "Name" : "Webserver 1"
    }
}

resource "aws_instance" "web_server2" {
    ami = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
    subnet_id = var.private_subnet_az1_id
    key_name = var.key_name
    
    tags = {
        "Name" : "Webserver 2"
    }
}

output "instance_ip" {
    value = aws_instance.web_server1.public_ip
}