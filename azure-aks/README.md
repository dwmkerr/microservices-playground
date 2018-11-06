# azure-aks

Based on docs from: 

- [Microsoft - AKS Quickstart](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough)
- [Microsoft Installing Helm](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm)

To create the cluster, run:

```sh
./setup.sh
```

Check the script for details on the cluster size, Kubernetes version, etc. Once this script has been run, your current `kubectl` will be set to the new AKS cluster.

To delete the cluster, run:

```sh
./teardown.sh
```
