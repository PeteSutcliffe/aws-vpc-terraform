resource "aws_flow_log" "demo_flow_log" {
  log_group_name = "${aws_cloudwatch_log_group.demo_log_group.name}"
  iam_role_arn   = "${aws_iam_role.demo_role.arn}"
  vpc_id         = "${aws_vpc.vpc.id}"
  traffic_type   = "ALL"
}

resource "aws_cloudwatch_log_group" "demo_log_group" {
  name = "demo_vpc_log_group"
}

resource "aws_iam_role" "demo_role" {
  name = "demo_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "demo_policy" {
  name = "demo_policy"
  role = "${aws_iam_role.demo_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
