apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ .Values.bootstrapProjectName | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  sourceRepos:
    {{- range .Values.bootstrapRepos }}
    {{- if .url }}
    - {{ .url | quote }}
    {{- else }}
    - "*"
    {{- end }}
    {{- end }}
  destinations:
    - namespace: "*"
      server: "*"
  clusterResourceWhitelist:
    - group: "*"
      kind: "*"
  orphanedResources:
    warn: false
