Storage FAQ
===========

**Q:** How can I use the encrypted mobile Storage?

   Prior of using the encrypted mobile storage you need to install and initialize the Nitrokey Storage and download the latest Nitrokey App.

    Start the Nitrokey App.
    Press its tray icon and select "unlock encrypted volume" in the menu.
    Enter your User PIN in the appearing popup window.
    If this is the first time you may need to create a partition on the encrypted volume. Windows will open an appropriate window and ask you to do so. On Linux and Mac you may need to open a partition manager and create a partition manually. You can create as many partitions as you want. We recommend FAT(32) if you want to access the partition from various operating systems.
    Now you can use the encrypted volume as you would use any other ordinary USB drive. But all data stored on it will be encrypted in the Nitrokey hardware automatically.
    To remove or lock the encrypted volume you should unmount/eject it first.
    Afterwards you can disconnect the Nitrokey or select "lock encrypted volume" from the Nitrokey App menu.

The Nitrokey Storage is able to create hidden volumes as well. Please have a look at the corresponding instructions for hidden volumes.

**Q:** How can I use the hidden volume?

Hidden volumes allow to hide data in the encrypted volume. The data is protected with an additional password. Without the password the data existence's can't be proven. Hidden volumes are not setup by default so that their existence can be denied plausibly. The concept is similar to VeraCrypt's/TrueCrypt's hidden volume but with Nitrokey Storage the entire functionality of hidden volumes is implemented in hardware.

You can configure up to four hidden volumes. Once unlocked, hidden volumes behave like ordinary storage where you can create various partitions, filesystems and store files as you like.

If you decide to configure Hidden Volumes, you can not use the encrypted storage anymore. Because the Hidden Volume is situated on the free space of the encrypted storage, there is the potential of overwriting data in the Hidden Volume. You can say, even the encrypted storage "does not know" that there is a hidden volumes. The general structure is shown in the diagram below. Therefore, please do not write anything in the encrypted storage after creating a hidden volume (you have to unlock it first though).

Hidden volumes are like containers inside of a container, the encrypted volume.

Configure Hidden Volumes:

    Unlock encrypted volume from the Nitrokey App menu.
    Select "setup hidden volume".
    Now you need to enter a new password twice to protect your hidden volume. The password strength is indicated below.

    Note: PINs can only be tried three times only which is why they can be short. Passwords like used for hidden devices can potentially be attacked unlimited which is why they need to be sufficiently strong.
     
    Next you need to define the storage area being used. Hidden volumes are stored in the empty space of the encrypted volume. This is a critical choice because it could destroy data on the (not-hidden) encrypted volume and reveal the existience of the hidden volume.
        You should use one FAT32 partition on your encrypted volume as journaling filesystems, especially NTFS, may destroy the encrypted data.
        Copy some files to the encrypted volume prior to creating the hidden volume. Once you configured a hidden volume you shouldn't add or change files on the encrypted volume anymore.
        Identify the storage space your files consume on the encrypted volume. For example: 10%
        The hiden volume should start after your files on the encrypted volume. For example: 10% files + 10% buffer = 20%
        The hidden volume should end in a distance before the end of the storage. For example: 90%

In case you use two or more hidden volumes, note that their storage area must not overlap. Otherwise they would override and destroy each other's data. Each hidden volume would require a different password.

Usage of Hidden Volumes:

    Select "unlock encrypted volume" and enter your User PIN.
    Select "unlock hidden volume" and enter any of the hidden volume's passwords.
    If this is the first time you may need to create a partition on the hidden volume. Windows will open an appropriate window and ask you to do so. On Linux and Mac OS you may need to open a partition manager and create a partition manually. You can create as many partitions as you want. We recommend FAT(32) if you want to access the partition from various operating systems.
    Make sure to unmount/eject all partitions on the hidden volumes before locking or disconnecting the Nitrokey.

Also see older but comprehensive Nitrokey Storage manual.



**Q:** Do you have resources for development and integration?


    Use Nitrokey library to manage the encrypted mass store, one-time passwords and password safe functionality.
    The project nitrokey-get-totp and nitrokey-get-password are nice examples for using the python bindings of Nitrokey library to get a custom interface.
    In order to access the integrated smart card, you can use OpenSC's command line tools.
    If your application has a PKCS#11 interface, use OpenSC's PKCS#11 driver.
    To work with the smart card low level, see the OpenPGP Card specification.
    The source code of the firmware and the hardware layout are available too.
    To develop special applications or for command line access one can use the nitrocli created by d-e-s-o.
    A libnitrokey wrapper for Rust providing access to Nitrokey devices.

