# FIDO2 with Linux

The Nitrokey FIDO2 supports two-factor authentication (2FA) and passwordless authentication:
- With **passwordless authentication**, entering a password is replaced by logging in with the Nitrokey FIDO2 and a PIN.
- With **two-factor authentication** (2FA), the Nitrokey FIDO2 is checked in addition to the password.

The Nitrokey FIDO2 can be used with any current browser.

::: tip IMPORTANT
The Nitrokey App can not be used for the Nitrokey FIDO2.
:::


## Passwordless authentication

1. Open a web page that supports FIDO2 (currently only [Microsoft](https://www.microsoft.com)).
2. Log in to the website and go to "Set up security key" in the security settings of your account.
3. Now you need to set a PIN for your Nitrokey FIDO2.
4. Touch the button of your Nitrokey FIDO2 when prompted.
5. Once you have successfully configured the device, you will need to activate your Nitrokey FIDO2 this way each time you log in, after entering your PIN.


## Two-Factor Authentication (2FA)

1. Open one of the [websites that support FIDO U2F](https://www.dongleauth.info/).
2. Log in to the website and enable two-factor authentication in your account settings. (In most cases you will find a link to the documentation of the supported web service at [dongleauth.info](https://www.dongleauth.info/))
3. Register your Nitrokey FIDO2 in the account settings by touching the button to activate the Nitrokey FIDO2. After you have successfully configured the device, you must activate the Nitrokey FIDO2 this way each time you log in.

Checkout the [various use cases and supported applications](https://www.nitrokey.com/documentation/applications#p:nitrokey-fido2-u2f&os:all).

::: tip NOTE
Google only accepts the Chrome browser for registering the Nitrokey FIDO2 Logging in works fine with Firefox though.
:::


## Touch Button and LED Behavior

The first FIDO operation is automatically accepted within two seconds after connecting Nitrokey FIDO2. In this case touching the touch button is not required.

Multiple operations can be accepted by a single touch. For this, keep the touch button touched for up to 10 seconds.

To avoid accidental and malicious reset of the Nitrokey, the required touch confirmation time for the FIDO2 reset operation is longer and with a distinct LED behavior (red LED light) than normal operations. To reset the Nitrokey FIDO2, confirm by touching the touch button for at least 5 seconds until the green or blue LED lights up.

| LED Color                    | Event                                                                   | Time Period                                                               | Comments                                                                                                                                                                                                                                          |
|------------------------------|-------------------------------------------------------------------------|---------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Any \(blinking\)             | Awaiting for touch                                                      | Until touch is confirmed or timed out                                     |                                                                                                                                                                                                                                                   |
| Any \(blinking faster\)      | Touch detected, counting seconds                                        | Until touch is confirmed or timed out                                     |                                                                                                                                                                                                                                                   |
| White \(blinks\)              | Touch request for FIDO registration or authentication operation      |                                                                           | Requires 1 second touch to complete; timeout is usually about 30 seconds                                                                                                                                                                                                               |
|  Yellow \(blinks\)            | Touch request for configuration operation                             |                                                                           | Requires 5 seconds touch to complete; e.g. used for activating firmware update mode                                                                                                                                                                                                              |
| Red \(blinks\)                | Touch request for reset operation                                     | Available only during the very first 10 seconds after Nitrokey is powered | Requires 5 seconds touch to complete; e.g. used for FIDO2 reset operation                                                                                                                                                                                                              |
| Green \(constant\)           | Touch accepted, Nitrokey is active and accepting further FIDO2 operations | After touch was registered, 10 seconds timeout                            | For the FIDO registration or authentication operations after a confirmation Nitrokey enters into "activation" mode, auto\-accepting any following mentioned operations until touch button is released, but not longer than 10 seconds                               |
| Blue \(constant\)            | Touch consumed \- accepted and used up by the operation                 | Until touch is released                                                   | Touch consumption here means, that without releasing the touch button, and touching again the Nitrokey will not confirm any new operations                                                                                                          |
| White <br/> \(single blink\) | Nitrokey ready to work                                                    | 0\.5 seconds after powering up                                            |                                                                                                                                                                                                                                                   |
| - \(no LED signal\)            | Nitrokey is idle                              |  |  |
| - \(no LED signal\)            | Auto\-accept single FIDO registration or authentication operation                              | Within first 2 seconds after powering up                                        | Nitrokey is automatically accepting any single FIDO registration or authentication operation upon insertion event \- the latter is treated as an equivalent of the touch button registration signal \(user presence\); the configuration/reset operations are not accepted |
| All colors                   | Nitrokey is in Firmware Update mode                                       | Active until firmware update operation is successful, or until reinsertion | If the firmware update fails, the Nitrokey will stay in the this mode until the firmware is written correctly                                                                                           |


## Troubleshooting

If the Nitrokey is not detected, proceed the following:

1. Copy this file [41-nitrokey.rules](https://www.nitrokey.com/sites/default/files/41-nitrokey.rules) to ```/etc/udev/rules.d/```. In very rare cases, the system will need the [older version](https://raw.githubusercontent.com/Nitrokey/libnitrokey/master/data/41-nitrokey_old.rules) of this file.
2. Restart udev via ```sudo service udev restart```.
