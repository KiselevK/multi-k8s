docker build -t kilimanjaroo/multi-client:latest -t kilimanjaroo/multi-client:$SHA ./client/Dockerfile ./client
docker build -t kilimanjaroo/multi-server:latest -t kilimanjaroo/multi-server:$SHA ./server/Dockerfile ./server
docker build -t kilimanjaroo/multi-worker:latest -t kilimanjaroo/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push kilimanjaroo/multi-client:latest
docker push kilimanjaroo/multi-server:latest
docker push kilimanjaroo/multi-worker:latest
docker push kilimanjaroo/multi-client:$SHA
docker push kilimanjaroo/multi-server:$SHA
docker push kilimanjaroo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=kilimanjaroo/multi-server:$SHA
kubectl set image deployment/server-deployment server=kilimanjaroo/multi-client:$SHA
kubectl set image deployment/server-deployment server=kilimanjaroo/multi-worker:$SHA