
Troubleshooting
===============

General
-------

On WebAuthn.io you can check various high-level functionalities, while webautn.bin.coffee provides good developer level details (technical) details.

Check LED 


"nitropy nkpk test"

Windows
-------

Device manager

macOS
----- 

Cmdline: system_profiler SPUSBDataType | grep Nitrokey
GUI: System Report > USB


lsusb 
Linux
-----

lsusb

If the Nitrokey is not detected, proceed the following:

1. Copy this file
   `41-nitrokey.rules <https://www.nitrokey.com/sites/default/files/41-nitrokey.rules>`__
   to ``/etc/udev/rules.d/``. In very rare cases, the system will need
   the `older
   version <https://raw.githubusercontent.com/Nitrokey/libnitrokey/master/data/41-nitrokey_old.rules>`__
   of this file.
2. Restart udev via ``sudo service udev restart`` or ``udevadm control --reload-rules && udevadm trigger`` if you are using Fedora.





i

