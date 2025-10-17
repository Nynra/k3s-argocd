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
    {{- end }}
  destinations:
    {{- range .Values.tenantManagementProject.namespaces }}
    - namespace: {{ . | quote }}
      server: {{ .Values.destination.server | quote }}
    {{- end }}
  clusterResourceWhitelist:
    {{- range .Values.tenantManagementProject.clusterResourceWhitelist }}
    - group: {{ .group | quote }}
      kind: {{ .kind | quote }}
    {{- end }}
  {{- if .Values.tenantManagementProject.warnOrphanedResources }}
  namespaceResourceWhitelist:
    {{ range .Values.tenantManagementProject.namespaceResourceWhitelist }}
    - group: {{ .group | quote }}
      kind: {{ .kind | quote }}
    {{ end }}
  orphanedResources:
    warn: true
  {{- end }}
  permitOnlyProjectScopedClusters: true
{{- end }}{{- end }}
