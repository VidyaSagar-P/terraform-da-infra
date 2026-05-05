module "mysql" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-mysql"
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id     = local.database_subnet_id

  create_security_group = false

  tags = merge(
    var.common_tags,
    var.mysql_tags,
    {
    Name = "${local.resource_name}-mysql"
    }
  )
}

module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-backend"
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.backend_sg_id]
  subnet_id     = local.private_subnet_id

  create_security_group = false

  tags = merge(
    var.common_tags,
    var.backend_tags,
    {
    Name = "${local.resource_name}-backend"
    }
  )
}

module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-frontend"
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.frontend_sg_id]
  subnet_id     = local.public_subnet_id

  create_security_group = false

  tags = merge(
    var.common_tags,
    var.frontend_tags,
    {
    Name = "${local.resource_name}-frontend"
    }
  )
}

# r53 records
module "zone" {
  source = "terraform-aws-modules/route53/aws"

  create_zone = false

  records = {
    frontend = {
      zone_id = data.aws_route53_zone.hosted_zone.zone_id
      name    = "frontend"
      type    = "A"
      ttl     = 1
      records = [module.frontend.private_ip]
      allow_overwrite = true
    }

    backend = {
      zone_id = data.aws_route53_zone.hosted_zone.zone_id
      name    = "backend"
      type    = "A"
      ttl     = 1
      records = [module.backend.private_ip]
      allow_overwrite = true
    }

    mysql = {
      zone_id = data.aws_route53_zone.hosted_zone.zone_id
      name    = "mysql"
      type    = "A"
      ttl     = 1
      records = [module.mysql.private_ip]
      allow_overwrite = true
    }
  }
}

# Handle apex record separately
resource "aws_route53_record" "frontend" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "bavs.space"
  type    = "A"
  ttl     = 1
  records = [module.frontend.public_ip]
  allow_overwrite = true
}