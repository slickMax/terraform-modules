resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ami.id
  iam_instance_profile        = aws_iam_instance_profile.profile.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.subnet_ids
  vpc_security_group_ids      = [aws_security_group.bastion_ssh.id]
  key_name                    = var.ssh_key_name

  lifecycle {
    ignore_changes = [ami]
  }

  tags                        = merge(var.tags, tomap({"Name" = "${var.environment_name}-bastion-ec2"}))
  volume_tags                 = merge(var.tags, tomap({"Name" = "${var.environment_name}-bastion-root-ebs"}))
}
