#!/bin/bash
kubectl delete -f manifests/cr.yaml
kubectl delete -f manifests/operator.yaml
kubectl delete -f manifests/crd.yaml
kubectl delete service my-service
