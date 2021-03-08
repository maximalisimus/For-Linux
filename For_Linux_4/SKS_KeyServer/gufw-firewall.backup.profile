[fwBasic]
status = enabled
incoming = allow
outgoing = allow
routed = disabled

[Rule0]
ufw_rule = 11371/tcp ALLOW IN Anywhere
description = HTTP
command = /usr/sbin/ufw allow in proto tcp from any to any port 11371
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 11371/tcp
iface = 
routed = 
logging = 

[Rule1]
ufw_rule = 11371/tcp ALLOW OUT Anywhere (out)
description = HTTP
command = /usr/sbin/ufw allow out proto tcp from any to any port 11371
policy = allow
direction = out
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 11371/tcp
iface = 
routed = 
logging = 

[Rule2]
ufw_rule = 11371/tcp ALLOW OUT Anywhere on enp0s3 (out)
description = HTTP
command = /usr/sbin/ufw allow out on enp0s3 proto tcp from any to any port 11371
policy = allow
direction = out
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 11371/tcp
iface = enp0s3
routed = 
logging = 

[Rule3]
ufw_rule = 11371/tcp on enp0s3 ALLOW IN Anywhere
description = HTTP
command = /usr/sbin/ufw allow in on enp0s3 proto tcp from any to any port 11371
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 11371/tcp
iface = enp0s3
routed = 
logging = 

[Rule4]
ufw_rule = 80/tcp ALLOW IN Anywhere
description = HTTP
command = /usr/sbin/ufw allow in proto tcp from any to any port 80
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 80/tcp
iface = 
routed = 
logging = 

[Rule5]
ufw_rule = 80/tcp ALLOW OUT Anywhere (out)
description = HTTP
command = /usr/sbin/ufw allow out proto tcp from any to any port 80
policy = allow
direction = out
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 80/tcp
iface = 
routed = 
logging = 

[Rule6]
ufw_rule = 11371/tcp (v6) ALLOW IN Anywhere (v6)
description = HTTP
command = /usr/sbin/ufw allow in proto tcp from any to any port 11371
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 11371/tcp
iface = 
routed = 
logging = 

[Rule7]
ufw_rule = 11371/tcp (v6) ALLOW OUT Anywhere (v6) (out)
description = HTTP
command = /usr/sbin/ufw allow out proto tcp from any to any port 11371
policy = allow
direction = out
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 11371/tcp
iface = 
routed = 
logging = 

[Rule8]
ufw_rule = 11371/tcp (v6) ALLOW OUT Anywhere (v6) on enp0s3 (out)
description = HTTP
command = /usr/sbin/ufw allow out on enp0s3 proto tcp from any to any port 11371
policy = allow
direction = out
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 11371/tcp
iface = enp0s3
routed = 
logging = 

[Rule9]
ufw_rule = 11371/tcp (v6) on enp0s3 ALLOW IN Anywhere (v6)
description = HTTP
command = /usr/sbin/ufw allow in on enp0s3 proto tcp from any to any port 11371
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 11371/tcp
iface = enp0s3
routed = 
logging = 

[Rule10]
ufw_rule = 80/tcp (v6) ALLOW IN Anywhere (v6)
description = HTTP
command = /usr/sbin/ufw allow in proto tcp from any to any port 80
policy = allow
direction = in
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 80/tcp
iface = 
routed = 
logging = 

[Rule11]
ufw_rule = 80/tcp (v6) ALLOW OUT Anywhere (v6) (out)
description = HTTP
command = /usr/sbin/ufw allow out proto tcp from any to any port 80
policy = allow
direction = out
protocol = 
from_ip = 
from_port = 
to_ip = 
to_port = 80/tcp
iface = 
routed = 
logging = 