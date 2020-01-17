docker build -t arognstad/multi-client:latest -t arognstad/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arognstad/multi-server:latest -t arognstad/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arognstad/multi-worker:latest -t arognstad/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push arognstad/multi-client:latest
docker push arognstad/multi-client:$SHA
docker push arognstad/multi-server:latest
docker push arognstad/multi-server:$SHA
docker push arognstad/multi-worker:latest
docker push arognstad/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arognstad/multi-server:$SHA
kubectl set image deployments/client-deployment client=arognstad/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arognstad/multi-worker:$SHA