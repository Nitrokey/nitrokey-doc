NitroPhone
**********

.. contents:: :local:

.. toctree::
   :maxdepth: 0
   :glob:
   :hidden:

   *

Getting Started
###############

By default you have a secure smartphone, already pre-installed with all the most necessary apps.

1. Set up a six-digit PIN to protect the phone. In cooperation with the security chip, this will ensure high security while maintaining good usability.

2. Please familiarize yourself with `using your GrapheneOS <https://grapheneos.org/usage>`__.

App Store
#########

For very high security requirements, you should use as few apps as possible to provide a small attack surface. If instead you want to use the NitroPhone as an everyday smartphone with more apps we recommend:

1. install the App Store `F-Droid <https://f-droid.org/F-Droid.apk>`__. This has exclusively open source apps that do without drastic tracking and without advertising. Here you will find thousands of apps from a wide variety of fields. If you are looking for an app, check F-Droid first.
2. If the apps in F-Droid are not enough for you, open F-Droid and install Aurora Store. In Aurora Store, you can install all apps from Google Play Store.
3. Many apps work without Google Play Services. However, if you want to use apps that require Google Play Services, you can install `Google Play Services in a sandbox <https://grapheneos.org/usage#sandboxed-play-services>`__ as follows. In the future, an installer will be provided to simplify the installation process. **Optional**: To prevent some apps from accessing Google Play Services, install Google Play Services in a separate profile. To do this, install Shelter from the F-Droid store beforehand. Then, perform the following installation steps in the working profile.

   1. Install `com.google.android.gsf <https://apps.grapheneos.org/packages/com.google.android.gsf/>`__.
   2. Install `com.google.android.gms <https://apps.grapheneos.org/packages/com.google.android.gms/>`__.
   3. Download all 5 files from `com.android.vending <https://apps.grapheneos.org/packages/com.android.vending/>`__.
   4. Open Aurora Store and install Split APKs Installer (SAI).
   5. Open Split APKs Installer and install all five files you downloaded in step 3. Note: The correct base file has probably been renamed to *base (2).apk*.
   6. From the home screen, select: *Settings -> Apps -> Google Play services and disable battery optimization*
   7. Open the Google Play Store once and press "Sign in" to start the initialization. You don't have to finish the sign in and a real login is not necessary. This is solely to initialize the software.

.. Important::

   The Google Play Store cannot install and update apps due to the sandbox. Instead, always use F-Droid (for open source apps) or Aurora Store (for apps from Google Play Store) to install apps.

Compatible Apps
###############

`Here <https://github.com/Peter-Easton/GrapheneOS-Knowledge/tree/master/App%20Compatibilty%20List>`__ you can check the compatibility of some popular apps.

Recommended Apps
################

* Browser: The pre-installed browser Vanadium is hardened and therefore recommended for high security. For better ad blocking, `Bromite <https://github.com/bromite/bromite/releases/latest>`__ browser is recommended instead.
* Email: K9-mail and OpenKeyChain (for OpenPGP encryption) or FairEmail.
* VPN: Orbot uses the free TOR network. Mullvad VPN and IVPN are paid VPN services.
* Backup: The integrated backup (Seedvault) and Nextcloud. Choose Settings -> System -> Backup.
* Messenger:
   * `Signal <https://signal.org/android/apk/>`__ is secure and now widely used. It can also be downloaded without an app store.
   * `Element <https://element.io/>`__ does not require a central infrastructure and allows the use of own servers. An own account can be registered for free at `NitroChat <https://nitro.chat>`__ for example.
   * `Briar <https://briarproject.org/>`__ is a peer-to-peer messenger without any server at all, which can be used without internet with contacts nearby.
* Contacts and calendar synchronization: DAVx5 supports CalDAV, CardDAV and WebCAL.
* One-time password generator (2FA, OTP): `Aegis Authenticator <https://github.com/beemdevelopment/Aegis>`__.
* Regarding camera app, see `here <https://grapheneos.org/usage#camera>`__.

Permissions of Individual Apps
##############################

To check or change the permissions on network access and sensors for a specific app: 

*Long press on the respective app icon -> app info -> permissions*

Scramble PIN Layout
###################

To make it difficult for strangers to read the PIN when typing it in, you can display the PIN layout in a random order. Additionally, we recommend a `privacy screen <https://shop.nitrokey.com/shop/product/privacyscreen-for-nitrophone-1-194>`__. To enable, select:

*Settings -> Security -> PIN scrambling -> Scramble PIN*

Kill Switch
###########

Kill Switches, which erase all the phone's data when triggered, are very risky in practice as they could be triggered unintentionally. Therefore, the NitroPhone instead has the feature to automatically shut down and restart when inactive for a set period of time. This puts the phone in a secure state where all data is encrypted, no data is in RAM, and the phone can only be unlocked with the legitimate PIN or password. To enable, select: 

*Settings -> Security -> Auto reboot -> select the idle time duration after which the phone should reboot*

Warning "Your device is loading a different operating system"
#############################################################

Shortly after the phone is turned on, the warning "Your device is loading a different operating system" is displayed. This warning indicates that no ordinary Google Android is running and can be ignored.

If you want to check the integrity of the operating system, you can use `remote verification <https://attestation.app/about>`__.

.. figure:: /nitrophone/images/boot-screen.jpg
   :alt: Boot screen

Further informations on GrapheneOs
#################
Here <https://grapheneos.org/faq> you can find further informations on GrapheneOs

Background Images
#################

You can use these nice background images.

.. figure:: https://www.nitrokey.com/files/nitrophone/backgrounds/bg_logo_1.jpg
   :width: 200px
   :alt: Background image 1

.. figure:: https://www.nitrokey.com/files/nitrophone/backgrounds/bg_logo_2.jpg
   :width: 200px
   :alt: Background image 2

.. figure:: https://www.nitrokey.com/files/nitrophone/backgrounds/bg_logo_3.jpg
   :width: 200px
   :alt: Background image 3
