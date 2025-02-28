Enable Network Settings, e.g. Wifi
==================================

To be able to use Wifi, Bluetooth and other functionalities, "Settings" must be activated in "sys-net".


1. Click on the top left Qubes Icon and select Qubes:Settings under sys-net.

   .. figure:: ../images/network-settings/settings_0.png
      :alt: img1

2. Go to Applications, select "Settings" and click ">" to move it to the right side.
3. Click "Apply" and after wards "Ok".
4. Now you should have "Settings" visible under sys-net.

   .. Note::

      If it won't open Settings after clicking on it, please follow the instructions below.

Fix sys-net Settings
~~~~~~~~~~~~~~~~~~~~

1. Go to the sys-net Terminal.
2. Open the bashrc-file with ``sudo vim ~/.bashrc``.

   .. figure:: ../images/network-settings/settings_1.png
      :alt: img2

3. Press "i" to enable the editing and add ``export XDG_CURRENT_DESKTOP=GNOME`` to the file.

   .. figure:: ../images/network-settings/settings_2.png
      :alt: img3

4. Save the changes with ``:wq``.
5. Restart your NitroPad.
6. Now Settings should be visible.
