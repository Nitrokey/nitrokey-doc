Nitrokey Passkey FAQ
====================

**Q:** Which Operating Systems are supported?
   Windows, Linux, macOS and BSD. Also FIDO2 is supported on Android and iOS.


**Q:** What can I use the Nitrokey for?
   Second or first factor authentication for services which support Webauthn/Passkey/FIDO2/FIDO U2F. 

**Q:** What happens if I lose my Nitrokey Passkey device?
   When securing accounts using FIDO (two-factor authentication and
   passwordless login), you should configure another factor in your account as
   a backup. Depending on the service this backup factor can be a phone number,
   an app or even a second Nitrokey FIDO2. If you lose a Nitrokey Passkey, you
   can still log in with the second Nitrokey FIDO2 (or with another second
   factor).

**Q:** How large is the storage capacity?
   The Nitrokey FIDO2 doesn't contain storage capability for ordinary data (it can
   only store cryptographic keys and certificates). It can hold over 100 Passkeys/FIDO2 keys.

**Q:** How to use Nitrokey Passkey with Microsoft Entra ID?
   After `disabling Enforce Attestation`_ Nitrokey Passkey is supported by Entra ID out of the box.


.. include:: ../../shared-faqs/hyperlinks.rst.inc 
