Getting Started
===============


Passkeys are a modern way to log into websites and apps without the need for traditional passwords, making it easier and safer for everyone. 
Here’s a simple breakdown of what passkeys are, how they work, and how to use the Nitrokey Passkey.
 
How do Passkeys work?
--------------------- 

Passkeys are a modern form of authentication that replaces passwords. 
First you register your Nitrokey Passkey to a website. This way a secret is stored on your Nitrokey Passkey.
The magic happens when you log in:

When you want to access the service, the website will send a challenge to your device.
If you haven't already done so, you plug in your Nitrokey and authenticate it (often via a button press or PIN). 
Your device uses the private key to respond securely to a challenge from the website, confirming your identity without sending your information across.




First steps
-----------
The Nitrokey Passkey supports two-factor authentication (2FA) and
passwordless authentication:

-  With **passwordless authentication**, entering a password is replaced
   by logging in with the Nitrokey Passkey and a PIN.

-  With **two-factor authentication** (2FA), the Nitrokey Passkey is
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
