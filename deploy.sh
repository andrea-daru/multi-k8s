docker build -t andreadaru/multi-client:latest -t andreadaru/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andreadaru/multi-server:latest -t andreadaru/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andreadaru/multi-worker:latest -t andreadaru/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push andreadaru/multi-client --all-tags
docker push andreadaru/multi-server --all-tags
docker push andreadaru/multi-worker --all-tags
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=andreadaru/multi-client:$SHA
kubectl set image deployments/server-deployment server=andreadaru/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=andreadaru/multi-worker:$SHA