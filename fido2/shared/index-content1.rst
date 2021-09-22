.. contents:: :local:

.. toctree::
   :maxdepth: 1
   :glob:
   :hidden:

   *

The Nitrokey FIDO2 supports two-factor authentication (2FA) and
passwordless authentication:

-  With **passwordless authentication**, entering a password is replaced
   by logging in with the Nitrokey FIDO2 and a PIN.

-  With **two-factor authentication** (2FA), the Nitrokey FIDO2 is
   checked in addition to the password.

The Nitrokey FIDO2 can be used with any current browser.

.. important::

   The Nitrokey App can not be used for the Nitrokey FIDO2.

.. tip::

   `Check online <https://update.nitrokey.com/>`__ if your Nitrokey
   FIDO2 has the latest firmware installed.

Passwordless authentication
---------------------------

1. Open a web page that supports FIDO2 (currently only
   `Microsoft <https://www.microsoft.com>`__).
2. Log in to the website and go to “Set up security key” in the security
   settings of your account.
3. Now you need to set a PIN for your Nitrokey FIDO2.
4. Touch the button of your Nitrokey FIDO2 when prompted.
5. Once you have successfully configured the device, you will need to
   activate your Nitrokey FIDO2 this way each time you log in, after
   entering your PIN.

Two-Factor Authentication (2FA)
-------------------------------

1. Open one of the `websites that support FIDO
   U2F <https://www.dongleauth.com/>`__.
2. Log in to the website and enable two-factor authentication in your
   account settings. (In most cases you will find a link to the
   documentation of the supported web service at
   `dongleauth.com <https://www.dongleauth.com/>`__)
3. Register your Nitrokey FIDO2 in the account settings by touching the
   button to activate the Nitrokey FIDO2. After you have successfully
   configured the device, you must activate the Nitrokey FIDO2 this way
   each time you log in.

Checkout the `various use cases and supported
applications <https://www.nitrokey.com/documentation/applications#p:nitrokey-fido-u2f>`__.


Touch Button and LED Behavior
-----------------------------

The first FIDO operation is automatically accepted within two seconds
after connecting Nitrokey FIDO2. In this case touching the touch button
is not required.

Multiple operations can be accepted by a single touch. For this, keep
the touch button touched for up to 10 seconds.

To avoid accidental and malicious reset of the Nitrokey, the required
touch confirmation time for the FIDO2 reset operation is longer and with
a distinct LED behavior (red LED light) than normal operations. To reset
the Nitrokey FIDO2, confirm by touching the touch button for at least 5
seconds until the green or blue LED lights up.

+-----------------+-----------------+-----------------+-----------------+
| LED Color       | Event           | Time Period     | Comments        |
+=================+=================+=================+=================+
| Any (blinking)  | Awaiting for    | Until touch is  |                 |
|                 | touch           | confirmed or    |                 |
|                 |                 | timed out       |                 |
+-----------------+-----------------+-----------------+-----------------+
| Any (blinking   | Touch detected, | Until touch is  |                 |
| faster)         | counting        | confirmed or    |                 |
|                 | seconds         | timed out       |                 |
+-----------------+-----------------+-----------------+-----------------+
| White (blinks)  | Touch request   |                 | Requires 1      |
|                 | for FIDO        |                 | second touch to |
|                 | registration or |                 | complete;       |
|                 | authentication  |                 | timeout is      |
|                 | operation       |                 | usually about   |
|                 |                 |                 | 30 seconds      |
+-----------------+-----------------+-----------------+-----------------+
| Yellow (blinks) | Touch request   |                 | Requires 5      |
|                 | for             |                 | seconds touch   |
|                 | configuration   |                 | to complete;    |
|                 | operation       |                 | e.g. used for   |
|                 |                 |                 | activating      |
|                 |                 |                 | firmware update |
|                 |                 |                 | mode            |
+-----------------+-----------------+-----------------+-----------------+
| Red (blinks)    | Touch request   | Available only  | Requires 5      |
|                 | for reset       | during the very | seconds touch   |
|                 | operation       | first 10        | to complete;    |
|                 |                 | seconds after   | e.g. used for   |
|                 |                 | Nitrokey is     | FIDO2 reset     |
|                 |                 | powered         | operation       |
+-----------------+-----------------+-----------------+-----------------+
| Green           | Touch accepted, | After touch was | For the FIDO    |
| (constant)      | Nitrokey is     | registered, 10  | registration or |
|                 | active and      | seconds timeout | authentication  |
|                 | accepting       |                 | operations      |
|                 | further FIDO2   |                 | after a         |
|                 | operations      |                 | confirmation    |
|                 |                 |                 | Nitrokey enters |
|                 |                 |                 | into            |
|                 |                 |                 | “activation”    |
|                 |                 |                 | mode,           |
|                 |                 |                 | auto-accepting  |
|                 |                 |                 | any following   |
|                 |                 |                 | mentioned       |
|                 |                 |                 | operations      |
|                 |                 |                 | until touch     |
|                 |                 |                 | button is       |
|                 |                 |                 | released, but   |
|                 |                 |                 | not longer than |
|                 |                 |                 | 10 seconds      |
+-----------------+-----------------+-----------------+-----------------+
| Blue (constant) | Touch consumed  | Until touch is  | Touch           |
|                 | - accepted and  | released        | consumption     |
|                 | used up by the  |                 | here means,     |
|                 | operation       |                 | that without    |
|                 |                 |                 | releasing the   |
|                 |                 |                 | touch button,   |
|                 |                 |                 | and touching    |
|                 |                 |                 | again the       |
|                 |                 |                 | Nitrokey will   |
|                 |                 |                 | not confirm any |
|                 |                 |                 | new operations  |
+-----------------+-----------------+-----------------+-----------------+
| White (single   | Nitrokey ready  | 0.5 seconds     |                 |
| blink)          | to work         | after powering  |                 |
|                 |                 | up              |                 |
+-----------------+-----------------+-----------------+-----------------+
| (no LED signal) | Nitrokey is     |                 |                 |
|                 | idle            |                 |                 |
|                 |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| (no LED signal) | Auto-accept     | Within first 2  | Nitrokey is     |
|                 | single FIDO     | seconds after   | automatically   |
|                 | registration or | powering up     | accepting any   |
|                 | authentication  |                 | single FIDO     |
|                 | operation       |                 | registration or |
|                 |                 |                 | authentication  |
|                 |                 |                 | operation upon  |
|                 |                 |                 | insertion event |
|                 |                 |                 | - the latter is |
|                 |                 |                 | treated as an   |
|                 |                 |                 | equivalent of   |
|                 |                 |                 | the touch       |
|                 |                 |                 | button          |
|                 |                 |                 | registration    |
|                 |                 |                 | signal (user    |
|                 |                 |                 | presence); the  |
|                 |                 |                 | conf            |
|                 |                 |                 | iguration/reset |
|                 |                 |                 | operations are  |
|                 |                 |                 | not accepted    |
+-----------------+-----------------+-----------------+-----------------+
| All colors      | Nitrokey is in  | Active until    | If the firmware |
|                 | Firmware Update | firmware update | update fails,   |
|                 | mode            | operation is    | the Nitrokey    |
|                 |                 | successful, or  | will stay in    |
|                 |                 | until           | the this mode   |
|                 |                 | reinsertion     | until the       |
|                 |                 |                 | firmware is     |
|                 |                 |                 | written         |
|                 |                 |                 | correctly       |
+-----------------+-----------------+-----------------+-----------------+