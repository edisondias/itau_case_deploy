app_name		                    = "ec2-example"
ec2_file                        = "userdata"
# instance_type                   = "m3.medium"

# #ELB
# elb_sg			                    = [""]
# elb_czlb	             		      = ""
# elb_cd			             	      = ""
# elb_internal		        	      = "false"
#
# #ALB
# alb_sg                          = [""]
# alb_idle_timeout                = "60"
# alb_enable_deletion_protection  = ""
# alb_enable_http2                = "true"
# alb_ip_address                  = "ipv4"
# alb_internal                    = "false"
#
# #LC
# lc_sg                           = ["sg-4f53dc2b"]
# lc_file			                    = "userdata"
# lc_associate_public_ip_address  = "true"
# lc_enable_monitoring            = "true"
# lc_placement_tenancy            = "default"
# lc_ebs_optimized                = "false"


terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
}
