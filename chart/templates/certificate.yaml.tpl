{{- if .Values.enabled }}{{- if .Values.dashboard.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.dashboard.certName }}
  namespace: {{ .Values.namespace.name }}
  annotations:
    argocd.argoproj.io/sync-wave: "-4"
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
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.dashboard.externalCert.secretStore }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: tls.crt
      remoteRef:
        key: {{ .Values.dashboard.externalCert.secretName | quote }}
        property: tls_crt
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
    - secretKey: tls.key
      remoteRef:
        key: {{ .Values.dashboard.externalCert.secretName | quote }}
        property: tls_key
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
{{- end }}{{- end }}