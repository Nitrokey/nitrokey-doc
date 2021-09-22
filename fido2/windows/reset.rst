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

Windows 10
~~~~~~~~~~

Make sure you use Windows 10 at least version 2004. Please follow
Windows’ reset wizard.

If the total taken time for execution will be more than 10 seconds, the
Windows OS’ user interface will report failure. Reset operation is
executed on the Nitrokey even after the latter is reported failing, as
long as the user’s touch will be registered before the Nitrokey’s
internal operation timeout (touch confirmation is shown with the blue
color).

Older Versions of Windows 10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In Windows 10 version 1909 or older the Nitrokey has to be reinserted
right before the reset operation is executed. The reset operation has to
be confirmed by touching the touch button twice.

Detailed scenario:

1. Reinsert the Nitrokey right before executing reset operation
2. Start the reset operation in the user interface
3. When the LED blinks white, touch the touch button for 1 second until it turns green.
4. Release the touch
5. When the LED blinks red, touch the touch button for 5 seconds until it turns blue.

Windows 10 on a Virtual Machine
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Please keep in mind Nitrokey has internal timeout for accepting the FIDO
reset operation of 10 seconds since powering up. If the Nitrokey will
connect to a virtual machine later than that, it will return error and
the operation will be aborted.

Other Ways To Reset
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nitrokey FIDO2 could be reset by:

* pynitrokey tool: ``nitropy fido2 reset`` (requires Administrator rights to execute)
* Google Chrome (not available on Windows): `Manage security keys` - direct link (Chrome only): `chrome://settings/securityKeys`