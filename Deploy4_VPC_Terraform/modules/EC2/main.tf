# Create EC2 resources

resource "aws_instance" "web_server1" {
    ami = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet_az1.id
    vpc_security_group_ids = [aws_security_group.web_ssh.id]

    tags = {
        "Name" : "Webserver 1"
    }
}

resource "aws_instance" "web_server2" {
    ami = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet_az1.id
    
    tags = {
        "Name" : "Webserver 2"
    }
}

output "instance_ip" {
    value = aws_instance.web_server1.public_ip
}