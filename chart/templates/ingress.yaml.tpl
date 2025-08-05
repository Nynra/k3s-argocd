{{- if .Values.enabled }}{{- if .Values.dashboard.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: argocd-ingress
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
      {{- toYaml .Values.global.commonLabels | nindent 4 }}
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
    secretName: argocd-dashboard-tls
{{- end }}{{- end }}