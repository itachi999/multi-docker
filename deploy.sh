docker build -t gantihk/multi-client:latest -t gantihk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gantihk/multi-server:latest -t gantihk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gantihk/multi-worker:latest -t gantihk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gantihk/multi-client:latest
docker push gantihk/multi-server:latest
docker push gantihk/multi-worker:latest

docker push gantihk/multi-client:$SHA
docker push gantihk/multi-server:$SHA
docker push gantihk/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployments server=gantihk/multi-server:$SHA
kubectl set image deployments/client-deployments client=gantihk/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=gantihk/multi-worker:$SHA
