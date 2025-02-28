Firmware Update
===============

.. contents:: :local:

This guide describes how to update the Heads firmware of the NitroPad.

These instructions are relevant in the following cases:

-  You want to update the Heads firmware.

-  You have already performed an OEM factory reset, but the TPM counter
   has not been reset.

Preparation
~~~~~~~~~~~

1. Connect your NitroPad to a power plug and load its battery to over
   70%

2. Download the `latest firmware <https://github.com/Nitrokey/heads/releases/latest>`__ and store it on a USB drive. For the:

   - NitroPad T430: ``firmware-nitropad-t430-[version].npf`` 
   - NitroPad X230: ``firmware-nitropad-x230-[version].npf``
   - NitroPad NV41: ``firmware-nitropad-nv41-[version].npf``
   - NitroPad NS50: ``firmware-nitropad-ns50-[version].npf``

Firmware Signature Check
^^^^^^^^^^^^^^^^^^^^^^^^^^

To verify the firmware follow these steps:

1. Download  `sha256sum.sig <https://github.com/Nitrokey/heads/releases/latest>`__ and store it

2. Download and import Markus Meissners `gpg key <https://keyserver.ubuntu.com/pks/lookup?search=coder%40safemailbox.de&fingerprint=on&op=index>`__ 

3. Verify the signature: 

.. code-block:: bash

   gpg --verify sha256sum.sig sha256sum


You expect an output like this one:

.. code-block:: bash

	gpg: Signature made Wed 05 Jul 2023 04:30:34 PM CEST
	gpg:                using RSA key C7E32619E2F71736F5910BB144CB2D868DD16BDA
	gpg: Good signature from "Markus Meissner <meissner@nitrokey.com>" [ultimate]
	gpg:                 aka "Markus Meissner <coder@safemailbox.de>" [ultimate]


This verifys the file. 

Procedure
~~~~~~~~~

This is the actual update procedure. Usually the first two screens will not be shown - in that case please start from step 3.

1. (Optional screen) Select “Ignore error and continue to default boot
   menu”.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/1.jpg
      :alt: img1



2. (Optional screen) Select “Ignore error and continue to default boot
   menu”.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/2.jpg
      :alt: img2



3. Go to “Options”.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/3.jpg
      :alt: img3



4. Select “Flash/Update the BIOS”.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/4.jpg
      :alt: img4



5. Please confirm the first option.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/5.jpg
      :alt: img5



6. Confirm the process with Enter.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/6.jpg
      :alt: img6



7. Select the desired .npf file.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/7.jpg
      :alt: img7



8. Confirm the process with Enter.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/8.jpg
      :alt: img8



9. Confirm the restart with Enter.

   .. figure:: /components/nitropad-nitropc/images/firmware-update/9.jpg
      :alt: img9



You have successfully updated your firmware!

Further steps
~~~~~~~~~~~~~

.. hint::
	There is a known issue with the NV41 that it can get stuck after the update in the boot splash(heads takes longer then 30s to get up). This solves it self after max 5 restarts (pressing the power button short). If not please contact support@nitrokey.com 

1. In case ``ERROR: TOTP Generation Failed!`` screen will show up, please follow the instructions for Factory Reset (on the left side menu), starting from step
