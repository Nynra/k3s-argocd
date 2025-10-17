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
    {{- end }}
  destinations:
    {{- range .Values.bootstrapProject.namespaces }}
    - namespace: {{ . | quote }}
      server: {{ $.Values.destination.server | quote }}
    {{- end }}
  clusterResourceWhitelist:
    {{- range .Values.bootstrapProject.clusterResourceWhitelist }}
    - group: {{ .group | quote }}
      kind: {{ .kind | quote }}
    {{- end }}
  namespaceResourceWhitelist:
    {{ range .Values.bootstrapProject.namespaceResourceWhitelist }}
    - group: {{ .group | quote }}
      kind: {{ .kind | quote }}
    {{ end }}
  {{- if .Values.bootstrapProject.warnOrphanedResources }}
  orphanedResources:
    warn: true
  {{- end }}
  # The project can only deploy resources to clusters scoped to this project
  permitOnlyProjectScopedClusters: true
  # This project only allows applications in the argocd namespace
  sourceNamespaces:
    - {{ .Release.Namespace | quote }}
{{- end }}{{- end }}
