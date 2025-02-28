Nitrokey App Installation
=========================

The Nitrokey App is included in Ubuntu's repositories since Ubuntu 18.04 (codename 'bionic') on. You can just install it via Software Center or by typing the following in a terminal:

::

 $ sudo apt update

::

 $ sudo apt install nitrokey-app

Unfortunately, the App versions in the official Ubuntu repositories are often not up-to-date.

More recent App versions
------------------------

To get the most recent Nitrokey App you can add a separate repository which is maintained by Nitrokey.

Please execute the following in a terminal to add the repository and install the Nitrokey App:

.. hint::

 The PPA is not necessary for Ubuntu 22.04 and later. The previous versions of Ubuntu could still use it to update the app.

::

 $ sudo add-apt-repository ppa:nitrokey/nitrokey

::

 $ sudo apt install nitrokey-app


Alternatively, you can use the snap package. Please see `here <https://www.nitrokey.com/download/snap-package>`__ for more information.
