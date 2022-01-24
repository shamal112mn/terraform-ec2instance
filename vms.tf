resource "aws_key_pair" "pub_key" {
  key_name   = "asus"
   
}


resource "aws_instance" "target" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.pub_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids      = [aws_security_group.allow_login.id]
  associate_public_ip_address = "true"
  # depends_on = [ aws_instance.agent ] 
  user_data  = file("userdata.sh")
  monitoring = "false"
  tags = {
    Name = "target"
  }
}
  
 
output "jenkins_master_public_ip" {
  value = aws_instance.target.public_ip
}
 