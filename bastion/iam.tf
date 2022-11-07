#Instance Role
resource "aws_iam_role" "role" {
  name = "${var.service_name}-${var.environment_name}-ec2-ssm-cw"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-ssm-ec2-iam-role"}))
}

#Instance Profile
resource "aws_iam_instance_profile" "profile" {
  name = "${var.service_name}-${var.environment_name}-ssm-ec2"
  role = aws_iam_role.role.id

  tags = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-ssm-ec2-iam-profile"}))
}

#Attach SSM Policies to Instance Role
resource "aws_iam_role_policy_attachment" "core_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "role_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

#Attach CloudWatch Policies to Instance Role
resource "aws_iam_role_policy_attachment" "cw_role_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
