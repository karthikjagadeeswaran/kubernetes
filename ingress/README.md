# Use the ingressController.yaml in Worst Case

    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/cloud/deploy.yaml

# Use helm to deploy the ingress-controller
    helm upgrade --install ingress-nginx ingress-nginx \
    --repo https://kubernetes.github.io/ingress-nginx \
    --namespace ingress-nginx --create-namespace

# Check all pod and services are Working
    for loadbalancer service external ip patching

    kubectl patch svc ingress-nginx-controller -p '{"spec":{"externalIPs":["138.201.248.228"]}}'

# Create Ingress Class
    kubectl apply -f /root/244/182/server-charts/helm-charts/ingress/ingressClass.yaml

# Create Secret For Certificate
     kubectl create secret tls keycloak-tls \
    --key /root/certificates/plantsense.key \
    --cert /root/certificates/plantsense.ai.crt

# Create Ingress
    kubectl apply -f /root/244/182/server-charts/helm-charts/ingress/ingress.yaml

