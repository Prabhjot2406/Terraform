

resource "aws_key_pair" "deployer" {
  key_name   = "terra-automate-key"
  public_key = file("terra-key-ec2.pub")
}


resource "aws_default_vpc" "default" {

}

resource "aws_subnet" "default_subnet" {
  vpc_id                  = aws_default_vpc.default.id
  cidr_block              = "172.31.96.0/24"  # Choose a CIDR block
  availability_zone       = "us-east-1a"    # Choose an Availability Zone
  map_public_ip_on_launch = true
}

resource "aws_security_group" "psingh_allow_user_to_connect" {
  name        = "allow TLS"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "port 22 allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = " allow all outgoing traffic "
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 80 allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysecurity"
  }
}

resource "aws_instance" "testinstance" {
  for_each = tomap({                          #META ARGUMENT
    first_instance_name  = "t2.micro"
    second_instance_name = "t2.medium"
    # third_instance_name = "t2.small"        #first change made for terminal 1 
    # forth_instance_name = "t2.micro"        2nd change made for 2nd terminal
  })

  depends_on = [ aws_security_group.psingh_allow_user_to_connect , aws_key_pair.deployer ]  # one more meta argument 
  # YOU CAN ACCESS THIS KEY LIKE BELOW 
  #name     = each.key
  #location = each.value
  ami             = var.ec2_ami_id
  instance_type   = each.value   # meta argument used here 
  key_name        = aws_key_pair.deployer.key_name
  subnet_id       = aws_subnet.default_subnet.id
  security_groups = [aws_security_group.psingh_allow_user_to_connect.id]
  user_data = file("script.sh")
  tags = {
    Name = each.key  # Meta argument used here 
  }

 root_block_device {
    volume_size = var.aws_root_storage_size
    volume_type = "gp3"
  }
}

/* resource "aws_instance" "state-instance-update" {
  # Dummy values — will be overwritten by actual instance data
  ami           = "unknown"  # Just use any valid value for now
  instance_type = "unknown"
} */



