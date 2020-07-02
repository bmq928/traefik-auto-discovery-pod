function(request) {
  local pod = request.object,
  local labelKey = pod.metadata.annotations["sipp-label-key"],

  // Inject the Pod name as a label with the key requested in the annotation.
  labels: {
    [labelKey]: pod.metadata.name
  }
}