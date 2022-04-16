my-conf-install:
  pkg.installed:
    - pkgs:
      - python3-augeas

#mysettings-conf:
#  augeas.change:
#    - context: /files/etc/mysettings.conf
#    - lens: Simplevars.lns
#    - changes:
#      - set settingone[0] itworking

{% for k, v in pillar.mysettings.items() %}
setting-change-{{k}}:
  file.replace:
    - name: /srv/salt/brltty.conf
    - pattern: '^((?!#).)*({{k | regex_escape }}).*'
    - repl: {{k}}={{v}}
    #- pattern: '^((?!#).)*(\s*{{ k | regex_escape }}\s*=)\s*.*(#\s.*)?'
    #- repl: \1 {{v}}
    - append_if_not_found: True
    - show_changes: True
{% endfor -%}
