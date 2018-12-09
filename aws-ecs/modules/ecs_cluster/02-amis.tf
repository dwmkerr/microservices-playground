//  The latest ECS AMI, defined by:
//   - Owned by AWS
//   - ECS optimised instance
//   - HVM
data "aws_ami" "latest_ecs" {
  most_recent = true
  owners = ["591542846629"] // i.e. Amazon

  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }  
}

