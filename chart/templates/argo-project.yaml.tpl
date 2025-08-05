{{- if .Values.enabled }}{{- if .Values.argocdProject.enabled }}
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ .Values.argocdProject.name | quote }}
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
    {{- range .Values.argocdProject.repos }}
    - {{ . | quote }}
    {{- else }}
    - "*"
    {{- end }}
  destinations:
    - namespace: {{ .Release.Namespace | quote }}
      server: "*"
  clusterResourceWhitelist:
    - group: "*"
      kind: "*"
  orphanedResources:
    warn: true
{{- end }}{{- end }}