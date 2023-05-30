# Update before use

variable cec {
    default = "ciscolive"
}
variable region {
    default = "us-east1"
}
variable zone {
    default = "us-east1-b"
}


#if you change cidr block make sure you update addresses in python and shell scripts.
variable websubnet1 {
    type = string
    default = "10.120.211.0/24"
}
variable websubnet2 {
    type = string
    default = "10.120.212.0/24"
}
variable appsubnet1 {
    type = string
    default = "10.120.213.0/24"
}
variable appsubnet2 {
    type = string
    default = "10.120.214.0/24"
}
variable dbsubnet1 {
    type = string
    default = "10.120.215.0/24"
}
variable dbsubnet2 {
    type = string
    default = "10.120.216.0/24"
}

#if you change cidr block make sure you update addresses in python and shell scripts.
variable frontendip {
    default = "10.120.211.10"
}
variable checkoutip {
    default = "10.120.213.10"
}
variable adip {
    default = "10.120.213.11"
}
variable recommendationip {
    default = "10.120.213.12"
}
variable paymentip {
    default = "10.120.213.13"
}
variable emailip {
    default = "10.120.213.14"
}
variable productcatalogip {
    default = "10.120.213.15"
}
variable shippingip {
    default = "10.120.213.16"
}
variable currencyip {
    default = "10.120.213.17"
}
variable cartip {
    default = "10.120.213.18"
}
variable redisip {
    default = "10.120.215.10"
}


