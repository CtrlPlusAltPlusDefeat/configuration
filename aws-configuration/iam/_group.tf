resource "aws_iam_group" "iam_group" {
  name     = "ManagedByTerraform"

  provider = aws.europe_london
}

resource "aws_iam_group_membership" "iam_group_membership" {
  name = "ManagedByTerraformMembership"

  users = [
    aws_iam_user.configuration.name,
    aws_iam_user.terraform.name
  ]

  group    = aws_iam_group.iam_group.name

  provider = aws.europe_london
}