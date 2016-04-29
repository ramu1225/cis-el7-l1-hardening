#
# Cookbook Name:: sa-hardening
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Fix for "xccdf_org.cisecurity.benchmarks_rule_4.7_Enable_firewalld"
package 'firewalld'

service 'firewalld' do
  supports :status => true
  action [ :enable, :start ]
end
# End fix for "xccdf_org.cisecurity.benchmarks_rule_4.7_Enable_firewalld"

# Start fix for hardening of cronfiles
['/etc/cron.d', '/etc/cron.monthly', '/etc/cron.weekly',
  '/etc/cron.daily', '/etc/cron.hourly'].each do |crondir|
    directory crondir do
      mode '0700'
      owner 'root'
      group 'root'
    end
end

['/etc/crontab', '/etc/anacrontab'].each do |cronfile|
  file cronfile do
    mode '0700'
    owner 'root'
    group 'root'
  end
end
# End fix for hardening of cronfiles

# Start fix for xccdf_org.cisecurity.benchmarks_rule_9.1.2_Verify_Permissions_on_etcpasswd
file '/etc/passwd' do
  mode '0644'
  owner 'root'
  group 'root'
end
# End fix for xccdf_org.cisecurity.benchmarks_rule_9.1.2_Verify_Permissions_on_etcpasswd

# Start fix for xccdf_org.cisecurity.benchmarks_rule_1.5.2_Set_Permissions_on_bootgrub2grub.cfg
file '/boot/grub2/grub.cfg' do
  mode '0600'
  owner 'root'
  group 'root'
end
# End fix for xccdf_org.cisecurity.benchmarks_rule_1.5.2_Set_Permissions_on_bootgrub2grub.cfg

# Start fix for xccdf_org.cisecurity.benchmarks_rule_6.2.1_Set_SSH_Protocol_to_2
replace_or_add "SSH Protocol" do
  path "/etc/ssh/sshd_config"
  pattern "Protocol 1"
  line "Protocol 2"
end
# End fix for xccdf_org.cisecurity.benchmarks_rule_6.2.1_Set_SSH_Protocol_to_2

# Start fix for xccdf_org.cisecurity.benchmarks_rule_6.5_Restrict_Access_to_the_su_Command
replace_or_add "Restrict su Command" do
  path "/etc/pam.d/su"
  pattern ".*pam_wheel.so use_uid"
  line "auth            required        pam_wheel.so use_uid"
end
# End xccdf_org.cisecurity.benchmarks_rule_6.5_Restrict_Access_to_the_su_Command

# Start fix for xccdf_org.cisecurity.benchmarks_rule_6.2.5_Set_SSH_MaxAuthTries_to_4_or_Less
replace_or_add "SSH MaxAuthTries" do
  path "/etc/ssh/sshd_config"
  pattern "MaxAuthTries.*"
  line "MaxAuthTries 4"
end
# End fix for xccdf_org.cisecurity.benchmarks_rule_6.2.5_Set_SSH_MaxAuthTries_to_4_or_Less

# Start fix for xccdf_org.cisecurity.benchmarks_rule_6.2.4_Disable_SSH_X11_Forwarding
replace_or_add "Disable SSH X11 Forwarding" do
  path "/etc/ssh/sshd_config"
  pattern "X11Forwarding.*"
  line "X11Forwarding no"
end
# End fix for xccdf_org.cisecurity.benchmarks_rule_6.2.4_Disable_SSH_X11_Forwarding

# Start fix for xccdf_org.cisecurity.benchmarks_rule_6.2.6_Set_SSH_IgnoreRhosts_to_Yes
replace_or_add "Set SSH IgnoreRhosts to Yes" do
  path "/etc/ssh/sshd_config"
  pattern "IgnoreRhosts.*"
  line "IgnoreRhosts yes"
end
# End fix for xccdf_org.cisecurity.benchmarks_rule_6.2.6_Set_SSH_IgnoreRhosts_to_Yes
