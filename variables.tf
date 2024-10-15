variable GOOGLE_CREDENTIALS {
    type = string
}
variable myname {
    type = string
    description = "Name for vm instance"
}
variable mymachine {
    type = string
    description = "Value for machine-type"
}
variable myzone {
    type = string
    description = "Value for zone"
}
variable image {
    type = string
    description = "Value for boot disk image"
}
variable firename {
    type = string
    description = "Name for firewall"
}
variable fireIP {
    type = list(string)
    description = "Value for source_ranges in firewall"
}
variable vpcname {
    type = string
    description = "Name for vpc"
}
variable subname {
    type = string
    description = "Name for subnet"
}
variable subrange {
    type = string
    description = "Value for subnet IP range"
}
variable region {
    type = string
    description = "Value for region"
}
variable port {
    type = list(string)
    description = "Value for firewall port"
    default = []
}
variable protocol{
    type=string
    description = "Value for protocol"
}
variable tags {
    type = list(string)
    description = "Value for target tags"
    default = []
}
