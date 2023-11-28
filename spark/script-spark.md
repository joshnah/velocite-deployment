helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

helm install my-release spark-operator/spark-operator --namespace spark-operator --set sparkJobNamespace=default --set serviceAccounts.spark.name=spark --set enableWebhook=true --create-namespace

eval $(minikube docker-env)

docker build -t producer -f Dockerfile_producer . 


kubectl apply -f spark/streaming.yaml
kubectl logs -f streaming-driver

kubectl delete sparkapplications.sparkoperator.k8s.io streaming
