# Helm Chart of Apache NIFI Registry

[Apache NIFI Registry](https://nifi.apache.org/registry.html) a subproject of [Apache NiFi](https://nifi.apache.org) is a complementary application that provides a central location for storage and management of shared resources across one or more instances of NiFi and/or MiNiFi.

![](https://nifi.apache.org/assets/images/registry-logo.png?raw=true "NIFI Registry")

This Helm Chart install NIFI Registry into your Kubernetes cluster.

# Install

You must have installed Helm into Kubernetes cluster.


### Add Repository

Firs you need add a new repository to your Helm environment.

```
helm repo add kronops https://kronops.github.io/helm-charts/
```

#### Validation

Validate repo added run command:

```
helm repo list
```

#### Deploy

To install [Apache NIFI Registry](https://nifi.apache.org/registry.html) into your cluster run:

```
helm install --name nifi-registry --namespace nifi -f values.yml kronops/helm-nifi-registry
```
