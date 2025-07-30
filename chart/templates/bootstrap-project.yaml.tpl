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
    # Custom annotations
    {{- if .Values.bootstrapProject.commonAnnotations }}
    {{- toYaml .Values.bootstrapProject.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
      {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    # Custom labels
    {{- if .Values.bootstrapProject.commonLabels }}
    {{- toYaml .Values.bootstrapProject.commonLabels | nindent 4 }}
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
