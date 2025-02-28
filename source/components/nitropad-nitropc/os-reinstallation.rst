Operating System Reinstallation
===============================

.. contents:: :local:

.. warning::

   Booting this USB drive entirely erases all data on the hard disk or
   SSD of the NitroPad without further warning. Don’t boot this USB
   drive on any computer which contains data you want to keep. Make sure
   to format the USB drive after the intended use.

.. note::

   Due to a bug Linux Mint 21 is currently not supported. The latest supported version is Linux Mint 20.1

1. Download one of the operating system images: `Ubuntu
   Linux <https://www.nitrokey.com/files/ci/ubuntu/>`__, `Qubes OS <https://www.nitrokey.com/files/ci/qubes/>`__, `Debian <https://www.nitrokey.com/files/ci/nitropad/debian-oem/>`__,
   `Linux Mint <https://linuxmint.com/download.php>`__


2. Optional: Download hash sum and
   `verify <https://proprivacy.com/guides/how-why-and-when-you-should-hash-check#how-to-hash-check>`__
   the downloaded operating system image.

3. Write the operating system image to any USB drive. Possible
   applications:

   -  Windows: `Rufus <https://rufus.ie/>`__,
      `balenaEtcher <https://www.balena.io/etcher/>`__;
   -  Linux: ``dd``, `balenaEtcher <https://www.balena.io/etcher/>`__;
   -  macOS: ``dd``, `balenaEtcher <https://www.balena.io/etcher/>`__.

4. Connect the USB drive to your NitroPad and start it. In Heads menu
   select Boot Options -> USB Boot.

5. Depending on the operating system you may need to confirm its
   reinstallation.

6. `Sign the boot
   partition. <system-update.html>`_

To avoid accidential overwriting of valuable data, format the USB drive afterwards.

.. warning::

   Booting this USB drive entirely erases all data on the hard disk or
   SSD of the NitroPad without further warning. Don’t boot this USB
   drive on any computer which contains data you want to keep. Make sure
   to format the USB drive after the intended use.
