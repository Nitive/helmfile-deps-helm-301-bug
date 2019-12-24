rm -f helmfile.lock
helmfile --helm-binary $(pwd)/tmp/helm302 deps
