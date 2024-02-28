{{/*
Compute the fullname of the release.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "saral-backend.fullname" -}}
{{- if .Release.Name | hasPrefix .Chart.Name -}}
    {{.Release.Name}}
{{- else -}}
    {{ printf "%s-%s" .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end -}}

