docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA  -f ./client/Dockerfile.dev ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push stephengrider/multi-client:latest
docker push stephengrider/multi-server:latest
docker push stephengrider/multi-worker:latest
docker push stephengrider/multi-client:$SHA
docker push stephengrider/multi-server:$SHA
docker push stephengrider/multi-worker:$SHA

kubect apply -f k8s 
kubect set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubect set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubect set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA