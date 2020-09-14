# S/MIME Email Encryption

## Prerequisites

There are two widely used standards for email encryption.

- OpenPGP/GnuPG is popular among individuals,
- S/MIME/X.509 is mostly used by enterprises.

If you are in doubt which one to choose, you should use OpenPGP, see [here](https://www.nitrokey.com/documentation/openpgp-email-encryption). This page describes the usage of S/MIME email encryption.

You need to purchase a S/MIME certificate or may already got one by your company. Furthermore, you need to install [OpenSC](https://github.com/OpenSC/OpenSC/wiki) on your System. While GNU/Linux users usually can install OpenSC over the package manager (e.g. `sudo apt install opensc` on Ubuntu), macOS and Windows users can download the installation files from the [OpenSC](https://github.com/OpenSC/OpenSC/wiki) page.

**Note: Windows users with 64-bit system (standard) need to install both, the 32-bit and the 64-bit version of OpenSC!**

## Import Existing Key and Certificate

The following instructions are based on the [wiki of OpenSC](https://github.com/OpenSC/OpenSC/wiki/OpenPGP-card). We will assume, that you already got a key-certificate pair as a .p12  file. Please have a look at the wiki page, if you got a separate key and certificate file.

To open the Windows command line please push the Windows-key and  R-key. Now type 'cmd.exe' in the text field and hit enter. To open a  Terminal on macOS or GNU/Linux please use the application search (e.g.  spotlight on macOS).

To make these commands as simple as possible, the .p12 file needs to  be in your home folder. On Windows this is usually  'C:\Users\yourusername' and on macOS and GNU/Linux system it will be  '/home/yourusername'. If you do not store the .p12 file there, you have  to adapt the path in the commands below. Please plug in the Nitrokey  before submitting the commands.

Assuming that your key-certificate file reads 'myprivate.p12' the commands for Windows looks like this:

```
"C:\Program Files\OpenSC Project\OpenSC\tools\pkcs15-init" --delete-objects privkey,pubkey --id 3 --store-private-key myprivate.p12 --format pkcs12 --auth-id 3 --verify-pin
"C:\Program Files\OpenSC Project\OpenSC\tools\pkcs15-init" --delete-objects privkey,pubkey --id 2 --store-private-key myprivate.p12 --format pkcs12 --auth-id 3 --verify-pin
```

and on macOS and GNU/Linux it will be

```
$ pkcs15-init --delete-objects privkey,pubkey --id 3 --store-private-key myprivate.p12 --format pkcs12 --auth-id 3 --verify-pin
$ pkcs15-init --delete-objects privkey,pubkey --id 2 --store-private-key myprivate.p12 --format pkcs12 --auth-id 3 --verify-pin
```

The two commands copy the key-certificate pair to the slot 2 (needed  for decrypting emails) and slot 3 (needed for signing). The output looks on both systems something like this:

![img1](./images/smime-email-encryption/1.png)

Please note that there will be error messages that can be safely ignored (see output example above).
 You now have the key-certificate pair loaded on the Nitrokey.

## Usage

You can find further information about the usage on these pages:

- for using [S/MIME encryption on Thunderbird](https://www.nitrokey.com/documentation/smime-thunderbird)
- for using [S/MIME encryption on Outlook](https://www.nitrokey.com/documentation/smime-outlook)
- for using [Evolution](https://help.gnome.org/users/evolution/stable/mail-encryption.html.en), an email client for the Gnome Desktop on Linux systems

## Troubleshooting

- On Windows: Did you install **both**, the 32-bit and the 64-bit version of OpenSC?
- Nitrokey Storage 2: You need to install OpenSC in version 0.18 or higher. You can find the files on the [OpenSC website](https://github.com/OpenSC/OpenSC/releases) for Windows and macOS user or [here](https://github.com/Nitrokey/opensc-build) for Debian/Ubuntu users.