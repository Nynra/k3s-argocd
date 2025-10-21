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
      server: {{ .Values.destination.server | quote }}
  clusterResourceWhitelist:
    {{- range .Values.argocdProject.clusterResourceWhitelist }}
    - group: {{ .group | quote }}
      kind: {{ .kind | quote }}
    {{- end }}
  namespaceResourceWhitelist:
    {{- range .Values.argocdProject.namespaceResourceWhitelist }}
    - group: {{ .group | quote }}
      kind: {{ .kind | quote }}
    {{- end }}
  {{- if .Values.bootstrapProject.warnOrphanedResources }}
  # Warn about  orphaned resources
  orphanedResources:
    warn: true
  {{- end }}
  # The project can only deploy resources to clusters scoped to this project
  permitOnlyProjectScopedClusters: false
  # This project only allows applications in the argocd namespace
  # sourceNamespaces:
  #   - {{ .Release.Namespace | quote }}
{{- end }}{{- end }}