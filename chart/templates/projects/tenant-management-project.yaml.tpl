{{- if .Values.enabled }}{{- if .Values.tenantManagementProject.enabled }}
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ .Values.tenantManagementProject.name | quote }}
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
    {{- range .Values.tenantManagementProject.repos }}
    - {{ . | quote }}
    {{- else }}
    - "*"
    {{- end }}
  destinations:
    - namespace: "*"
      server: {{ .Values.destination.server | quote }}
  clusterResourceWhitelist:
    - group: "*"
      kind: "*"
  {{- if .Values.tenantManagementProject.warnOrphanedResources }}
  orphanedResources:
    warn: true
  {{- end }}
{{- end }}{{- end }}
