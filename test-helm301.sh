rm -f helmfile.lock
helmfile --helm-binary $(pwd)/tmp/helm301 deps
