Setting up The udev Rules
=========================

To be able to access your devices without root privileges, nitropy and all other Nitrokey Apps require the
Nitrokey udev rules. If they are not shipped with your distribution, you can
install the rules manually::

    wget https://raw.githubusercontent.com/Nitrokey/nitrokey-udev-rules/main/41-nitrokey.rules
    sudo mv 41-nitrokey.rules /etc/udev/rules.d/

The legacy rules are also shipped with `libnitrokey <https://github.com/Nitrokey/libnitrokey>`__.


You most likely want to change the owner and the permissions of this file::

    sudo chown root:root /etc/udev/rules.d/41-nitrokey.rules
    sudo chmod 644 /etc/udev/rules.d/41-nitrokey.rules

On Systems using SElinux (like Fedora, RHEL or Derivatives and CentOS Stream), you may also want to fix the SElinux Contexts. You can use ``ls -Z`` to view them before and after changing them, to verify that you are executing the correct command.::

    cd /etc/udev/rules.d
    ls -Z
    sudo chcon -R system_u:object_r:udev_rules_t:s0 .
    ls -Z

After installing the rules, you need to reload them::

    sudo udevadm control --reload-rules && sudo udevadm trigger

If you still cannot access your device, try again after rebooting your system.
If you encouter issues, look at this `github comment <https://github.com/Nitrokey/pynitrokey/issues/167#issuecomment-1024921046>`__
for some debugging hints.
