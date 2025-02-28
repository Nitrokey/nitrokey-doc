QubesOS
=======

.. contents:: :local:

.. toctree::
   :maxdepth: 1
   :glob:
   :hidden:

   *

.. include:: ../content/shared-index-content1.rst


Getting Started
---------------

After purchase, the passwords are set to a default value and must be
changed by you:

1. Press Enter (“Default Boot”) after booting the system, provided the
   NitroPad has not shown any errors and the Nitrokey is lit green (see
   above).

2. Next, the system will prompt you to enter the passphrase to decrypt
   the hard disk. The passphrase is initially "12345678".

   .. figure:: ./images/QubesDiskPassword.jpg
      :alt: img3

3. The system will then guide you through the process of creating a user
   account. After that you should have successfully booted the system
   and could already use it normally.

4. Open the pre-installed Nitrokey App and change the PINs of your
   Nitrokey as `described here <../change-pins.html>`_.

5. Change the passphrase for the hard disk encryption by searching in the Qubes Menu for "Change Disk Passwort". This passphrase is different from your user acount's passphrase.

   .. figure:: /images/qubes/ChangeDiskPasswordQubes.png
        :alt: Change Password Qubes Image 

6. NitroPads are shipped with the latest installation image by Qubes OS which needs to updated after installation because it does not contain all latest security fixes. To update use the Update Manager as described in the `Qubes Documentation <https://www.qubes-os.org/doc/how-to-update/>`__.

.. note::

   Specifically for NitroPad V54 the Qubes 4.2.3 installation image contains a bug that limits to use the highest screen resoultion only. This is fixed after you update dom0 and reboot. 
   

.. include:: ../content/shared-index-content2.rst


Failed to Start Load Kernel Modules
-----------------------------------

During boot of the system the error "Failed to start Load Kernel Modules" is displayed. `This is a known issue <https://github.com/QubesOS/qubes-issues/issues/2638>`__ which is not critical and can be ignored.
