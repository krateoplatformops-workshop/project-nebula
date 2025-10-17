{{/*
Standard labels for the chart.
*/}}
{{- define "project-nebula.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this length.
*/}}
{{- define "project-nebula.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Service Account name.
*/}}
{{- define "project-nebula.serviceAccountName" -}}
{{- if .Values.security.rbac.create -}}
{{- default (printf "%s-sa" (include "project-nebula.fullname" .)) .Values.global.serviceAccountName -}}
{{- else -}}
{{- default "default" .Values.global.serviceAccountName -}}
{{- end -}}
{{- end -}}

{{/*
API Gateway JWT Secret name.
*/}}
{{- define "project-nebula.apiGateway.jwtSecretName" -}}
{{- .Values.apiGateway.secrets.existingSecret | default (printf "%s-api-gateway-jwt" (include "project-nebula.fullname" .)) -}}
{{- end -}}
