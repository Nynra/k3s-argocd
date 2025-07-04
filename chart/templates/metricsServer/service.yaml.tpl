{{- if .Values.metricsExtension.enabled }}
apiVersion: v1
kind: Service
metadata:
  labels:
    app: argocd-metrics-server
  name: argocd-metrics-server
  # namespace: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
spec:
  ports:
    - name: metrics
      port: 9003
      targetPort: 9003
  selector:
    app: argocd-metrics-server
{{- end }}
