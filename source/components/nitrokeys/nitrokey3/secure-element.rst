Secure Element SE05x
====================

.. contents:: :local:

The Secure Element `SE050 <https://www.nxp.com/products/SE050>`__ is a tamper-resistant chip by NXP Semiconductors that provides advanced security features. It offers hardware-based security functions including cryptographic operations, secure key storage, and protection against physical and logical attacks. The SE05X Secure Element is certified to Common Criteria EAL 6+ security level and implements algorithms like RSA, ECC, AES, and SHA, making it ideal for the Nitrokey 3.

PIV uses the Secure Element. OpenPGP Card can be configured to use the Secure Element or not in which case a software-only implementation is used. Passwords and FIDO2 don't use the Secure Element but for additional randomness.


Activation/Deactivation for OpenPGP
-----------------------------------
The Secure Element is enabled by default if no cryptographic key in OpenPGP Card and PIV is already saved on the device. 
This is automatically the case after resetting the OpenPGP Card or the whole Nitrokey.

.. warning::
   Manually activating the Secure Element for the OpenPGP Card will delete all existing keys.

To check whether the Secure Element for OpenPGP is activated run:

* nitropy nk3 get-config opcard.use_se050_backend

To enable the Secure Element:

* nitropy nk3 set-config opcard.use_se050_backend true

To disable the Secure Element: 

* nitropy nk3 set-config opcard.use_se050_backend false

Algorithms
----------

+-----------------------------------------+---------------------+------------------------+
| Algorithm                               | With Secure Element | Without Secure Element |
+=========================================+=====================+========================+
| RSA 2048 bit                            | ✓                   | ✓                      |
+-----------------------------------------+---------------------+------------------------+
| RSA 3072 bit                            | ✓                   | ⨯                      |
+-----------------------------------------+---------------------+------------------------+
| RSA 4096 bit                            | ✓                   | ⨯                      |
+-----------------------------------------+---------------------+------------------------+
| AES 128/256 bit                         | ✓                   | ✓                      |
+-----------------------------------------+---------------------+------------------------+
| SHA 256/384/512 bit                     | ✓                   | ✓                      |
+-----------------------------------------+---------------------+------------------------+
| NIST P-256 (secp256r1/prime256v1)       | ✓                   | ✓                      |
+-----------------------------------------+---------------------+------------------------+
| NIST P-384 (secp384r1/prime384v1)       | ✓                   | ⨯                      |
+-----------------------------------------+---------------------+------------------------+
| NIST P-521 (secp521r1/prime521v1)       | ✓                   | ⨯                      |
+-----------------------------------------+---------------------+------------------------+
| Ed25519/Curve25519                      | ✓                   | ✓                      |
+-----------------------------------------+---------------------+------------------------+
| brainpoolP256r1                         | ✓                   | ⨯                      |
+-----------------------------------------+---------------------+------------------------+
| brainpoolP384r1                         | ✓                   | ⨯                      |
+-----------------------------------------+---------------------+------------------------+
| brainpoolP512r1                         | ✓                   | ⨯                      |
+-----------------------------------------+---------------------+------------------------+
| HOTP (RFC 4226)                         | ✓                   | ✓                      |
+-----------------------------------------+---------------------+------------------------+
| TOTP (RFC 6238)                         | ✓                   | ✓                      |
+-----------------------------------------+---------------------+------------------------+
| Physical random number generator (TRNG) | ✓                   | ✓                      |
+-----------------------------------------+---------------------+------------------------+

