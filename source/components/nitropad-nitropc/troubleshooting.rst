Troubleshooting
===============

.. contents:: :local:


Here you will find a collection of common issues. 



Starting in recovery shell
--------------------------

If your OS doesn’t boot as shown below, please execute the following
steps:

.. code-block:: bash

   +++ Found verified kexec boot params 
   gpg: verify signatures failed: Unknown system error 
   Invalid signature on kexec boot params 
   !!!!! Failed default boot 
   New value of PCR[4]: XXXXXXXXXXXXXXXXXXXXXXXXXXXXX 
   !!!!!Starting recovery shell 
   /boot # 

1. Restart your Laptop and go to Options. 

   .. figure:: /components/nitropad-nitropc/images/boot-menu.jpg
      :alt: img1

2. Select “Update Checksums and sign all files on /boot”. 

   .. figure:: /components/nitropad-nitropc/images/options.jpg
      :alt: img2

3. After that, please follow `these instructions <system-update.html>`_ from step 3 onwards.

NitroPad doesn’t start
----------------------

If the laptop does not start and only flashes briefly when switched on, please try the following
steps:

1. Try a hard reboot:
   Remove the power supply and battery and press and hold the power button for 20 seconds.
   Then reconnect the power supply and battery and start.

2. If this did not work:
   Remove the battery or start only with the power supply connected.
   
3. You could also try removing the RAMs and reinserting them.

Invalid Code
------------

Each boot the code is generated on the NitroPad and the Nitrokey, if its
connected. It is allowed to run 10 boots without loosing the
synchronization between the devices, after which the bad code signal is
shown, regardless of the rest of the system being in a correct state. If
you are sure the system was not beign tampered with (e.g. the NitroPad
was booted more than 10 times without the Nitrokey), you can safely
reset the system’s warning.

Please connect the Nitrokey and execute the following from the main boot
screen:

1. Options
2. TPM/TOTP/HOTP Options
3. Generate new TOTP/HOTP secret

and follow the on-screen guide. After that the secret and counter should
be both reset to a new value.
