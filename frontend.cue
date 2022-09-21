frontend: {
        type: "component"
        annotations: {}
        labels: {}
        description: "Generic frontend component"
        attributes: workload: definition: {
                apiVersion: "apps/v1"
                kind:       "Deployment"
        }
}
template: {
        output: {
                apiVersion: "apps/v1"
                kind:       "Deployment"
                spec: {
                        selector: matchLabels: app: parameter.name
                        template: {
                                metadata: labels: app: parameter.name
                                spec: containers: [{
                                        name:  parameter.name
                                        image: parameter.image

                                        if parameter["env"] != _|_ {
                                                env: parameter.env
                                        }

                                        ports: [{
                                                containerPort: parameter.port
                                        }]
                                }]
                        }
                }
        }
        // workload can have extra object composition by using 'outputs' keyword
        outputs: service: {
                apiVersion: "v1"
                kind:       "Service"
        metadata: {
            name: parameter.name
            labels: app: parameter.name
        }
                spec: {
                        type: parameter.type
                        selector: app: parameter.name
                        ports: [
                                {
                                        port:       parameter.port
                                        targetPort: parameter.targetPort
                                },
                        ]
                }
        }
        parameter: {
                name: string
                image: string
                type: *"LoadBalancer" | string
                port: *80 | int
                targetPort: int
                env?: [...{
                        name:   string
                        value?: string
                        valueFrom?: secretKeyRef: {
                                name: string
                                key:  string
                        }
                }]
        }
}