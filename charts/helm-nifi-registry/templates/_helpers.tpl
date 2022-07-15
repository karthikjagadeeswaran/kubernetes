{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "helm-nifi-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm-nifi-registry.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "helm-nifi-registry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Service Name
*/}}
{{- define "helm-nifi-registry.serviceName" -}}
{{- printf "%s-%s" (include "helm-nifi-registry.fullname" .) "-scv" | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "helm-nifi-registry.labels" -}}
app.kubernetes.io/name: {{ include "helm-nifi-registry.name" . }}
helm.sh/chart: {{ include "helm-nifi-registry.chart" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Persistent Volume Claim name
*/}}
{{- define "helm-nifi-registry.pvcName" -}}
{{- if .Values.persistence.nifiSingleDisk.existingPV }}
{{-   printf "%s-%s" (include "helm-nifi-registry.fullname" .) "-single--pvc" | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- else if .Values.persistence.nifiSingleDisk.dynamic }}
{{-   printf "%s-%s" (include "helm-nifi-registry.fullname" .) "-single--dyn-pvc" | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{-   printf "%s-%s" (include "helm-nifi-registry.fullname" .) "-single--unknown-pvc" | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end -}}
