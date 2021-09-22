Nitrokey Reset
--------------

.. include:: ./product_platform_heading.rst

.. contents:: :local:

Factory Reset operation regenerates the secret material stored on the Nitrokey FIDO U2F / Nitrokey FIDO2, which makes it a completely new key logic-side. New owner cannot use it to login to account of the previous one. In case of the FIDO2 Resident Keys the material is erased.

To avoid accidental and malicious reset of the Nitrokey, the required
touch confirmation time for the FIDO2 reset operation is longer and with
a distinct LED behavior (red LED light) than normal operations. To reset
the Nitrokey FIDO2, confirm by touching the touch button for at least 5
seconds until the green or blue LED lights up.

Nitrokey FIDO2 could be reset by:

* pynitrokey tool: ``nitropy fido2 reset`` (requires Administrator rights to execute)
* Google Chrome (not available on Windows): `Manage security keys` - direct link (Chrome only): `chrome://settings/securityKeys`