{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "docker-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "docker-registry.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
To prevent new auto-generation of those values during Chart upgrade
*/}}
{{- define "secret.fullname" -}}
 {{- printf "%s-%s" (include "docker-registry.fullname" .) "secret" -}}
{{- end -}}

{{- define "redis.password" -}}
{{- $secret := (lookup "v1" "Secret" .Release.Namespace (include "secret.fullname" .)) -}}
{{- if $secret -}}
  {{- $secret.data.redisPassword -}}
{{- else -}}
  {{- randAlphaNum 10 | b64enc | quote -}}
{{- end -}}
{{- end -}}

{{- define "haSharedSecret.password" -}}
{{- $secret := (lookup "v1" "Secret" .Release.Namespace (include "secret.fullname" .)) -}}
{{- if $secret -}}
  {{- $secret.data.haSharedSecret -}}
{{- else -}}
  {{- randAlphaNum 16 | b64enc | quote -}}
{{- end -}}
{{- end -}}