{% from "nginx/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('nginx:lookup')) %}
{% set rawmap = salt['pillar.get']('nginx', rawmap, merge=True) %}

vhosts_available_directory:
    file.directory:
        - name: {{lookup.vhosts_available}}
        - user: {{lookup.web_user}}

vhosts_enabled_directory:
    file.directory:
        - name: {{lookup.vhosts_enabled}}
        - user: {{lookup.web_user}}

{% for vhostname, vhostconfig in rawmap.vhosts.config.items() %}
{{vhostname ~ '_vhost_config'}}:
    file.managed:
        - name: {{lookup.vhosts_available ~ '/' ~ vhostname ~ '.conf'}}
        - source: salt://nginx/files/vhost.conf
        - template: jinja
        - user: root
        - group: wheel
        - mode: 0644
        - require:
            - file: vhosts_available_directory
        - context:
            config: {{vhostconfig|json()}}

{% if vhostname in rawmap.vhosts.managed %}
{{vhostname ~ '_vhost_status'}}:
    file.symlink:
        - name: {{lookup.vhosts_enabled ~ '/' ~ vhostname ~ '.conf'}}
        - target: {{lookup.vhosts_available ~ '/' ~ vhostname ~ '.conf'}}
        - require:
            - file: {{vhostname ~ '_vhost_config'}}
{% else %}
{{vhostname ~ '_vhost_status'}}:
    file.absent:
        - name: {{lookup.vhosts_enabled ~ '/' ~ vhostname ~ '.conf'}}
{% endif %}
{% endfor %}
