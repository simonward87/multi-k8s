docker build -t simonward1987/multi-client:latest -t simonward1987/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t simonward1987/multi-server:latest -t simonward1987/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t simonward1987/multi-worker:latest -t simonward1987/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push simonward1987/multi-client:latest
docker push simonward1987/multi-server:latest
docker push simonward1987/multi-worker:latest

docker push simonward1987/multi-client:$SHA
docker push simonward1987/multi-server:$SHA
docker push simonward1987/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=simonward1987/multi-server:$SHA
kubectl set image deployments/client-deployment client=simonward1987/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=simonward1987/multi-worker:$SHA