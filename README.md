# operator-pattern-for-dummies

Simple explanation of the Operator Pattern in Kubernetes

## Resources in Kubernetes

We can simplify accessing the Kubernetes API by using a proxy:

```bash
kubectl proxy
```

We can Obtain a list of the Kubernetes API groups by calling [http://127.0.0.1:8001/apis](http://127.0.0.1:8001/apis).
Note that there is no item representing the Core group in this list.

We can get a list of the resources provided by the Core group via [http://127.0.0.1:8001/api/v1](http://127.0.0.1:8001/api/v1).

### Interacting with the Core API

Service resources can be managed via the Core API. By adding `--v=7`, we can display the headers of the HTTP requests generated by kubectl.

After creating a service like this
```bash
kubectl create service clusterip my-service --tcp=80:80 --v=7
```
we can `GET` the related resource via [http://localhost:8001/api/v1/namespaces/default/services/my-service](http://localhost:8001/api/v1/namespaces/default/services/my-service).

Editing the service can be done like this:
```bash
kubectl edit service my-service --v=7 
```

The service can finally be deleted as follows:
```bash
kubectl delete service my-service --v=7 
```

### Extend the Kubernetes API by Custom Resources

We can extend the Kubernetes API by Custom Resources via creating CustomResourceDefinition objects.

By applying `manifests/crd.yaml`, the Kubernetes API is extended with an endpoint for the XmasService resource:
```bash
kubectl apply -f manifests/crd.yaml --v=7
```

Check [http://127.0.0.1:8001/apis/apiextensions.k8s.io/v1/customresourcedefinitions](http://127.0.0.1:8001/apis/apiextensions.k8s.io/v1/customresourcedefinitions) to view the resource you just created.
The endpoint to the XmasService resource is to be found here: [http://127.0.0.1:8001/apis/deeptalk.deepshore.de/v1/xmasservices](http://127.0.0.1:8001/apis/deeptalk.deepshore.de/v1/xmasservices).

You can now manage the corresponding objects via the new endpoint.

### Deploying an Operator

Creating XmasService objects via the Kubernetes API has practically no effect at this point.
However, we can change this by deploying an operator that translates the corresponding API objects into Christmas web services within the cluster:
```bash
kubectl apply -f manifests/operator.yaml
```

Then we can generate a Christmas web service according to our liking via manifest:
```bash
kubectl apply -f manifests/cr.yaml
```



We can configure the web service via the properties of the spec. For example, we can set the size of the snowflakes via the `snowflakesSize` property:
```bash
kubectl edit xs demo --v=7
```
