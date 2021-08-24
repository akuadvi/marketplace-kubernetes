#!/bin/sh

set -e

################################################################################
# repo
################################################################################
helm repo add stable https://charts.helm.sh/stable
helm repo update > /dev/null

################################################################################
# chart
################################################################################
STACK="sawo"
CHART="sawo/sawo"
CHART_VERSION="1.0.0"
NAMESPACE="sawo"

if [ -z "${MP_KUBERNETES}" ]; then
  # use local version of values.yml
  ROOT_DIR=$(git rev-parse --show-toplevel)
  values="$ROOT_DIR/stacks/sawo/values.yml"
else
  # use github hosted master version of values.yml
  values="https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/sawo/values.yml"
fi

helm upgrade "$STACK" "$CHART" \
  --atomic \
  --create-namespace \
  --install \
  --namespace "$NAMESPACE" \
  --values "$values" \
  --version "$CHART_VERSION"