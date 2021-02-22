pipeline {
  agent {
    kubernetes {
      yaml """
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:v1.5.0-debug
    imagePullPolicy: Always
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
      - name: docker-config
        mountPath: /kaniko/.docker
  volumes:
  - name: docker-config
    projected:
      sources:
      - secret:
          name: dockerhub
          items:
            - key: .dockerconfigjson
              path: config.json
"""
    }
  }

  stages {
    stage('Build with Kaniko') {
      environment {
        PATH = "/busybox:/kaniko:$PATH"
      }

      options {
          ansiColor('xterm')
      }

      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          sh 'executor --context `pwd` --verbosity debug --destination ryecarrigan/jenkins-kaniko-example:build-${BUILD_NUMBER}'
        }
      }
    }
  }
}
