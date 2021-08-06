resource "aws_codedeploy_app" "code-deploy-app" {
  name = "${var.project}-code-deploy-app"
}

resource "aws_codedeploy_deployment_group" "code-deploy-group" {
  app_name              = aws_codedeploy_app.code-deploy-app.name
  deployment_group_name = "${var.project}-code-deploy-group"
  service_role_arn      = aws_iam_role.code-deploy-service-role.arn
  ec2_tag_filter {
    type  = "KEY_AND_VALUE"
    key   = "Project"
    value = var.project
  }
}

resource "aws_iam_role" "code-deploy-service-role" {
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Sid : "",
        Effect : "Allow",
        Principal : {
          Service : [
            "codedeploy.ap-northeast-1.amazonaws.com"
          ]
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = var.project
  }
}

resource "aws_iam_role_policy_attachment" "aws-code-deploy-role" {
  role       = aws_iam_role.code-deploy-service-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}
