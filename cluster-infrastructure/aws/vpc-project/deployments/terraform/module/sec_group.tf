resource "aws_security_group" "web_sec_group" { 
name = "web_sec_group" 
description = "Allows ports 22 80 and 443" 
vpc_id  = "${aws_vpc.vpc_eks.id}"



ingress { 
description = "TLS from VPC" 
from_port = 80 
to_port = 80 
protocol = "tcp" 
cidr_blocks = ["0.0.0.0/0"] 
} 

ingress { 
description = "TLS from VPC" 
from_port = 22 
to_port = 22 
protocol = "tcp" 
cidr_blocks = ["0.0.0.0/0"] 
} 

ingress { 
description = "TLS from VPC" 
from_port = 443
to_port = 443
protocol = "tcp" 
cidr_blocks = ["0.0.0.0/0"] 
} 

egress { 
from_port = 0 
to_port = 0 
protocol = "-1" 
cidr_blocks = ["0.0.0.0/0"] 

} 
tags = { 
Name = "web-sg" 
} 
} 

resource "aws_security_group" "mysql_sec_group" { 
name = "mysql_sec_group" 
description = "Allows ports 3306 and 22" 
vpc_id  =  "${aws_vpc.vpc_eks.id}"



ingress { 
description = "TLS from VPC" 
from_port = 22 
to_port = 22 
protocol = "tcp" 
cidr_blocks = ["0.0.0.0/0"] 
} 

ingress { 
description = "TLS from VPC" 
from_port = 3306
to_port = 3306
protocol = "tcp" 
cidr_blocks = ["0.0.0.0/0"] 
} 

egress { 
from_port = 0 
to_port = 0 
protocol = "-1" 
cidr_blocks = ["0.0.0.0/0"] 

} 
tags = { 
Name = "mysql-sg" 
} 
} 
