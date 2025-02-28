NitroPC Pro 2 With External GPU
===============================


.. note::
   This guide is only working if you use the Qubes OS OEM GPU image from Nitrokey that you can build `here`_.


.. _here: https://github.com/Nitrokey/qubes-oem



This guide explains how to use your NitroPC with an external graphic card (GPU) with Qubes OS.

.. warning::
   Following this guide may create some security issues within Qubes OS. Follow it at your own risks.


Create a Windows Qube
---------------------

.. note::
   This will install a Windows Qube from the offical trial ISO. If you want a full Windows experience then you will need to add a licence key.

   This part is using `ElliotKillick project <https://github.com/elliotkillick/qvm-create-windows-qube>`__.


1. Open a terminal in dom0 and make sure that you have the internet connected.

2. Install the Qubes Windows Tools, in dom0 : ``sudo qubes-dom0-update qubes-windows-tools-4.1.69`` when asked press ``y`` and enter.

    .. note::
        Please see the `security implication <https://github.com/QubesOS/qubes-secpack/blob/master/QSBs/qsb-091-2023.txt>`__ of installing QWT.

3. Make the install script executable, in dom0 : ``sudo chmod +x /install.sh``

4. Launch the install script, in dom0 : ``/install.sh``

    If you see this message : ``[+] Installation complete!`` then you can continue.

    At this point the script created a new Qube called windows-mgmt now we will dowload the ISO to create the Windows Qube.

    To do so we need to copy the ``~/qvm-create-windows-qube/windows/isos/mido.sh`` script from the windows-mgmt Qube inside a disposable Qube with internet connectivity.

5. Start a new DVM (disposable) Qube and give it at least 10 GB of private storage.

6. Start the windows-mgmt Qube and copy the script, in windows-mgmt Qube : ``qvm-copy qvm-create-windows-qube/windows/isos/mido.sh`` then select the DVM Qube (dispXXXX).

7. Once the script is copied launch it, in dispXXX : ``./QubesIncoming/windows-mgmt/mido.sh win10x64``

    .. note::
        In this guide we install Windows 10 but other Windows versions are available you can list them by using ``./QubesIncoming/windows-mgmt/mido.sh``


8. If you get a success message then you will need to copy the dowloaded ISO from the DVM to the windows-mgmt Qube, in dispXXXX :  ``qvm-copy QubesIncoming/windows-mgmt/win10x64.iso`` and choose the windows-mgmt Qube.

    Once copied you can close your DVM Qube.

9. In the windows-mgmt Qube : ``mv QubesIncoming/dispXXXX/win10x64.iso qvm-create-windows-qube/windows/isos/`` (replace 'dispXXXX' with the name of the disposable Qube you created).

10. Then in dom0 : ``qvm-create-windows-qube -n sys-firewall -oy -i win10x64.iso -a win10x64-pro.xml work-win10``

    .. note::
        You can pre-install any package from `this site <https://community.chocolatey.org/packages>`__.
        E.g: ``qvm-create-windows-qube -n sys-firewall -oyp firefox,notepadplusplus,office365proplus -i win10x64.iso -a win10x64-pro.xml work-win10``

        If the script stops or if it get stuck retry until you see this message: ``[+] Completed successfully!``

11. Now you will need to attach your GPU to the Windows Qube, to do so go to the Qube Manager and the Windows 10 Qube options (make sure that the Qube is shut down), under the Devices tab select your graphic card and pass it to the right then click on the ``Configure strict reset for PCI devices`` then select your card and click ``OK``

12. Now that your graphic card is attached to your Windows Qube you will need to install the drivers of your card. Search for ``Check for updates`` in the search bar then click on ``Check for updates`` (you will need to reboot several times).

Now Windows will install all the drivers you will need to use your external graphic card. If you're experiencing some problems make sure that you have enought space in your Windows Qube while installing updates.

Once finished you can connect a secondary display to the graphic card.

If you want to use a dedicated mouse or keyboard for the Windows Qube then you need to use sys-usb and attach the desired device to it.



Create a Linux Qube
-------------------

Debian
------


1. Go to the Qube manager and create a new standalone Qube and launch the settings after creation.

2. In the advenced tab change the mode to HVM and disable memory balancing and choose the amount of RAM you want. 

3. In the devices tab select the GPU and pass it to the right then click on the ``Configure strict reset for PCI devices`` then select your card and click ``OK``

4. Close the settings and start the Qube.

5. Add non-free to your source list: ``sudo sed -i '1 s/.*/& non-free/' /etc/apt/sources.list``

6. ``sudo apt update``

7. ``sudo apt install nvidia-driver dbus-x11``

    Now you will need to create 3 differents files:


    screen.conf::

        Section "Device"
        Identifier  "GPU"

        # name of the driver to use. Can be "amdgpu", "nvidia", or something else
        Driver      "nvidia"

        # The BusID value will change after each qube reboot. 
        BusID       "PCI:0:8:0"
        EndSection    

        Section "Screen"
        Identifier "GPU screen"
        Device     "GPU"
        EndSection


    xorgX1.sh::

        #!/bin/bash

        binary=${1:?binary required}

        # Find the correct BusID of the AMD GPU, then set it in the Xorg configuration file
        pci=$(lspci | grep "VGA" | grep -E "NVIDIA|AMD/ATI" | cut -d " " -f 1 | cut -d ":" -f 2 | cut -d "." -f 1 | cut -d "0" -f 2)
        sed -i 's/"PCI:[^"]*"/"PCI:0:'$pci':0"/g' /home/user/screen.conf

        # Start the Xorg server for the X screen number 1.
        # The X screen n°0 is already used for QubesOS integration
        sudo startx "$binary" -- :1 -config /home/user/screen.conf

    xfce.sh::

        #!/bin/bash
        sleep 5 && sudo setxkbmap -display :1 fr & 
        /bin/sudo -u user PULSE_SERVER=unix:/run/user/1000/pulse/native bash -c 'sudo xhost + local:;/usr/bin/startxfce4'


8. ``sudo chmod +x xorgX1.sh xfce.sh``

9. ``sudo ./xorgX1.sh ./xfce.sh``

Now the secondary screen should turn on and show a Debian XFCE desktop.

If you want to use a dedicated mouse or keyboard for the Linux Qube then you need to use sys-usb and attach the desired device to it.
