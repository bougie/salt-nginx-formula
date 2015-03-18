{% from "nginx/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('nginx:lookup')) %}
{% set rawmap = salt['pillar.get']('nginx', rawmap, merge=True) %}

{% do rawmap.server.config.http.include.append(lookup.vhosts_enabled ~ '/*.conf') %}

nginx_config:
    file.managed:
        - name: {{lookup.config_file}}
        - source: salt://nginx/files/nginx.conf
        - template: jinja
        - user: root
        - group: wheel
        - mode: 0644
        - context:
            config: {{rawmap.server.config|json()}}
