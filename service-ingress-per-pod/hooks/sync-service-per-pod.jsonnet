function(request) {
  local pod = request.object,
  local labelKey = pod.metadata.annotations["sipp-label-key"],
  local ports = pod.metadata.annotations["sipp-ports"],

  // Create a service for each Pod, with a selector on the given label key.
  attachments: [
    {
      apiVersion: "v1",
      kind: "Service",
      metadata: {
        name: pod.metadata.name,
        labels: {app: "sipp"}
      },
      spec: {
        selector: {
          [labelKey]: pod.metadata.name
        },
        ports: [
          {
            local parts = std.split(ports, ":"),
            port: std.parseInt(parts[0]),
            targetPort: std.parseInt(parts[1]),
          }
        ]
      }
    }
  ]
}
