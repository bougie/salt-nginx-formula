# Meta-state to fully install nginx.

include:
    - nginx.install
    - nginx.config
    - nginx.vhosts
    - nginx.service

extend:
    nginx_service:
        service:
            - watch:
                - file: nginx_config
                - pkg: nginx_package
            - require:
                - file: nginx_config
    nginx_config:
        file:
            - require:
                - pkg: nginx_package
