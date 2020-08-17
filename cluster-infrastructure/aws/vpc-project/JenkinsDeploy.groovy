def k8slabel = "jenkins-pipeline-${UUID.randomUUID().toString()}"
def slavePodTemplate = """
      metadata:
        labels:
          k8s-label: ${k8slabel}
        annotations:
          jenkinsjoblabel: ${env.JOB_NAME}-${env.BUILD_NUMBER}
      spec:
        affinity:
          podAntiAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                - key: component
                  operator: In
                  values:
                  - jenkins-jenkins-master
              topologyKey: "kubernetes.io/hostname"
        containers:
        - name: docker
          image: docker:latest
          imagePullPolicy: Always
          command:
          - cat
          tty: true
          volumeMounts:
            - mountPath: /var/run/docker.sock
              name: docker-sock
            - mountPath: /etc/secrets/service-account/
              name: google-service-account
        - name: fuchicorptools
          image: fuchicorp/buildtools
          imagePullPolicy: Always
          command:
          - cat
          tty: true
          volumeMounts:
            - mountPath: /var/run/docker.sock
              name: docker-sock
            - mountPath: /etc/secrets/service-account/
              name: google-service-account
        serviceAccountName: common-service-account
        securityContext:
          runAsUser: 0
          fsGroup: 0
        volumes:
          - name: google-service-account
            secret:
              secretName: google-service-account
          - name: docker-sock
            hostPath:
              path: /var/run/docker.sock
    """

    podTemplate(name: k8slabel, label: k8slabel, yaml: slavePodTemplate) {
      node(k8slabel) {
        properties([
            parameters([
                booleanParam(defaultValue: false, description: 'Do you want to apply changes?', name: 'TERRAFORM_APPLY')
                ])
            ])

        stage("Pull SCM") {
          git branch: 'master', url: 'https://github.com/volodymyr1213/vpc-project-.git'
        }

        stage("Apply/Plan")  {
            container("fuchicorptools") {
                dir("${WORKSPACE}/deployments/terraform") {
                    sh 'terraform init'
                    if("${TERRAFORM_APPLY}" == "true") {
                        sh "terraform apply -auto-approve"
                    }
                    else {
                        sh "terraform plan"
                    }
                }

            }
        }
      }
    }