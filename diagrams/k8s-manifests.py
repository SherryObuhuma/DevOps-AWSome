# from diagrams import Cluster, Diagram
# from diagrams.k8s.compute import Deployment, Pod, ReplicaSet, Job, Cronjob, DaemonSet, StatefulSet
# from diagrams.k8s.network import Service, Ingress, Endpoint
# from diagrams.k8s.storage import PersistentVolume, PersistentVolumeClaim, StorageClass, Volume
# from diagrams.k8s.podconfig import ConfigMap, Secret
# from diagrams.k8s.rbac import ServiceAccount, Role, RoleBinding, ClusterRole, ClusterRoleBinding, User
# from diagrams.k8s.clusterconfig import HPA, LimitRange, Quota
# from diagrams.k8s.group import Namespace
# from diagrams.k8s.controlplane import APIServer, ControllerManager, Scheduler, Kubelet
# from diagrams.k8s.infra import Master, Node, ETCD
# from diagrams.k8s.ecosystem import Helm
# from diagrams.k8s.others import CRD

# with Diagram("Kubernetes Components Relationships", show=False, direction="TB"):
    
#     # Users and External Access
#     user = User("User/Developer")
#     helm = Helm("Helm")
    
#     with Cluster("Control Plane"):
#         api_server = APIServer("API Server")
#         controller_mgr = ControllerManager("Controller Manager")
#         scheduler = Scheduler("Scheduler")
#         etcd = ETCD("etcd")
#         master = Master("Master Node")
        
#         # Control plane relationships
#         api_server - etcd
#         api_server - controller_mgr
#         api_server - scheduler
    
#     with Cluster("Worker Nodes"):
#         with Cluster("Node 1"):
#             kubelet1 = Kubelet("Kubelet")
#             node1 = Node("Worker Node 1")
            
#         with Cluster("Node 2"):
#             kubelet2 = Kubelet("Kubelet")
#             node2 = Node("Worker Node 2")
    
#     with Cluster("Namespace: Production"):
#         # RBAC Components
#         with Cluster("RBAC"):
#             service_account = ServiceAccount("ServiceAccount")
#             role = Role("Role")
#             role_binding = RoleBinding("RoleBinding")
#             cluster_role = ClusterRole("ClusterRole")
#             cluster_role_binding = ClusterRoleBinding("ClusterRoleBinding")
        
#         # Configuration
#         with Cluster("Configuration"):
#             config_map = ConfigMap("ConfigMap")
#             secret = Secret("Secret")
        
#         # Storage
#         with Cluster("Storage"):
#             storage_class = StorageClass("StorageClass")
#             pv = PersistentVolume("PersistentVolume")
#             pvc = PersistentVolumeClaim("PVC")
#             volume = Volume("Volume")
        
#         # Workloads
#         with Cluster("Workloads"):
#             deployment = Deployment("Deployment")
#             replica_set = ReplicaSet("ReplicaSet")
#             pods = [Pod("Pod 1"), Pod("Pod 2"), Pod("Pod 3")]
#             stateful_set = StatefulSet("StatefulSet")
#             daemon_set = DaemonSet("DaemonSet")
#             job = Job("Job")
#             cronjob = Cronjob("CronJob")
        
#         # Network
#         with Cluster("Networking"):
#             service = Service("Service")
#             ingress = Ingress("Ingress")
#             endpoint = Endpoint("Endpoint")
        
#         # Cluster Configuration
#         with Cluster("Cluster Config"):
#             hpa = HPA("HorizontalPodAutoscaler")
#             limit_range = LimitRange("LimitRange")
#             quota = Quota("ResourceQuota")
        
#         # Custom Resources
#         crd = CRD("CustomResourceDefinition")
    
#     # Define relationships
    
#     # User interactions
#     user >> helm
#     user >> api_server
#     helm >> api_server
    
#     # Control plane to worker nodes
#     api_server >> kubelet1
#     api_server >> kubelet2
#     scheduler >> kubelet1
#     scheduler >> kubelet2
    
#     # RBAC relationships
#     role_binding >> role
#     role_binding >> service_account
#     cluster_role_binding >> cluster_role
#     cluster_role_binding >> service_account
    
#     # Workload relationships
#     deployment >> replica_set
#     replica_set >> pods
#     stateful_set >> pods
#     daemon_set >> pods
#     cronjob >> job
#     job >> pods
    
