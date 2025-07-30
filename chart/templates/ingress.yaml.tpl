{{- if .Values.enabled }}{{- if .Values.dashboard.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: argocd-ingress
  namespace: {{ .Values.namespace.name }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
    # Custom annotations
    {{- if .Values.dashboard.commonAnnotations }}
    {{- toYaml .Values.dashboard.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
      {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    # Custom labels
    {{- if .Values.dashboard.commonLabels }}
    {{- toYaml .Values.dashboard.commonLabels | nindent 4 }}
    {{- end }}
spec:
  entryPoints:
    - {{ .Values.dashboard.entrypoint }}
  routes:
    - match: Host(`{{ .Values.dashboard.ingressUrl }}`)
      kind: Rule
      services:
        - name: argocd-server
          port: 443
  tls:
    secretName: {{ .Values.dashboard.certName }}
{{- end }}{{- end }}