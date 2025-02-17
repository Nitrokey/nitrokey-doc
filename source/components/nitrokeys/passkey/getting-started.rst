Getting Started
===============

Hardware
--------

TODO Image with focus on touch button

First steps
-----------
The Nitrokey Passkey supports two-factor authentication (2FA) and
passwordless authentication:

-  With **passwordless authentication**, entering a password is replaced
   by logging in with the Nitrokey FIDO2 and a PIN.

-  With **two-factor authentication** (2FA), the Nitrokey FIDO2 is
   checked in addition to the password.

The Nitrokey Passkey can be used with any current browser.

.. important::

   The Nitrokey App can not be used for the Nitrokey Passkey.


Passwordless Authentication
---------------------------

1. Open a web page that supports FIDO2 (for example
   `Google <https://myaccount.google.com/>`__).
2. Log in to the website and go to “Passkeys and security keys” in the security
   settings of your account.
3. Click on Create passkey.
4. Click on Use a different device.
5. Follow the prompts to set a PIN for your Nitrokey Passkey.
6. Touch the button of your Nitrokey Passkey when prompted.
7. Once you have successfully configured the device, you will need to
   activate your Nitrokey Passkey this way each time you log in, after
   entering your PIN.

Two-Factor Authentication (2FA)
-------------------------------

1. Open one of the `websites that support FIDO
   U2F <https://www.dongleauth.com/>`__.
2. Log in to the website and enable two-factor authentication in your
   account settings. (In most cases you will find a link to the
   documentation of the supported web service at
   `dongleauth.com <https://www.dongleauth.com/>`__)
3. Register your Nitrokey Passkey in the account settings by touching the
   button to activate the Nitrokey Passkey. After you have successfully
   configured the device, you must activate the Nitrokey Passkey this way
   each time you log in.

You are now ready to go.

Touch Button And LED Behavior
-----------------------------

The first FIDO operation is automatically accepted within two seconds
after connecting Nitrokey Passkey. In this case touching the touch button
is not required.

Multiple operations can be accepted by a single touch. For this, keep
the touch button touched for up to 10 seconds.


+------------------+-----------------------------+------------+
| LED Color        | Event                       | Comments   |
+==================+=============================+============+
| White (blinking) | waiting for touch event     |            |
+------------------+-----------------------------+------------+
| Teal (constant)  | processing                  |            |
+------------------+-----------------------------+------------+
| Red (Constant)   | Crash                       |            |
+------------------+-----------------------------+------------+



Troubleshooting (Linux)
-----------------------

If the Nitrokey is not detected, proceed the following:

1. Copy this file
   `41-nitrokey.rules <https://www.nitrokey.com/sites/default/files/41-nitrokey.rules>`__
   to ``/etc/udev/rules.d/``. In very rare cases, the system will need
   the `older
   version <https://raw.githubusercontent.com/Nitrokey/libnitrokey/master/data/41-nitrokey_old.rules>`__
   of this file.
2. Restart udev via ``sudo service udev restart`` or ``udevadm control --reload-rules && udevadm trigger`` if you are using Fedora.

