NitroPad, NitroPC FAQ
=====================

.. faq:: What is the default hard-disk encryption password?

   The default Nitropad disk encryption password: "12345678". This was change on the 15.01.2024 so if "12345678" is not working try the old default: "PleaseChangeMe"

.. faq:: How to change the hard-disk encryption password from within HEADS?

   This is the prefered way to change the hard-disk encryption password.
   Inside HEADS choose ``Options -> Change LUKS Disk Recovery Key passphrase``
   and follow the instructions.

.. faq:: How to change the hard-disk encryption password from within the OS?

   Using default ``cryptsetup`` tools it is important to note that the right
   key slot is used: ``sudo cryptsetup luksChangeKey --key-slot=0 /dev/nvme0n1p3`` or
   ``sudo cryptsetup luksChangeKey --key-slot=0 /dev/sda3``. In Qubes 4.2 exist also now a GUI tool for that:

      .. figure:: /images/qubes/ChangeDiskPasswordQubes.png
        :alt: Change Password Qubes Image

.. faq:: What is re-ownership / re-encryption and why is it important?

   Changing your hard-disk encryption password does not change the encryption
   itself, just the access to the encryption key. This means that in a situation
   where somebody had phyisical access to the device (e.g., during shipment)
   they may have copied the LUKS header, i.e., the encryption key. Using this
   copy one might decrypt the hard-disk even with a new password being set. 
   This is why the re-ownership wizard proposes to re-encrypt the hard-disk, 
   which reencrypts in place ensuring the previously described scenario 
   cannot be applied.

   
 
