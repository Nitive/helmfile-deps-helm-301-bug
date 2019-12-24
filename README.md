# `helmfile deps` is broken for helm 3.0.2

Steps to reproduce:

1. Install helm 3.0.1 and helm 3.0.2 with `./download-helm.sh linux-amd64` or `./download-helm.sh darwin-amd64`
2. Run `helmfile deps` with different version of helm

Everything is fine with helm 3.0.1
```
$ ./test-helm301.sh

Adding repo stable https://kubernetes-charts.storage.googleapis.com
"stable" has been added to your repositories

Updating repo
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "csssr" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈ Happy Helming!⎈

Updating dependency /var/folders/k_/361cq75j2sgf6dxm6625422m0000gn/T/041766349
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "csssr" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 1 charts
Downloading docker-registry from repo https://kubernetes-charts.storage.googleapis.com
Deleting outdated charts
```

Error with helm 3.0.2
```
$ ./test-helm302.sh

Adding repo stable https://kubernetes-charts.storage.googleapis.com
"stable" has been added to your repositories

Updating repo
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "csssr" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈ Happy Helming!⎈

Updating dependency /var/folders/k_/361cq75j2sgf6dxm6625422m0000gn/T/793059155
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "csssr" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 1 charts
Downloading docker-registry from repo https://kubernetes-charts.storage.googleapis.com
Deleting outdated charts

in ./helmfile.yaml: unable to update deps: unable to resolve 1 deps: open /var/folders/k_/361cq75j2sgf6dxm6625422m0000gn/T/793059155/Chart.lock: no such file or directory
```

It happens because helmfile tries to access Chart.lock which is not there in version 3.0.2.
The behavior was changes in https://github.com/helm/helm/pull/7009 and now charts without `apiVersion: v2` are treated as helm 2 carts and generate requirements.lock instead

