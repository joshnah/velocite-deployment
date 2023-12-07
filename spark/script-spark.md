En local:
```
minikube  --memory 8192 --cpus 4  --disk-size='20000mb' start

helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

helm install my-release spark-operator/spark-operator --namespace spark-operator --set sparkJobNamespace=default --set serviceAccounts.spark.name=spark --set enableWebhook=true --create-namespace


kubectl apply -f spark/streaming.yaml

kubectl logs -f streaming-driver

kubectl delete sparkapplications.sparkoperator.k8s.io streaming
```


Expose the Spark UI de stream-driver sur le port 4040 pour pouvoir le consulter depuis le navigateur (Expose puis port-forward)