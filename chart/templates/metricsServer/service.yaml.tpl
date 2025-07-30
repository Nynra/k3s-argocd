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
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
    # Custom annotations
    {{- if .Values.metricsExtension.commonAnnotations }}
    {{- toYaml .Values.metricsExtension.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
      {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    # Custom labels
    {{- if .Values.metricsExtension.commonLabels }}
    {{- toYaml .Values.metricsExtension.commonLabels | nindent 4 }}
    {{- end }}
spec:
  ports:
    - name: metrics
      port: 9003
      targetPort: 9003
  selector:
    app: argocd-metrics-server
{{- end }}
