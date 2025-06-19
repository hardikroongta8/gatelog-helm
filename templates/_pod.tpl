{{/*
Reusable Pod for Deployment
*/}}

{{- define "gatelog.serverPodSpec" -}}
containers:
  - name: {{ .Chart.Name }}
    image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
    ports:
      - containerPort: {{ .Values.container.port }}
    envFrom:
      - configMapRef:
          name: {{ include "gatelog.fullname" . }}
    env:
      - name: DATABASE_URI
        value: "mongodb://{{ .Release.Name }}-mongodb:27017/gatelog-db"  
{{- end -}}


{{- define "gatelog.dbPodSpec" -}}
containers:
  - name: {{ .Chart.Name }}-mongodb
    image: "{{ .Values.statefulSet.repository }}:{{ .Values.statefulSet.tag }}"
    ports:
    - containerPort: 27017
    volumeMounts:
      - name: {{ (index .Values.volumeMounts 0).name }}
        mountPath: {{ (index .Values.volumeMounts 0).mountPath }}
{{- end -}}