from diagrams import Cluster, Diagram
from diagrams.aws.network import VPC, PublicSubnet, PrivateSubnet, InternetGateway, NATGateway, RouteTable, ELB
from diagrams.aws.compute import ElasticKubernetesService, Fargate, EC2Instance
from diagrams.onprem.network import Nginx
from diagrams.onprem.monitoring import Grafana
from diagrams.onprem.compute import Server
from diagrams.onprem.gitops import ArgoCD
from diagrams.onprem.client import Users
from diagrams.k8s.compute import Pod

with Diagram("AWS EKS Infrastructure with Helm & ArgoCD", show=False, direction="TB"):
    users = Users("Internet Users")
    
    with Cluster("AWS VPC"):
        igw = InternetGateway("Internet Gateway")
        
        with Cluster("Public Subnets (2)"):
            pub_subnet1 = PublicSubnet("Public Subnet 1")
            pub_subnet2 = PublicSubnet("Public Subnet 2")
            nat_gw = NATGateway("NAT Gateway\n(with Elastic IP)")
            route_table_pub = RouteTable("Public Route Table")
        
        with Cluster("Private Subnets (2)"):
            priv_subnet1 = PrivateSubnet("Private Subnet 1")
            priv_subnet2 = PrivateSubnet("Private Subnet 2")
            
            with Cluster("EKS Cluster"):
                eks = ElasticKubernetesService("EKS Control Plane")
                
                with Cluster("Fargate Profile"):
                    fargate = Fargate("Fargate")
                    fargate_pods = [
                        Pod("Fargate Pod 1"),
                        Pod("Fargate Pod 2")
                    ]
                
                with Cluster("Node Groups"):
                    worker_nodes = [
                        EC2Instance("Worker Node 1"),
                        EC2Instance("Worker Node 2")
                    ]
                
                with Cluster("Helm Deployed Applications"):
                    lb = ELB("Load Balancer Service")
                    
                    # Applications deployed via Helm
                    react_app = Nginx("React App")
                    grafana = Grafana("Grafana")
                    app3 = Server("Application 3")
                    
                    # ArgoCD for GitOps
                    argocd = ArgoCD("ArgoCD\n(Helm Chart)")
    
    # Define the connections
    users >> igw
    igw >> route_table_pub
    route_table_pub >> pub_subnet1
    route_table_pub >> pub_subnet2
    
    pub_subnet1 >> nat_gw
    nat_gw >> priv_subnet1
    nat_gw >> priv_subnet2
    
    priv_subnet1 >> eks
    priv_subnet2 >> eks
    
    eks >> fargate
    fargate >> fargate_pods
    eks >> worker_nodes
    
    # Applications flow
    igw >> lb
    lb >> react_app
    lb >> grafana
    lb >> app3
    
    # ArgoCD tracking GitHub
    argocd >> react_app  # Represents GitOps deployment
    
    # Local kubectl connection (represented by connection to EKS)
    users >> eks  # Represents kubectl access