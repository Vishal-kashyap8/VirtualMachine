
#locals
/*locals {
  ResourceGroup = "AssignmentRG"
  Location = "East US"
  virtual_network ={
    name = "AppNetwork"
    address_prefixex = ["10.1.0.0/16"]
  }

  subnet_address_prefix = ["10.1.1.0/24", "10.1.2.0/24"]
  subnets = [
    {
    name = "websubnet01"
    address_prefixes = ["10.1.0.0/17"]
    },
    {

        name =  "websubnet02"
        address_prefixes = ["10.1.128.0/17"]
    }
  ]


}**/


#Working Script

locals {
  ResourceGroup = "DevOps1"
  Location = "Central US"
}