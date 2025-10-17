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
    - namespace: {{ .Release.Namespace | quote }}
      server: {{ .Values.destination.server | quote }}
  destinationNamespaces:
    {{- range .Values.bootstrapProject.namespaces }}
    - {{ . | quote }}
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
{{- end }}{{- end }}
