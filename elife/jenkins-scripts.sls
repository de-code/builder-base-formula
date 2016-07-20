# Allows jenkins and similar machines to run utilities such as standalone Python scripts
# Requires a jenkins-user-and-group state to be present to declare the jenkins user has been created.
# This can be done either by the jenkins .deb, or manually in the case of a slave.
jenkins-scripts:
    file.recurse:
        - name: /usr/local/jenkins-scripts/
        - user: jenkins
        - source: salt://elife/jenkins-scripts
        - file_mode: 555
        - require:
            - jenkins-user-and-group

slack-channel-hook:
    cmd.run:
        - name: echo 'export SLACK_CHANNEL_HOOK={{ pillar.elife.jenkins.slack.channel_hook }}' > /etc/profile.d/slack-channel-hook.sh
