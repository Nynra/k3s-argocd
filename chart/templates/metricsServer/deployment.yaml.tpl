{{- if .Values.metricsExtension.enabled }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: argocd-metrics-server
  # namespace: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
spec:
  selector:
    matchLabels:
      app: argocd-metrics-server
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: argocd-metrics-server
    spec:
      containers:
        - image: quay.io/argoprojlabs/argocd-extension-metrics:latest
          imagePullPolicy: IfNotPresent
          args:
            - "-enableTLS=false"
          name: argocd-metrics-server
          ports:
            - containerPort: 9003
              name: metrics
              protocol: TCP
          resources:
            requests:
              cpu: 100m
              memory: 100Mi
          volumeMounts:
            - name: config-volume
              mountPath: /app/config.json
              subPath: config.json
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: kubernetes.io/arch
                    operator: In
                    values:
                      - amd64
      volumes:
        - name: config-volume
          configMap:
            name: argocd-metrics-server-configmap
{{- end }}