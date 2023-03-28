export VERSION=$(git rev-parse HEAD | cut -c1-7)
#make build
#make test

export NEW_IMAGE="gitopsbook/sample-app:${VERSION}"
#docker build -t ${NEW_IMAGE} .
#docker push ${NEW_IMAGE}

git clone https://github.com/blockoio/devops-sample-deployment.git
cd manifest/deployment

kubectl patch \
  --local \
  -o yaml \
  -f deployment.yaml \
  -p "spec:
        template:
          spec:
            containers:
            - name: sample-app
              image: ${NEW_IMAGE}" \
  > /tmp/newdeployment.yaml
mv /tmp/newdeployment.yaml deployment.yaml

git commit deployment.yaml -m "Update sample-app image to ${NEW_IMAGE}"
git push

