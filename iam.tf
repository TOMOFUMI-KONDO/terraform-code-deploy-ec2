resource "aws_iam_policy" "code-deploy" {
  name = "code-deploy-demo"
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid : "",
        Effect : "Allow",
        Action : [
          "codedeploy:CreateDeployment"
        ],
        Resource : [
          aws_codedeploy_deployment_group.code-deploy-group.arn
        ]
      },
      {
        Sid : "",
        Effect : "Allow",
        Action : [
          "codedeploy:GetDeploymentConfig"
        ],
        Resource : [
          "arn:aws:codedeploy:ap-northeast-1:181562662531:deploymentconfig:CodeDeployDefault.OneAtATime"
        ]
      },
      {
        Sid : "",
        Effect : "Allow",
        Action : [
          "codedeploy:RegisterApplicationRevision",
          "codedeploy:GetApplicationRevision"
        ],
        Resource : [
          aws_codedeploy_app.code-deploy-app.arn
        ]
      }
    ]
  })
}
