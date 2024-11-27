Headwind MDM
************

How to install Headwind MDM on NitroPhone
#########################################

.. note::
   
   Depending on whether you are using the paid or gratis license, some features might be available or not.
   (See `feature comparison <https://h-mdm.com/headwind-mdm-version-comparison/>`__ of the community vs. the enterprise version).


.. important::
   
   We recommand to backup your data.


.. note::
   
   Your Nitrophone needs to be connected to the internet during the configuration.

1. `Here <https://h-mdm.com/download/>`__ you can download the latest HMDM Android app. 
   It is important that this version matches your HMDM server version and configuration.
   You can also download the desired version here: https://h-mdm.com/files/hmdm-<version>-master.apk

2. Enable developer options (Settings > About Phone > Click 6 times on "Build number").

3. Enable USB debugging (Settings > System > Developer Options > USB debugging).

4. You will need to use Android Debug Bridge (adb), you can download it `here <https://developer.android.com/tools/releases/platform-tools#downloads>`__. 

5. Unzip the downloaded achive and open a terminal in this folder.

6. Connect the smartphone to a PC and change the charging connection to "File transfer".

7. Test if adb can find your Nitrophone: 

.. code-block:: bash
   
   ./adb devices

You need to see your device listed in the output.

8. Install the HMDM app via:

.. code-block:: bash 
  
  ./adb install <name of your downloaded file>.apk

When the MDM install was sucessful, the output of adb is "Success".

9. Now give the app device owner rights: 

.. code-block:: bash
 
 ./adb shell dpm set-device-owner com.hmdm.launcher/.AdminReceiver

If it was successful it says:

.. code-block:: bash
   
   Success: Device owner set to package com.hmdm.launcher/.AdminReceiver 
   Active admin set to component com.hmdm.launcher/.AdminReceiver

10. Log to your web server panel and go to Configurations and edit the config.
    For testing purposes you can try the demo server `here <https://app.h-mdm.com/#/login>`__.

11. Make sure that "Use with default launcher" is not selected.  
    Click "Save and close".

12. Now go to Devices and click on the QR code on the right hand side. Note: The QR code contains the configuration for your mobile device.

13. Open the app on the device, give MDM its required permissions.

14. Type in the server URL (e.g. https://app.h-mdm.com/) and click "Scan QR code".

You are now ready to go.

How to uninstall HMDM
#####################

.. important::
   
   Make sure to backup the data on your device.

1. Execute a factory reset on the device: (Settings > System > Reset options > Erase all data).