
Troubleshooting
===============




Nitrokey is not detected
------------------------

Windows
-------

macOS
----- 


Linux
-----

If the Nitrokey is not detected, proceed the following:

1. Copy this file
   `41-nitrokey.rules <https://www.nitrokey.com/sites/default/files/41-nitrokey.rules>`__
   to ``/etc/udev/rules.d/``. In very rare cases, the system will need
   the `older
   version <https://raw.githubusercontent.com/Nitrokey/libnitrokey/master/data/41-nitrokey_old.rules>`__
   of this file.
2. Restart udev via ``sudo service udev restart`` or ``udevadm control --reload-rules && udevadm trigger`` if you are using Fedora.


