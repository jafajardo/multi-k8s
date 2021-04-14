docker build -t josephfajardo/multi-client:latest -t josephfajardo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t josephfajardo/multi-server:latest -t josephfajardo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t josephfajardo/multi-worker:latest -t josephfajardo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push josephfajardo/multi-client:latest
docker push josephfajardo/multi-server:latest
docker push josephfajardo/multi-worker:latest

docker push josephfajardo/multi-client:$SHA
docker push josephfajardo/multi-server:$SHA
docker push josephfajardo/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=josephfajardo/multi-server:$SHA
kubectl set image deployments/client-deployment client=josephfajardo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=josephfajardo/multi-worker:$SHA
