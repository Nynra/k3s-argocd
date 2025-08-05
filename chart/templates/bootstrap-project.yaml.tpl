{{- if .Values.enabled }}{{- if .Values.bootstrapProject.enabled }}
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ .Values.bootstrapProject.name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  sourceRepos:
    {{- range .Values.bootstrapProject.repos }}
    - {{ . | quote }}
    {{- else }}
    - "*"
    {{- end }}
  destinations:
    - namespace: "*"
      server: "*"
  clusterResourceWhitelist:
    - group: "*"
      kind: "*"
{{- end }}{{- end }}
