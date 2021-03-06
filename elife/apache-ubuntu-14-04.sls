{% set wwwuser = pillar.elife.webserver %}
{% set user = pillar.elife.deploy_user %}

include:
    - .certificates

apache2:
    pkg:
        - installed
    
    file.managed:
        - name: /etc/apache2/apache2.conf
        - source: salt://elife/config/etc-apache2.4-apache2.conf
        - require:
            - pkg: apache2

enable-common-modules:
    cmd.run:
        - name: a2enmod rewrite expires ssl
        - require:
            - pkg: apache2

disable-default-apache-site:
    cmd.run:
        - name: a2dissite 000-default
        - require:
            - pkg: apache2

add-deploy-user-to-apache-group:
    cmd.run:
        - name: usermod -a -G {{ wwwuser.username }} {{ user.username }}
        - require:
            - pkg: apache2
        - unless:
            - groups {{ user.username }} | grep {{ wwwuser.username }}
            
redirect-apache-http-to-https:
    file.managed:
        - name: /etc/apache2/sites-available/unencrypted-redirect.conf
        - source: salt://elife/config/etc-apache2-sites-available-unencrypted-redirect.conf
        - template: jinja
        - require:
            - pkg: apache2
