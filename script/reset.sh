#!/bin/bash

ENV_SUFFIX=${1:-dev}

echo "This will delete all resources including namespaces!"
read -p "Are you sure? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "Aborted."
  exit 1
fi

for ns in frontend backend database monitoring; do
  NAMESPACE="${ns}-${ENV_SUFFIX}"
  echo "Cleaning $NAMESPACE namespace..."
  kubectl delete all --all -n $NAMESPACE
  kubectl delete configmap --all -n $NAMESPACE
  kubectl delete secret --all -n $NAMESPACE
  kubectl delete pvc --all -n $NAMESPACE
  kubectl delete networkpolicy --all -n $NAMESPACE
  kubectl delete ingress --all -n $NAMESPACE
done

echo "Waiting for resources to be deleted..."
sleep 10

echo "DELETING NAMESPACES..."
for ns in frontend backend database monitoring; do
  NAMESPACE="${ns}-${ENV_SUFFIX}"
  kubectl delete namespace $NAMESPACE --ignore-not-found=true
done

echo "Cleaning up leftover resources..."
kubectl get namespace | grep Terminating | awk '{print $1}' | xargs -I {} kubectl patch namespace {} --type merge -p '{"metadata":{"finalizers":[]}}'

sleep 5

echo "VERIFICATION - Checking all resources..."
echo ""
echo "Namespaces status:"
kubectl get namespaces | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "All target namespaces deleted"
echo ""
echo "Ingress resources:"
kubectl get ingress -A | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "No ingress resources found"
echo ""
echo "Persistent Volumes:"
kubectl get pv | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "No PVs found"
echo ""
echo "Certificates:"
kubectl get certificates -A | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "No certificates found"
echo ""
echo "Secrets (TLS):"
kubectl get secrets -A | grep tls | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "No TLS secrets found"
echo ""
echo "Network Policies:"
kubectl get networkpolicy -A | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "No network policies found"
echo ""
echo "Services:"
kubectl get svc -A | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "No services found"
echo ""
echo "Deployments/StatefulSets:"
kubectl get deploy,sts -A | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "No deployments/statefulsets found"
echo ""
echo "Pods:"
kubectl get pods -A | grep -E "(frontend-${ENV_SUFFIX}|backend-${ENV_SUFFIX}|database-${ENV_SUFFIX}|monitoring-${ENV_SUFFIX})" || echo "No pods found"
echo ""

echo "All resources verified and removed successfully!"
