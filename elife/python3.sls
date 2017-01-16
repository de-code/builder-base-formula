# pkgrepo for 3.5+, should already be configured by builder's Salt bootstrap
# officially abandoned, but unofficially being updated
# https://launchpad.net/~fkrull/+archive/ubuntu/deadsnakes/+index?batch=75&direction=backwards&start=75

python-3:
    pkgrepo.managed:
        - humanname: Python 2.7 Updates
        - ppa: fkrull/deadsnakes
        - require:
            - global-python-requisites
        - unless:
            - test -e /etc/apt/sources.list.d/fkrull-deadsnakes-trusty.list
            
    pkg.installed:
        - pkgs:
            - python3 # 3.4
            - python3-dev
            - python3.6
            - python3.6-dev
