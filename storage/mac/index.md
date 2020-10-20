# Nitrokey Storage, Mac

1. Important: Once you plug in the Nitrokey, your computer will start the Keyboard Setup Assistant. **Don't run through this assistant but exit it right away.**
2. Download and start the [Nitrokey App](https://www.nitrokey.com/download). Perhaps you want to store it on the unencrypted partition of your Nitrokey Storage
3. Open the About window from Nitrokey App's menu and check if you have the [latest firmware](https://github.com/Nitrokey/nitrokey-storage-firmware/releases) installed. If it's not the latest, please [update](https://docs.nitrokey.com/storage/mac/firmware-update.html).
4. Use the Nitrokey App to change the default User PIN (default: 123456) and Admin PIN (default: 12345678) to your own choices.

Your Nitrokey is now ready to use. [Checkout](https://www.nitrokey.com/documentation/applications) the various use cases and supported applications.

::: tip  Note 
- For some Versions of MacOS it is necessary to install custom [ccid driver](https://github.com/martinpaljak/osx-ccid-installer) (for information see [here](https://ludovicrousseau.blogspot.com/2016/04/os-x-el-capitan-and-ccid-driver-upgrades.html)), but in general MacOS should have the driver onboard. 
- For many use cases described, it is necessary to have either 
OpenPGP or S/MIME keys installed on the device (see below).
:::
## Key Creation with OpenPGP or S/MIME
There are two widely used standards for email encryption. While OpenPGP/GnuPG is popular among individuals, S/MIME/x.509 is mostly used by enterprises. If you are in doubt which one to choose, you should use OpenPGP.

- [instructions](https://docs.nitrokey.com/storage/mac/openpgp-email-encryption.html) for using the OpenPGP standard with the Nitrokey
- [instructions](https://docs.nitrokey.com/storage/mac/smime-email-encryption.html) for using S/MIME with the Nitrokey