#     # Pod configuration
#     pods >> config_map
#     pods >> secret
#     pods >> service_account
#     pods >> volume
    
#     # Storage relationships
#     storage_class >> pv
#     pv >> pvc
#     pvc >> volume
    
#     # Network relationships
#     service >> pods
#     service >> endpoint
#     ingress >> service
    
#     # Cluster config relationships
#     hpa >> deployment
#     limit_range >> pods
#     quota >> pods
    
#     # Control plane manages everything
#     controller_mgr >> deployment
#     controller_mgr >> replica_set
#     controller_mgr >> stateful_set
#     controller_mgr >> daemon_set
#     controller_mgr >> service
#     controller_mgr >> pvc
    
#     # Scheduler places pods
#     scheduler >> pods
    
#     # Kubelet manages pods on nodes
#     kubelet1 >> pods
#     kubelet2 >> pods


from diagrams import Cluster, Diagram
from diagrams.k8s.compute import Deployment, Pod, ReplicaSet, StatefulSet
from diagrams.k8s.network import Service, Ingress
from diagrams.k8s.storage import PersistentVolumeClaim, Volume
from diagrams.k8s.podconfig import ConfigMap, Secret
from diagrams.k8s.rbac import ServiceAccount
from diagrams.k8s.clusterconfig import HPA
from diagrams.k8s.group import Namespace
from diagrams.onprem.client import Users

with Diagram("K8s Application Manifests Flow", show=False, direction="LR"):
    
    users = Users("External Users")
    
    with Cluster("Namespace: my-app"):
        
        # External access layer
        ingress = Ingress("Ingress\n(my-app-ingress)")
        
        # Service layer
        frontend_svc = Service("Frontend Service\n(LoadBalancer)")
        backend_svc = Service("Backend Service\n(ClusterIP)")
        db_svc = Service("Database Service\n(Headless)")
        
        # Application layer
        with Cluster("Frontend"):
            frontend_deploy = Deployment("Frontend\nDeployment")
            frontend_rs = ReplicaSet("Frontend\nReplicaSet")
            frontend_pods = [
                Pod("Frontend\nPod 1"),
                Pod("Frontend\nPod 2")
            ]
            frontend_hpa = HPA("Frontend HPA")
        
        with Cluster("Backend API"):
            backend_deploy = Deployment("Backend\nDeployment")
            backend_rs = ReplicaSet("Backend\nReplicaSet")
            backend_pods = [
                Pod("Backend\nPod 1"),
                Pod("Backend\nPod 2"),
                Pod("Backend\nPod 3")
            ]
            backend_hpa = HPA("Backend HPA")
        
        with Cluster("Database"):
            db_statefulset = StatefulSet("Database\nStatefulSet")
            db_pods = [
                Pod("DB Pod\nmaster"),
                Pod("DB Pod\nreplica")
            ]
        
        # Configuration layer
        with Cluster("Configuration"):
            app_config = ConfigMap("App ConfigMap\n(database urls, etc)")
            app_secrets = Secret("App Secrets\n(passwords, tokens)")
            db_config = ConfigMap("DB ConfigMap\n(db settings)")
            db_secrets = Secret("DB Secrets\n(root password)")
        
        # Storage layer
        with Cluster("Storage"):
            db_pvc = PersistentVolumeClaim("Database PVC")
            db_volume = Volume("Database Volume")
        
        # RBAC
        app_sa = ServiceAccount("App ServiceAccount")
    
    # Traffic flow
    users >> ingress
    ingress >> frontend_svc
    frontend_svc >> frontend_pods
    frontend_pods >> backend_svc
    backend_svc >> backend_pods
    backend_pods >> db_svc
    db_svc >> db_pods
    
    # Deployment relationships
    frontend_deploy >> frontend_rs
    frontend_rs >> frontend_pods
    backend_deploy >> backend_rs
    backend_rs >> backend_pods
    db_statefulset >> db_pods
    
    # HPA relationships
    frontend_hpa >> frontend_deploy
    backend_hpa >> backend_deploy
    
    # Configuration relationships
    frontend_pods >> app_config
    frontend_pods >> app_secrets
    backend_pods >> app_config
    backend_pods >> app_secrets
    db_pods >> db_config
    db_pods >> db_secrets
    
    # Storage relationships
    db_pods >> db_volume
    db_volume >> db_pvc
    
    # RBAC relationships
    frontend_pods >> app_sa
    backend_pods >> app_sa