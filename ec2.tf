resource "aws_instance" "ec2" {
  ami                  = var.ami.amazon-linux-2
  instance_type        = "t3.nano"
  subnet_id            = aws_subnet.public_a.id
  key_name             = var.key_pair
  user_data            = file("userdata.tpl")
  iam_instance_profile = aws_iam_instance_profile.ec2-instance-profile.name

  vpc_security_group_ids = [
    aws_security_group.allow_http_public.id,
    aws_security_group.allow_ssh_from_admin.id
  ]

  tags = {
    Name    = "${var.project}-ec2"
    Project = var.project
  }
}

resource "aws_iam_role" "ec2-instance-profile" {
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid : "",
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = var.project
  }
}

resource "aws_iam_role_policy_attachment" "amazon-ssm-managed-instance-core" {
  role       = aws_iam_role.ec2-instance-profile.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2-instance-profile.name
}

resource "aws_security_group" "allow_ssh_from_admin" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_global_ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.project}-sg-allow-ssh-from-admin"
    Project = var.project
  }
}

resource "aws_security_group" "allow_http_public" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_alb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.project}-sg-allow-http-public"
    Project = var.project
  }
}
