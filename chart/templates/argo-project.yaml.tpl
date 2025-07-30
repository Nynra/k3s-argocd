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
    # Custom annotations
    {{- if .Values.argocdProject.commonAnnotations }}
    {{- toYaml .Values.argocdProject.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
      {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    # Custom labels
    {{- if .Values.argocdProject.commonLabels }}
    {{- toYaml .Values.argocdProject.commonLabels | nindent 4 }}
    {{- end }}
spec:
  sourceRepos:
    {{- range .Values.argocdProject.repos }}
    - {{ . | quote }}
    {{- else }}
    - "*"
    {{- end }}
  destinations:
    - namespace: {{ .Values.namespace.name | quote }}
      server: "*"
  clusterResourceWhitelist:
    - group: "*"
      kind: "*"
  orphanedResources:
    warn: true
{{- end }}{{- end }}