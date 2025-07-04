{{- if .Values.dashboard.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: argocd-ingress
  namespace: {{ .Values.namespace }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`{{ .Values.dashboard.ingressUrl }}`)
      kind: Rule
      # middlewares:
      #   - name: lan-only-ref
      #     # namespace: {{ .Values.traefik.namespace }}
      #     # kind: TraefikService
      services:
        - name: argocd-server
          port: 80
  tls:
    secretName: {{ .Values.dashboard.externalCert.name }}
{{- end }}