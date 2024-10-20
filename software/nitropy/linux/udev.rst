Setting Up The udev Rules
=========================

To be able to access your devices without root privileges, nitropy requires the
Nitrokey udev rules. If they are not shipped with your distribution, you can
install the rules manually::

    wget https://raw.githubusercontent.com/Nitrokey/nitrokey-udev-rules/main/41-nitrokey.rules
    sudo mv 41-nitrokey.rules /etc/udev/rules.d/

The legacy rules are also shipped with `libnitrokey <https://github.com/Nitrokey/libnitrokey>`__.


You most likely want to change the owner and the permissions of this file::

    sudo chown root:root /etc/udev/rules.d/41-nitrokey.rules
    sudo chmod 644 /etc/udev/rules.d/41-nitrokey.rules

After installing the rules, you need to reload them::

    sudo udevadm control --reload-rules && sudo udevadm trigger

If you still cannot access your device, try again after rebooting your system.
If you encouter issues, look at this `github comment <https://github.com/Nitrokey/pynitrokey/issues/167#issuecomment-1024921046>`__
for some debugging hints.

Modifying The udev Rules
========================

The downloaded ruleset gives any unprivileged user app the permissions to update and modify all available Nitrokeys. This is a necessary privilege escalation to use the apps without root, but comes with the downside of weakening the protection of your key.

You can modify the ruleset, which requires root access::

    sudoedit /etc/udev/rules.d/41-nitrokey.rules

Here you can comment out blocks or rules that you don't need, like rules for other keys you dont use. Do this by placing ``#`` in front of the each line.

Example::

    # # USB SmartCard Readers
    # ## Crypto Stick 1.2
    # ATTR{idVendor}=="20a0", ATTR{idProduct}=="4107", ENV{ID_SMARTCARD_READER}="1", ENV{ID_SMARTCARD_READER_DRIVER}="gnupg", TAG+="uaccess"

Disabling the udev Rules 
========================

Only do this if you dont want to write anything to the key, inclusing new passkeys or GPG keys. This increases security, for example when using it primarily to verify HEADS.

To disable the rules, and prevent any user app from modifying your key, simply rename the file with the "move" command::

    sudo mv /etc/udev/rules.d/41-nitrokey.rules /etc/udev/rules.d/41-nitrokey.rules.disabled
    sudo udevadm control --reload-rules && sudo udevadm trigger

To enable them again, for example once a firmware update is there, reverse the command::

    sudo mv /etc/udev/rules.d/41-nitrokey.rules.disabled /etc/udev/rules.d/41-nitrokey.rules
    sudo udevadm control --reload-rules && sudo udevadm trigger
