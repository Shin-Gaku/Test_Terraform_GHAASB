run "test_vpc_cidr" {
  command = plan

  module {
    source = "./modules/vpc"
  }
  assert {
    condition     = output.vpc_cidr == "10.0.0.0/16"
    error_message = "VPCのCIDRは期待値の10.0.0.0/16と一致しません"
  }
}

run "test_public_subnet1_cidr" {
  command = plan

  module {
    source = "./modules/vpc"
  }
  assert {
    condition     = output.public_subnets_cidr[0] == "10.0.1.0/24"
    error_message = "public_subnet1のCIDRは期待値の10.0.1.0/24と一致しません"
  }
}

run "test_public_subnet2_cidr" {
  command = plan

  module {
    source = "./modules/vpc"
  }
  assert {
    condition     = output.public_subnets_cidr[1] == "10.0.3.0/24"
    error_message = "public_subnet2のCIDRは期待値の10.0.3.0/24と一致しません"
  }
}

run "test_private_subnet1_cidr" {
  command = plan

  module {
    source = "./modules/vpc"
  }
  assert {
    condition     = output.private_subnets_cidr[0] == "10.0.2.0/24"
    error_message = "public_subnet1のCIDRは期待値の10.0.2.0/24と一致しません"
  }
}

run "test_private_subnet2_cidr" {
  command = plan

  module {
    source = "./modules/vpc"
  }
  assert {
    condition     = output.private_subnets_cidr[1] == "10.0.4.0/24"
    error_message = "public_subnet2のCIDRは期待値の10.0.4.0/24と一致しません"
  }
}