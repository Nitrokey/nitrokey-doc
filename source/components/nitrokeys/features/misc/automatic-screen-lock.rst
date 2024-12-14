Automatic Screen Lock at Removal
================================

.. section products-begin
.. list-table::
   :width: 100%
   :header-rows: 1
   :class: products-table

   * - `Nitrokey 3 <https://docs.nitrokey.com/nitrokeys/nitrokey3/index.html>`_
     - `Nitrokey Passkey <https://docs.nitrokey.com/nitrokeys/passkey/index.html>`_
     - `Nitrokey FIDO2 <https://docs.nitrokey.com/nitrokeys/fido2/index.html>`_
     - `Nitrokey U2F <https://docs.nitrokey.com/nitrokeys/u2f/index.html>`_
     - `Nitrokey HSM 2 <https://docs.nitrokey.com/nitrokeys/hsm/index.html>`_
     - `Nitrokey Pro 2 <https://docs.nitrokey.com/nitrokeys/pro/index.html>`_
     - `Nitrokey Start <https://docs.nitrokey.com/nitrokeys/start/index.html>`_
     - `Nitrokey Storage 2 <https://docs.nitrokey.com/nitrokeys/storage/index.html>`_

   * - ✓
     - ⨯
     - ⨯
     - ⨯
     - ✓
     - ✓
     - ⨯
     - ✓
.. section products-end

.. contents:: :local:

This guide will walk you through the configuration of your computer, to automatically lock your session when you remove the Nitrokey.

The configuration requires the creation of two files under two different directories.

Requirements
~~~~~~~~~~~~

-  Ubuntu 20.04 or Debian 10 (Buster), both with `Gnome Display
   Manager <https://wiki.gnome.org/Projects/GDM>`__ installed.

-  Nitrokey 3, Nitrokey Pro 2, Nitrokey Storage 2, or Nitrokey HSM 2

Configuration
~~~~~~~~~~~~~

Create the ``.rules`` file
--------------------------

With your favorite text editor create a file called ``85-nitrokey.rules``

.. code-block:: bash

   $ sudo editor /etc/udev/rules.d/85-nitrokey.rules

Add the following line to the file

.. code-block:: bash

   ACTION=="remove", ENV{PRODUCT}=="20a0/4108/101" RUN+="/bin/bash -c '/usr/local/bin/gnome-screensaver-lock'"

Save the file and quit the editor.

This file sets up a new hardware rule that executes the ``gnome-screensaver-lock`` at removal of the Nitrokey device.

You should change the configuration according to the device you are using as following:

-  Nitrokey 3: ``ENV{PRODUCT}=="20a0/42b2/107"``
-  Nitrokey Pro: ``ENV{PRODUCT}=="20a0/4108/101"``
-  Nitrokey HSM: ``ENV{PRODUCT}=="20a0/4230/101"``
-  Nitrokey Storage: ``ENV{PRODUCT}=="20a0/4109/101"``

If you have a different device and need to find out the ``ENV{PRODUCT}`` string you can use the following command to find out the infos when plugging in:

.. code-block:: bash

   $ udevadm monitor --property --udev

Create the ``gnome-screensaver-lock`` script
--------------------------------------------

With your favorite text editor create a file called ``gnome-screensaver-lock``

.. code-block:: bash

   $ sudo editor /usr/local/bin/gnome-screensaver-lock

Add the following text

.. code-block:: bash

   user=`ps axo user:30,comm | grep -E "gdm-(wayland|x)" | awk '{print $1}'`

   if [ -n $user ]; then
           su $user -c "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/bin/dbus-send --type=method_call --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock"
   fi

In the first step, this script looks for the user-name of the gnome session, i.e. ``user``.

When it is called at Nitrokey removal, the script queries ``user``, switches to its session, and locks the screen by prompting the screen-saver screen.

Execute the script
------------------

Once all set up, execute the script once, and it will lock the screen. It does not matter if the Nitrokey is plugged or not for this first execution.

Usage
~~~~~

By now you can log back to your session by entering your password, and (re)plug you Nitrokey if you did not do it before.

The next time(s) you unplug your Nitrokey from the computer, it will automatically lock the screen.
