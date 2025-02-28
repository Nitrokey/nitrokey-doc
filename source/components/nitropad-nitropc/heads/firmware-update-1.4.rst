Firmware Update v1.4+
=======================

.. contents:: :local:

Starting with v1.4 due to elementary changes inside Heads and the firmware
layout, the update requires some additional considerations. This applies for
both NitroPads X230 and T430.

Should I update my NitroPad?
----------------------------

When updating your firmware to 1.4 (without using an external flasher device)
the graphical HEADS dialogues will be replaced with a less convenient text-only
version.

If you use Ubuntu, Debian, LinuxMint, or Qubes 4.0 updating the firmware beyond
v1.3.1 is (as of today) not needed. If you use Qubes 4.1 *without* the
integrated Ethernet port, you don't need to update the firmware either.

If you want to use Qubes 4.1 or newer *and* the integrated Ethernet port you
need to update the firmware to 1.4.

.. hint::
   If the `.npf` file is not accepted by HEADS, likely you do not run the latest HEADS version. 
   So either 1st update to version 1.3.1 or `unzip` the `.npf` file and use the resulting `.rom`
   file instead.    


How can I update my NitroPad?
-----------------------------

Updating from ``v1.3.1`` onwards has two different ways:
    
    * Legacy update using either ``nitropad-t430-v1.4.npf`` or ``nitropad-x230-v1.4.npf`` 
      from the Heads menu, see: :doc:`firmware-update`
    * When using an external flasher device you can use the ``-maximized`` images. This keeps graphical HEADS dialogues working. Read
      about the external flashing below.

.. warning::
    Never try updating your NitroPad using the `-maximized` image, if you do not 
    know exactly what you are doing! You will brick your NitroPad and
    it can only be repaired using an external flasher!


How can I update to *-maximized*?
---------------------------------

.. hint::
    We highly recommend to NOT DO THIS ON YOUR OWN, as long as 
    you are not exactly know what you are doing!

    We have a service to do this upgrade on your NitroPad, please
    write an e-mail to "shop at nitrokey.com" together with your sales order number (SOxxxxxx).

The following procedure describes roughly how to flash your NitroPad using
an external flasher - it is intentionally on a high level as we do not
recommend doing this process on your own. But for the sake of completeness
we document this here for the curios.

1. Make sure you have a (``flashrom``) compatible flasher like ``ch341a_spi`` with a SOIC-8 clamp.

2. Open the device (`see coreboot docs <https://doc.coreboot.org/mainboard/lenovo/Ivy_Bridge_series.html>`__) 
   and make sure you can access both flash chips.

3. Using ``flashrom`` read out the **bottom** flash (the 8MB image)

4. Using ``ifdtool`` (`coreboot ifdtool docs <https://doc.coreboot.org/ifdtool/index.html>`__) extract the ``GbE`` flashregion from the 
   image and replace the ``GbE``-region inside your ``-maximized`` image.

5. Split the modified firmware image using ``dd`` (as described in the coreboot documentation) into ``-top`` and ``-bottom``

6. Flash the images to the matching flash chips using your flasher and clamp

7. Reboot into your system (you should see ``-maximized`` inside the Heads menu)


Background information
----------------------

The new firmware *class* of ``-maximized`` images change the firmware
layout in a way that it is incompatible with Heads' internal firmware
upgrade feature on the NitroPads.

This change mainly originates from a reduces *Management Engine* size
inside the firmware image. Furthermore the ``-maximized`` images do 
contain all flash regions inside the firmware, this also includes ``GbE``,
which contains the Ethernet MAC address. 

The non ``-maximized`` images have no **functional** differences compared
to the ``-maximized`` images except of the reduced Heads GUI.
