{{- if .Values.metricsExtension.enabled }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-metrics-server-configmap
  # namespace: {{ .Values.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
data:
  config.json: |
    {
    "prometheus": {
      "applications": [
        {
          "name": "default",
          "default": true,
          "dashboards": [
            {
              "groupKind": "pod",
              "tabs": ["Golden Signal"],
              "rows": [
                    {
                  "name": "pod",
                  "title": "Pods",
                  "tab": "Golden Signal",
                  "graphs": [
                    {
                      "name": "pod_cpu_line",
                      "title": "CPU",
                      "description": "",
                      "graphType": "line",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_cpu_usage_seconds_total{pod=~\"{{.name}}\", image!=\"\", container!=\"POD\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_cpu_pie",
                      "title": "CPU Avg",
                      "description": "",
                      "graphType": "pie",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_cpu_usage_seconds_total{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_memory_line",
                      "title": "Memory",
                      "description": "",
                      "graphType": "line",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_memory_usage_bytes{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_memory_pie",
                      "title": "Mem Avg",
                      "description": "",
                      "graphType": "pie",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_memory_usage_bytes{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    }
                  ]
                },
                {
                  "name": "container",
                  "title": "Containers",
                  "tab": "Golden Signal",
                  "graphs": [
                    {
                      "name": "container_cpu_line",
                      "title": "CPU",
                      "description": "",
                      "graphType": "line",
                      "metricName": "container",
                      "queryExpression": "sum(rate(container_cpu_usage_seconds_total{pod=~\"{{.name}}\", image!=\"\", container!=\"POD\", container!=\"\", container_name!=\"POD\"}[5m])) by (container)"
                    },
                    {
                      "name": "container_cpu_pie",
                      "title": "CPU Avg",
                      "description": "",
                      "graphType": "pie",
                      "metricName": "container",
                      "queryExpression": "sum(rate(container_cpu_usage_seconds_total{pod=~\"{{.name}}\", image!=\"\",container!=\"POD\", container!=\"\", container_name!=\"POD\"}[5m])) by (container)"
                    },
                    {
                      "name": "container_memory_line",
                      "title": "Memory",
                      "description": "",
                      "graphType": "line",
                      "metricName": "container",
                      "queryExpression": "sum(rate(container_memory_usage_bytes{pod=~\"{{.name}}\", image!=\"\", container!=\"POD\", container!=\"\", container_name!=\"POD\"}[5m])) by (container)"
                    },
                    {
                      "name": "container_memory_pie",
                      "title": "Mem Avg",
                      "description": "",
                      "graphType": "pie",
                      "metricName": "container",
                      "queryExpression": "sum(rate(container_memory_usage_bytes{pod=~\"{{.name}}\", image!=\"\", container!=\"POD\", container!=\"\", container_name!=\"POD\"}[5m])) by (container)"
                    }
                  ]
                }
              ]
            },
            {
              "groupKind": "deployment",
              "tabs": ["Golden Signal"],
              "rows": [
                 {
                   "name": "httplatency",
                   "title": "HTTP Latency",
                   "tab": "Golden Signal",
                   "graphs": [
                     {
                       "name": "http_200_latency",
                       "title": "Latency",
                       "description": "",
                       "graphType": "line",
                       "metricName": "pod_template_hash",
                       "queryExpression": "sum(rate(http_server_requests_seconds_sum {namespace=\"{{.namespace}}\", status=\"200\"} [1m])) by (pod_template_hash)"
                     }
                   ]
                 },
                 {
                   "name": "httperrortate",
                   "title": "HTTP Error Rate",
                   "tab": "Golden Signal",
                   "graphs": [
                     {
                       "name": "http_error_rate_500",
                       "title": "HTTP Error 500",
                       "description": "",
                       "graphType": "line",
                       "metricName": "pod_template_hash",
                       "queryExpression": "sum(rate(http_server_requests_seconds_count {namespace=\"{{.namespace}}\", status=\"500\"} [1m])) by (pod_template_hash)"
                     },
                     {
                       "name": "http_error_rate_400",
                       "title": "HTTP Error 400",
                       "description": "",
                       "graphType": "line",
                       "metricName": "pod_template_hash",
                       "queryExpression": "sum(rate(http_server_requests_seconds_count {namespace=\"{{.namespace}}\", status=\"404\"} [1m])) by (pod_template_hash)"
                     }
                   ]
                 },
                 {
                   "name": "httptraffic",
                   "title": "HTTP Traffic",
                   "tab": "Golden Signal",
                   "graphs": [
                     {
                       "name": "http_traffic",
                       "title": "Traffic",
                       "description": "",
                       "graphType": "line",
                       "metricName": "pod_template_hash",
                       "queryExpression": "sum(rate(http_server_requests_seconds_count {namespace=\"{{.namespace}}\"} [1m])) by (pod_template_hash)"
                     }
                   ]
                 },
                {
                  "name": "pod",
                  "title": "Pods",
                  "tab": "Golden Signal",
                  "graphs": [
                    {
                      "name": "pod_cpu_line",
                      "title": "CPU",
                      "description": "",
                      "graphType": "line",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_cpu_usage_seconds_total{pod=~\"{{.name}}\", image!=\"\", container!=\"POD\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_cpu_pie",
                      "title": "CPU Avg",
                      "description": "",
                      "graphType": "pie",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_cpu_usage_seconds_total{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_memory_line",
                      "title": "Memory",
                      "description": "",
                      "graphType": "line",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_memory_usage_bytes{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_memory_pie",
                      "title": "Mem Avg",
                      "description": "",
                      "graphType": "pie",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_memory_usage_bytes{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    }
                  ]
                }
              ]
            },
            {
              "groupKind": "rollout",
              "tabs": ["Golden Signal"],
              "rows": [
                {
                  "name": "httplatency",
                  "title": "HTTP Latency",
                  "tab": "Golden Signal",
                  "graphs": [
                    {
                      "name": "http_200_latency",
                      "title": "Latency",
                      "description": "",
                      "graphType": "line",
                      "metricName": "rollout_template_hash",
                      "queryExpression": "sum(rate(http_server_requests_seconds_sum {namespace=\"{{.namespace}}\", status=\"200\"} [1m])) by (rollout_template_hash)"
                    }
                  ]
                },
                {
                  "name": "httperrortate",
                  "title": "HTTP Error Rate",
                  "tab": "Golden Signal",
                  "graphs": [
                    {
                      "name": "http_error_rate_500",
                      "title": "HTTP Error 500",
                      "description": "",
                      "graphType": "line",
                      "metricName": "rollout_template_hash",
                      "queryExpression": "sum(rate(http_server_requests_seconds_count {namespace=\"{{.namespace}}\", status=\"500\"} [1m])) by (rollout_template_hash)"
                    },
                    {
                      "name": "http_error_rate_400",
                      "title": "HTTP Error 400",
                      "description": "",
                      "graphType": "line",
                      "metricName": "rollout_template_hash",
                      "queryExpression": "sum(rate(http_server_requests_seconds_count {namespace=\"{{.namespace}}\", status=\"404\"} [1m])) by (rollout_template_hash)"
                    }
                  ]
                },
                {
                  "name": "httptraffic",
                  "title": "HTTP Traffic",
                  "tab": "Golden Signal",
                  "graphs": [
                    {
                      "name": "http_traffic",
                      "title": "Traffic",
                      "description": "",
                      "graphType": "line",
                      "metricName": "rollout_template_hash",
                      "queryExpression": "sum(rate(http_server_requests_seconds_count {namespace=\"{{.namespace}}\"} [1m])) by (rollout_template_hash)"
                    }
                  ]
                },
                {
                  "name": "pod",
                  "title": "Pods",
                  "tab": "Golden Signal",
                  "graphs": [
                    {
                      "name": "pod_cpu_line",
                      "title": "CPU",
                      "description": "",
                      "graphType": "line",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_cpu_usage_seconds_total{pod=~\"{{.name}}\", image!=\"\", container!=\"POD\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_cpu_pie",
                      "title": "CPU Avg",
                      "description": "",
                      "graphType": "pie",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_cpu_usage_seconds_total{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_memory_line",
                      "title": "Memory",
                      "description": "",
                      "graphType": "line",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_memory_usage_bytes{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    },
                    {
                      "name": "pod_memory_pie",
                      "title": "Mem Avg",
                      "description": "",
                      "graphType": "pie",
                      "metricName": "pod",
                      "queryExpression": "sum(rate(container_memory_usage_bytes{pod=~\"{{.name}}\", container!=\"POD\", image!=\"\", container!=\"\", container_name!=\"POD\"}[5m])) by (pod)"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ],
      "provider":
      {
        "Name": "default",
        "default": true,
        "address": {{ .Values.metricsExtension.prometheusAddress | quote }},
      }
    }
    }
{{- end }}