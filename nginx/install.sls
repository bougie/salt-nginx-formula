{% from "nginx/default.yml" import lookup with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('nginx:lookup')) %}

nginx_package:
    pkg.installed:
        - name: {{lookup.package}}
