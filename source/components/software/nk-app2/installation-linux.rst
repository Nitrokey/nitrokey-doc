Linux Install
=============

Flathub / Flatpak
-----------------

The preferred installation method for Linux is through `Flathub <https://flathub.org/>`_:

1. `Setup <https://flathub.org/setup>`_  flathub / flatpak 
2. Execute ``flatpak install flathub com.nitrokey.nitrokey-app2`` to install (or use the native Flathub integration of your Operating System i.e., "Software" on Ubuntu systems)
3. :doc:`Set up the udev rules for nitropy <../nitropy/linux/udev>`
4. Start Nitrokey App2 using either ``flatpak run com.nitrokey.nitrokey-app2`` or use the created entry in your start-menu


.. note::
   Currently updating a Nitrokey 3 Mini is not supported through the flatpak package. This will be 
   fixed in one of the next releases.


Manual Installation
-------------------

1. `Download <https://github.com/Nitrokey/nitrokey-app2/releases>`__ the binary for Linux Nitrokey App 2
2. Extract the archive and set the binary as executable
3. :doc:`Set up the udev rules for nitropy <../nitropy/linux/udev>`
4. Execute the binary
