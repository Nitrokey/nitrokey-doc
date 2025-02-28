Factory Reset Heads 2.0
=======================

.. contents:: :local:

Reasons for resetting to factory settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Your Nitrokey is locked (e.g. due to multiple incorrect PIN entries)

-  You have lost your Nitrokey (in which case you will first need a new one)

-  You have installed an operating system yourself (e.g. after changing the hard disk)

-  Your operating system does not start

.. warning::
   All data on the Nitrokey will be lost if you reset your device. Therefore please backup your data before performing the reset.

Procedure
~~~~~~~~~
1. Connect your Nitrokey to the NitroPad.
2. Turn on the NitroPad.
3. Select “Options”.

   .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/options.jpg
      :alt: heads options menu

4. Select “OEM-Factory Reset /Re-Ownership”.

   .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/reset.jpg
      :alt: reset

5. Confirm Reset with “Continue”.

   .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/confirm.jpg
      :alt: confirm

6. The integrity of your Setup will be tested, deppending on your reason to perform the reset this can fail continue with ok anyways

   .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/confirm-integrity.jpg
      :alt: confirm integrity

7. The following Question can all be answered with the Default. Just hit enter if you only want to reset your device.  

   .. code-block::

      Would you like to change the current LUKS Disk Recovery Key passphrase?
      (Highly recommended if you didn't install the Operating System yourself, so that past provisioned passphrase would not permit to access content.
      Note that without re-encrypting disk, a backuped header could be restored to access encrypted content with old passphrase) [y/N]: N

      Would you like to re-encrypt LUKS encrypted container and generate new Disk Recovery key?
      (Highly recommended if you didn't install the operating system yourself: this would prevent any LUKS backuped header to be restored to access encrypted data) [y/N]: N

      The following security components will be provisioned with defaults or chosen PINs/passwords:

      TPM Ownership password
      GPG Admin PIN
      GPG User PIN

      Would you like to set a single custom password that will be provisioned to previously stated security components? [y/N]: N
      
      Would you like to set distinct PINs/passwords to be provisioned to previously stated security components? [y/N]: N
      
      Would you like to set custom user Information for the GnPG key?[y/N]: N

      Would you like to set custom user information for the GnuPG key? [y/N]: N

      Checking for USB Security Dongle... 

      Detecting and setting boot device... 

      Boot device set to /dev/nvme0n1p2

      Resetting TPM... 

      Resetting GPG Key... 
      (this will take around 3 minuts...)

      Changing default GPG Admin PIN

      Changing default GPG User PIN

      Reading current firmware
      (this will take a minute or two)

      Adding generated key to current firmware and re-flashing...

      Signing boot files and generating checksums

8. It will show the Default GPG PINS and TPM Password

   .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/default-sec.jpg
      :alt: defaults
   
9. Confirm the subsequent restart.

   .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/reboot.jpg
      :alt: reboot

10. After the restart the OTP secret must be created. Confirm the process with Enter.

      .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/otp-sec1.jpg
         :alt: otp secrets generate confirm 1

      .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/otp-sec2.jpg
         :alt: otp secrets generate confirm 2

11. Enter TPM Password (Default: 12345678)

      .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/tpm.jpg
         :alt: tpm password enter

12. Scan QR COde with Phone to inport TOTP Seceret (Optional) and hit Enter 

      .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/totp.jpg
         :alt: qr code totp


13. When prompted, enter the Admin PIN of your Nitrokey (Default: 12345678) and hit Enter

      .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/admin-pin.jpg
         :alt: admin pin nitrokey input

14. You should then reach the Start menu.

      .. figure:: /components/nitropad-nitropc/images/factory-reset-heads2/start-menu.jpg
         :alt: start menu

15. Press Enter to start the “Default Boot”.

.. note::

   If you see the message that no default exists yet, please follow the procedure described in “Troubleshooting: Default Boot Menu”.
