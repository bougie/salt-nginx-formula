{% from "nginx/default.yml" import lookup with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('nginx:lookup')) %}

nginx_service:
    service:
        - running
        - name: {{lookup.service}}
