apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ .Values.argocdProjectName | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  sourceRepos:
    {{- range .Values.argocdRepos }}
    {{- if .url }}
    - {{ .url | quote }}
    {{- else }}
    - "*"
    {{- end }}
    {{- end }}
  destinations:
    - namespace: {{ .Values.namespace | quote }}
      server: "*"
  clusterResourceWhitelist:
    - group: "*"
      kind: "*"
  orphanedResources:
    warn: true
