Generic FAQ
===========

**Q:** Which drivers can be used?


GnuPG is required for many use cases. It is a command line tool but usually you don't need to invoke it directly but use another application with user interface.

Don't use GnuPG in parallel with OpenSC or another PKCS#11 driver because both may interfere and unexpected issues may result.

    Install GPG4Win which contains Gnu Privacy Assistant (GPA) and GnuPG (GPG).
    Start Gnu Privacy Assistant (GPA) or another application such as your email client to use GnuPG.
    Advanced users could use GnuPG directly (command line). Please note: The Fellowship smart card is similar to the Nitrokey Pro so that this instructions work Nitrokey as well. In general the official documentation is recommendable.

PKCS#11 Driver

If you want to use S/MIME email encryption with Thunderbird, to use TrueCrypt/VeraCrypt, certificate-based SSL authentication with Firefox, PuTTY/KiTTY, OpenSSH, OpenSSL, or any other PKCS#11 compatible software, you should install OpenSC.

Note that a Nitrokey initialized with OpenSC doesn't work with GnuPG/OpenPGP. But the other way around works fine. If you want to use Nitrokey with both GnuPG and PKCS#11, generate the keys with GnuPG.

Don't use PKCS#11 in parallel with GnuPG because both may interfere and unexpected issues may result. (There is another promising project scd-pkcs11 in development which may overcome this limitation eventually. Currently it's limit to the authentication certificate and not widely tested yet.)

Instructions, how to create a valid X.509 certificate with Nitrokey (1, 2, 3). These are general instructions how to use X.509 certificates.
Alternative PKCS#11 Driver:

The recommended PKCS#11 driver is OpenSC. Alternatively, you could use Peter Koch's PKCS#11 driver which has the following limitations:

    No import of existing X.509 certificates. (Instead, keys have to be generated on the Nitrokey)
    The Linux version does not allow to generate keys.
    Modification of the password/PIN under Linux is not possible.

Windows Mini Driver

This Mini Driver allows to integrate Nitrokey with Window's certificate store. Subsequently all applications which use this certificate storage can be used with Nitrokey (e.g. Internet Explorer, Google Chrome web browser, Windows Login). To install the driver, you may need to allow the installation of unsigned drivers first.
Aloaha

All applications of Aloaha are working with the Nitrokey. This includes a middleware to integrate Nitrokey with other PKCS#11 based applications and with Windows as well as applications to encrypt and sign PDFs and the hard disk.

Alternative PKCS#11 Driver:

The recommended PKCS#11 driver is OpenSC. Alternatively, you could use Peter Koch's PKCS#11 driver which has the following limitations:

    No import of existing X.509 certificates. (Instead, keys have to be generated on the Nitrokey)
    The Linux version does not allow to generate keys.
    Modification of the password/PIN under Linux is not possible.

p11-glue

P11-glue uses PKCS#11 as glue between crypto libraries and security applications on the open source desktop.
Articles in German

    Eine allgemeine und gut verständliche Einführung bietet der Artikel Magisches Leuchten im Linux Magazin 2010/12.
    Eine umfangreiche Anleitung gibt es auf Pro-Linux.
    Einen ausfuehrlichen Erfahrungsbericht unter CentOS.


**Q:** How can I login into Windows?
   To access Nitrokey devices read-only, download and install this Mini Driver (CSP). If you are using Windows Server you may need to disable the driver signature verification before being able to install the driver. Note that the Mini Driver for Nitrokey Pro may not work yet for write mode.

There exist different ways to use a Nitrokey to logon on Windows:

    Login on stand alone Windows computers based on EIDAuthenticate. Alternatively install OpenSC and use Aloaha Smart Login's PKCS#11 Credentials.
    Login on Windows domain computers using MS Active Directory based OpenPGP-CSP minidriver for Nitrokey Storage 2 Nitrokey Pro 2
    Login on Windows domain computers using MS Active Directory based on Smart Policy for other Nitrokey devices.


**Q:** How can I login into Linux?
Linux Login with PAM

You have two options: pam_p11 or Poldi.

The solution with pam_p11 is more difficult to achieve and is based on S/MIME certificates. Please have a look at the documentation for more information.

Poldi 0.4.1 works flawlessly with Nitrokey for PAM authentication with RSA keys (see Troubleshooting for information on ECC keys). Besides the installation of poldi (e.g. 'sudo apt-get install libpam-poldi' on Ubuntu) the following steps are needed to get it working.

It is necessary to already have keys generated on the Nitrokey, as the authentication key is used by PAM.

At first you need to find out the "Application ID" of your Nitrokey. You can use "gpg --card-status | grep Application" to find out what's yours. It looks like 'D00600012401020000000000xxxxxxxx' or similiar. Now you have to add a line to /etc/poldi/localdb/users which contains the following information

    <YourApplicationID> <YourUsername>

This could look like 'D00600012401020000000000xxxxxxxx nitrokeyuser'. Now dump the public key from the Nitrokey into poldi local db:

sudo sh -c 'gpg-connect-agent "/datafile /etc/poldi/localdb/keys/<YourApplicationID>" "SCD READKEY --advanced OPENPGP.3" /bye'

Please be aware that you have to insert your Application ID in the line above with the one of your stick!

Then you have to configure PAM. Just add "auth sufficient pam_poldi.so" to pam configuration files according to your needs:

    /etc/pam.d/common-auth for graphical user login
    /etc/pam.d/login for console login
    /etc/pam.d/sudo for sudo authentication
    /etc/pam.d/gnome-screensaver for login back from a locked screen
    etc.

Note: Pam is dangerous to play around with, so make sure you have a way of accessing the machine if you break authentication completely. Remember that booting into rescue mode from Grub requires a root password, so keep that or a live CD which can read your filesystems to hand.

Here you find further instructions (in German, partially outdated).
Troubleshooting

If you get an error similar to 'ERR 100663414 Invalid ID <SCD>' you should try instead

poldi-ctrl -k > <YourApplicationID>; sudo mv <YourApplicationID> /etc/poldi/localdb/keys

Please be aware that you have to insert your Application ID in the line above with the one of your stick!
ECC Keys
Unfortunately, poldi has no support for ECC keys yet. But there is a patch for ECC keys used with Nitrokey Start. This is already included in the master branch of the poldi development repository and thus will be released in a newer version eventually. In the meantime the only option is to build poldi from source. 


**Q:** How can I login with One Time Passwords?
   One-Time-Passwords (OTP) are used for secure login to websites and local applications.

Two OTP modes exist:

    Time-based One-time Passwords (TOTP) is widely used for websites. If unsure, assume you are using this mode.
    HMAC-based One-time Passwords (HOTP) is used for local applications and computer logins.

To use One-Time-Passwords with your Nitrokey Pro or Nitrokey Storage, you need to download and install the latest Nitrokey App.
Time-based One-time Passwords - TOTP

    For login to a Google account.
    For login to a Microsoft account.
    For login to a Nextcloud account.
    Generic instructions for all other services.

**Q:** How can I use the Nitrokey Pro with Android?

It is possible to use the Nitrokey on an Android devices in combination with OpenKeychain. This enables one to encrypt/decrypt E-Mails or files via OpenPGP.

Cotech provides Android software with commercial support. Please have a look there, if you like. The following instructions are based on OpenKeychain.

Tested with Nitrokey Start, Pro and Storage in combination with Android 7.1, OpenKeychain 4.5 and K9Mail 5.207.
Prerequisites

    Android phone which is capable of USB OTG
    USB OTG cable to connect the Nitrokey with your phone
    OpenKeychain installed on Device
    Public key saved on the device or uploaded on a keyserver

First steps

To import the keys of the Nitrokey you should at first start the OpenKeychain app. Then insert the Nitrokey with the USB OTG cable. OpenKeychain starts a dialog to use the Nitrokey (you may have to accept the usage of the key with OpenKeychain first). Now you can choose between looking for public key on a keyserver or choosing the public key from storage. After the public key got imported you have to tap on 'connect key' to import a reference to the private key of the Nitrokey. That’s basically it.

In the case that no there are no keys on the Nitrokey yet, OpenKeychain will help with the creation of a new key pair instead.
Usage

You can use all functions of OpenKeychain and Apps which make use of OpenKeychain. Therefore you can just encrypt/decrypt messages or files by hand using the app directly or for example you combine K9Mail with OpenKeychain to decrypt your mails automatically. It is important to choose the right key in the K9Mail account settings first.

Note that you may have to enable the on-screen keyboard in the android settings to type the PIN as the system recognizes the Nitrokey as a physical keyboard and therefore tries to hide the on-screen keyboard. Go to 'Language and Input' > 'Current Keyboard' > 'Hardware show input method'.


**Q:** How can I use the Nitrokey Pro with Iphone?
   Currently it is not possible
**Q:** How can I use the Nitrokey Pro with Ubuntu Phone?
   There are instructions on gnupg.org about how to use a OpenPGP Card on a UbuntuPhone which should work for the Nitrokey Start, Pro and Storage.

**Q:** How can I do Email encryption?
There are two widely used standards for email encryption. While OpenPGP/GnuPG is popular among individuals, S/MIME/X.509 is mostly used by enterprises. If you are in doubt which one to choose, you should use OpenPGP.

    instructions for using the OpenPGP standard with the Nitrokey
    instructions for using S/MIME with the Nitrokey. Note: SMIME certificates can be purchased cheaply from CERTUM and SSLTrust.

Please note, that it is currently advised to use either OpenPGP or S/MIME encryption, but not both with the Nitrokey.

To use a Nitrokey Storage with Thunderbird 78+, you can try this tutorial. 

**Q:** How can I do Hard Disk Encryption?


For: Nitrokey Pro, Nitrokey Storage, Nitrokey Start
VeraCrypt (formerly TrueCrypt)

VeraCrypt is a free and Open Source disk encryption software for Windows, macOS, and GNU/Linux. It is the successor of TrueCrypt and thus recommended, although the following instructions should apply to TrueCrypt as well. Follow these steps to use the program with Nitrokey Storage or Pro:

    Install OpenSC
    Choose the library in VeraCrypt under Settings>Preferences>Security Token (location depends on system, e.g. /usr/lib/opensc).
    Generate a 64 Byte key file via Tools>Keyfile Generator.
    Now you should be able to import the generated key file via Tools>Manage Security Token Keyfiles. You should choose the first Slot ([0] User PIN). The keyfile is then stored on the Nitrokey as 'Private Data Object 1' (PrivDO1).
    After this you should wipe the original keyfile on your Computer securely!
    Now you can use VeraCrypt with the Nitrokey: Create a container, choose the keyfile on the device as an alternative to a password.

Security Consideration: Please note that VeraCrypt doesn't make use of the full security which Nitrokey (and smart cards in general) offer. Instead it stores a keyfile on the Nitrokey which theoretically could be stolen by a computer virus after the user enters the PIN.

Note: Aloaha Crypt is based on TrueCrypt/VeraCrypt but without the described security limitation.


Hard Disk Encryption on Linux, Based on LUKS/dm-crypt
Here are excellent instructions how to use Nitrokey to encrypt your hard disk under Linux with LUKS/dm-crypt. Other instruction.

Purism has created a simple script to add the Nitrokey/LibremKey as a way to unlock LUKS partitions (not tested by Nitrokey yet).

This project aims to ease the use of LUKS with the Nitrokey Pro or Storage based on the Password Safe (not tested by Nitrokey yet). A description on how to use it on Gentoo can be found here.

For Arch Linux, see initramfs-scencrypt.
Storage Encryption on Linux, Based on EncFS

Prerequisite: Please ensure that you installed the device driver, changed the default PINs and generated or imported keys with GnuPG.

An easy to use encrypted file system is EncFS, which is based on FUSE. You may follow these steps to use it with very long passwords and Nitrokey:

Initialization

# Create a key file with random data: 
$ dd bs=64 count=1 if=/dev/urandom of=keyfile

# Encrypt the key file and use the User-ID of your Nitrokey 
$ gpg --encrypt keyfile

# Remove the key file in clear text: 
$ rm keyfile # you may want to use 'wipe' or 'shred' to securely delete the keyfile

# Create mount point: 
$ mkdir ~/.cryptdir ~/cryptdir 

# Create the actual encryption folder
$ gpg -d keyfile.gpg | encfs -S ~/.cryptdir ~/cryptdir

# There may appears an error message about missing permission of fusermount
# This message can be ignored

# Unmount the new file system: 
$ fusermount -u ~/cryptdir

Usage

# Mount encrypted file system and enter PIN of Nitrokey: 
$ gpg -d keyfile.gpg | encfs -S ~/.cryptdir ~/cryptdir 

# After usage, unmount the file system: 
$ fusermount -u ~/cryptdir


Storage Encryption on Linux, Based on ECryptFS

eCryptfs is a file based transparent encryption file system for Linux which can be used with Nitrokey through a PKCS#11 driver. See these instructions. Alternatively, try ESOSI or follow these steps using OpenSC and OpenVPN:

Warning: This will delete existing keys on your Nitrokey!

# Import the certificate and key to the Nitrokey
$ pkcs15-init --delete-objects privkey,pubkey --id 3 --store-private-key user@example.com.p12 --format pkcs12 --auth-id 3 --verify-pin

# Create the file ~/.ecryptfsrc.pkcs11:
$ editor ~/.ecryptfsrc.pkcs11

# Enter this content:
$ pkcs11-log-level=5 pkcs11-provider1,name=name,library=/usr/lib/opensc-pkcs11.so,cert-private=true
$ openvpn --show-pkcs11-ids path to opensc-pkcs11 module
Certificate
    DN: /description=Iv4IQpLO02Mnix9i/CN=user@example.com/emailAddress=user@example.com
    Serial: 066E04
    Serialized id: ZeitControl/PKCS\x2315\x20emulated/000500000c7f/OpenPGP\x20card\x20\x28User\x20PIN\x29/03

# Copy the serialized id for later usage:
$ ecryptfs-manager

# This will show list option. Choose option "Add public key to keyring" 
# Choose pkcs11-helper
# Enter the serialized ID of step 3 to PKCS#11 ID.





**Q:** How can I sign and encrypt Files and PDFs?
GnuPG

Use the gpgsm tool to sign, verify, encrypt and decrypt files. Use a signature key on a Nitrokey to sign documents using Acrobat Reader, Open Office / Libre Office or any other PDF reader supporting electronic signatures.


GPA - GNU Privacy Assistant

The Gnu Privacy Assistant (GPA) recognizes Nitrokey out-of-the-box, has various features to manage keys and cards. It also allows file operations such as file encryption, decryption, signing.


SOPS - Secrect OPerationS

SOPS is an editor of encrypted files that supports YAML, JSON and BINARY formats and encrypts with AWS KMS and PGP. You can find it on github.


Aloaha

Aloaha provides several applications to encrypt and sign PDFs. All of them, which allow smart card integration, work with Nitrokey. You can for example import key and certificate by using OpenSC or any other appropriate variant. After this Windows recognize your certificate and you can sign the document as it is shown in the screencast below.

GpgEx for Windows Explorer

GpgEx integrates smoothly into Windows Explorer to allow encryption and decryption of files. Install it as part of the GPG4Win package.


Before you start to use any of these applications with your Nitrokey, please ensure that you installed the device driver and initialized the device (e.g. generated keys).

Certificate-based login with TLS and web browser is a very secure authentication method but it is only used rarely. If you are unsure what this means, this approach is most likely not relevant for you.

This page refers to websites and applications which support certificate authentication, so that users don't need to enter username and password when login. For instance WebID is a great protocol which makes use of it. Certificate authentication can be used easily with the Nitrokey and also with any other certificate storages.
Mozilla Firefox

You need to install the PKCS#11 driver:

    Download the PKCS11 driver and store it on your local hard disk or install OpenSC.
    Open the Preferences in Firefox and go to  Privacy & Security -> Security (just a headline) -> Button 'Security Devices...'
    Press the button Load. Enter "Nitrokey" as the Module Name and press the Browse button to select the previously downloaded PKCS11 driver file. Confirm and close all dialogs.

Now you are ready to access websites which provide certificate authentication.
Internet Explorer

Install this Mini Driver for Windows. Now you are ready to access websites which provide certificate authentication.
Google Chrome

Under Windows, install this Mini Driver. Under Linux, follow these instructions. Now you are ready to access websites which provide certificate authentication.
WebID

WebID is a technology to enable secure and federated social websites. Here is a video (WebM, Ogg video, H.264) which demonstrates how to use Nitrokey to create a WebID profile and subsequently to use it in an Internet cafe in Singapore. Nitrokey protects against computer viruses which might otherwise steel the username and password.
Websites
Web Site 	Category
CAcert 	community-based Certificate Authority
PrivaSphere 	Secure messaging
HM Revenue & Customs 	UK's tax administration
Software
Application 	Category
Roundcube (plugin) 	Webmail
Drupal (WebID, Certificate login) 	Content management system
Media Wiki (plugin) 	Wiki
Joomla! 	Content management system
Apache + mod_ssl 	Web server
OpenSSH 	SSH (remote secure shell) client and server
Wordpress (plugin) 	Blog and CMS
Tivoli 	System management framework
Globalscape EFT 	managed file transfer (MFT)
Oracle Identity Manager 	I&AM
Fuse Source 	Middleware
Liferay 	Blog
FusionForge 	web-based project-management and collaboration software

This website is a good read about strong authentication mechanisms, why client certificate authentication isn't popular and better alternatives at the horizon.

**Q:** How can I use Enterprise Authentication?

    LinOTP
    privacyIDEA
    RCDevs OpenOTP
    Usage of Nitrokey HSM as a secure key store for the Forgerock OpenDJ server and Forgerock Identity Gateway


**Q:** How can I do SSH for Server Administration on Windows?
The Nitrokey should already have PGP keys installed and the local GnuPG keyring should be aware of the keys, that is to say GPG4Win should be installed on the system (only the core application GnuPG is needed). Furthermore you should install PuTTY.
Preparation on client

There are two steps needed to make PuTTY work. At first we need to enable PuTTY support of GnuPG. To achieve this we use the following command:

echo enable-putty-support >> AppData\Roaming\gnupg\gpg-agent.conf

Now we want to make sure, that the gpg-agent is starting automatically in the background (you can start it manually with the command below, if you prefer). We create a shortcut to gpg-connect-agent.exe. Press and hold the Windows-key and press 'R'. Type in "shell:startup" in the opening textfield (see picture below). The Windows-Explorer opens and you right-click on an empty space and choose "New" -> "Shortcut". Now you should insert the actual command and proceed:

"C:\Program Files (x86)\gnupg\bin\gpg-connect-agent.exe" /bye

 

Reboot your system to make sure the shortcut works. If everything is alright you now can use PuTTY as usual and PuTTY will make use of the Nitrokey automatically.
Preparation for the server

You can generate an authorized_keys file by running

"C:\Program Files (x86)\gnupg\bin\gpg.exe" --export-ssh-key keyID >> authorized_keys

where 'keyID' is either the fingerprint of your key or just the E-Mail address bind to your key. The Nitrokey must already be known to the local GnuPG keyring. You can now append that file to a remote server's authorized_keys and when you ssh to the server you'll be asked for a pin rather than a passphrase.






**Q:** How can I do SSH for Server Administration on Linux?

The Nitrokey should already have PGP keys installed and the local GnuPG keyring should know the keys.
Preparation on client

    Make sure ~/.gnupg/gpg.conf contains 'use-agent'
    Add ssh support to gnupg-agent by adding 'enable-ssh-support' to ~/.gnupg/gpg-agent.conf
    If the file does not exist yet, you can just create it.
    Add the following code somewhere into your ~/.bashrc (for fish shell, look here)
    
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
    
    Simply restart your system or try pkill gpg-agent and open a new commandline to make sure everything is set
    In case of problems, please try gpg2 --card-status on first usage to make sure the gpg-agent gets started

Preparation for the server

You can generate an authorized_keys file by running either

gpgkey2ssh keyID >> ~/authorized_keys #(for GnuPG version <= 2.1.11) or
gpg2 --export-ssh-key keyID >> ~/authorized_keys #(for newer GnuPG versions)

where

keyID

is the subkey id being used for authentication on your Nitrokey. The Nitrokey must already be known to the local GnuPG keyring. You can now append that file to a remote server's authorized_keys and when you ssh to the server you'll be asked for a pin rather than a passphrase.


Troubleshooting

If you are still asked for a password please make sure that

echo $SSH_AUTH_SOCK

returns something reasonable like '/run/user/1000/gnupg/S.gpg-agent.ssh' or '/home/username/.gnupg/.S.gpg-agent.ssh'. Unfortunately there were some changes in GnuPG in the past so that the actual content can differ from system and GnuPG version. On some systems there may are even multiple folders in this variable saved. You have to adapt the above given code in .bashrc so that the variable SSH_AUTH_SOCK is correct. In doubt look for 'SSH_AUTH_SOCK' in

man gpg-agent

to find the actual code for your version/system.

You may check if you have a 'pinentry' program installed via your package manager. You may need to set it in the gpg-agent.conf as well.
You may need to point gpg-agent to the correct TTY.












**Q:** How can I use the Nitrokey for VPN access?


For: Nitrokey Pro, Nitrokey Storage, Nitrokey Start, Nitrokey HSM
OpenVPN

1. Generate a key on Nitrokey via pkcs11-tool.

2. Generate a certificate signing request via openssl + pkcs11 module:

$ openssl req -engine pkcs11 -sha256 -new -key id_3 -keyform engine -out <CSR FILE.CSR> -config <OPENSSL.CNF> -extensions usr_client

3. Sign the certificate with our certificate authority

$ openssl ca -cert <CA.CRT> -keyfile <CA.KEY> -in <FILE.CSR> -out <FILE.CRT> -config <OPENSSL.CNF> -extensions usr_client

4. Import  the certificate into the Nitrokey via pkcs11-tool

$ pkcs15-init --update-existing --store-certificate <FILE.PEM> --id 3

5. Read the certificate's ID required for openvpn configuration:

$ openvpn --show-pkcs11-ids /usr/lib64/opensc-pkcs11.so

6. Modify your openvpn configuration. Add the certificate ID which you gathered in the previous step: E.g.

$ pkcs11-id 'OpenPGP\x20project/PKCS\x2315\x20emulated/fffe43211234/User\x20PIN\x20\x28OpenPGP\x20card\x29/03'

7. Add the PKCS#11 driver to the configuration too, e.g.:

$ pkcs11-providers '/usr/lib/x86_64-linux-gnu/pkcs11/opensc-pkcs11.so'

See this link for further information.

 

Now all configurations are done. When executing OpenVPN client, Nitrokey's PIN needs to be entered. Unfortunately OpenVPN doesn't prompt to enter the PIN and it has to be entered in the following way:

$ telnet 8888 password 'User PIN (OpenPGP card) token' <PIN>

Alternatively you could recompile OpenVPN client with systemd support disabled and it will prompt you for the PIN as expected. Alternatively to the OpenVPN client you could use the Viscosity client which provides a better user experience especially for entering the PIN.


IPsec

Strong Swan works using the PKCS#11 driver. Basically follow these steps:

1. Generate a key on Nitrokey via pkcs11-tool. In this example it's a 4096 bit RSA key.

$ pkcs11-tool --module /usr/lib/x86_64-linux-gnu/pkcs11/opensc-pkcs11.so -l -k --key-type rsa:4096 --id 10 --label 'Staging Access'

2. Generate a certificate signing request via openssl + pkcs11 module

$ openssl
OpenSSL> engine dynamic -pre SO_PATH:/usr/lib/x86_64-linux-gnu/engines-1.1/pkcs11.so -pre ID:pkcs11 -pre LIST_ADD:1 -pre LOAD -pre MODULE_PATH:/usr/lib/x86_64-linux-gnu/pkcs11/opensc-pkcs11.so
OpenSSL> req -engine pkcs11 -sha256 -new -key id_10 -keyform engine -out user@email.com-staging-cert.csr -subj '/C=GB/L=Cambridge/O=Organization/OU=Staging Access/CN=user@email.com/emailAddress=user@email.com'

3. Sign the certificate with your certificate authority

4. Convert the certificate to DER

$ openssl x509 -in user@email.com-staging-cert.csr -out user@email.com-staging-cert.der -outform DER

5. Import  the certificate into the Nitrokey via pkcs11-tool

$ pkcs11-tool --module /usr/lib/x86_64-linux-gnu/pkcs11/opensc-pkcs11.so -l -y cert -w user@email.com-staging-cert.der --id 10 --label 'Staging Access'

6. Configure Strongswan to load opensc-pkcs11 module then to load the certificate on Nitrokey. Edit /etc/strongswan.d/charon/pkcs11.conf and add the following module:

    modules {
        Nitrokey {
            path = /usr/lib/x86_64-linux-gnu/pkcs11/opensc-pkcs11.so
        }
    }

7. Initiate the VPN connection via IPSec/Strongswan, then prompt for Nitrokey PIN

8. VPN is now connected
Stunnel

Stunnel works as an SSL encryption wrapper between remote client and local (inetd-startable) or remote server. It can be used to add SSL functionality to commonly used inetd daemons like POP2, POP3, and IMAP servers without any changes in the programs' code.

Stunnel is able to load OpenSC PKCS#11 engine using this configuration:

engine=dynamic
engineCtrl=SO_PATH:/usr/lib/opensc/engine_pkcs11.so
engineCtrl=ID:pkcs11
engineCtrl=LIST_ADD:1
engineCtrl=LOAD
engineCtrl=MODULE_PATH:/usr/lib/pkcs11/opensc-pkcs11.so
engineCtrl=INIT

[service]
engineNum=1
key=id_45















**Q:** How can I do PKI / Certificate Authority (CA)?

CA keys are very sensitive and must not be compromised or lost.
GnuPG

Instructions
OpenSSL

    Install OpenSC'S engine_pkcs11
    Run the command "pkcs11-tool --list-slots" to list the available slots.
    Run the command "openssl> req -engine pkcs11 -new -key slot_X-id_XXXX -keyform engine -x509 -out cert.pem -text" where X is the appropriate slot number and XXXX is the slot ID, e.g. "... -key slot_5-id_c6f280080fb0ed1ebff0480a01d00a98a1b3b89a ..."
    Test

Other

Please see this PDF (p. 30) from heinlein-support.de for summarized instructions in German.

µ-CA-tool is a script based on GnuPG, OpenSC and OpenSSL which helps to perform basic tasks of a CA. It works with Nitrokey Pro and Nitrokey Storage.







**Q:** How can I use the password manager?

You have the following options:

    Use Nitrokey's built-in Password Safe to store passwords securely. For this you need the Nitrokey App. Maximum are 16 passwords.
    Use Pass (simple commandline password manager for Unix systems, mainly for experts).
    Use KeePass as described below.

Protecting KeePass with Nitrokey's One-Time Passwords

You can also follow this video (It contains a mistake around time 4:22 which is described later below).
Keepass Installation

    Install Keepass 2.3.5.
    For Ubuntu: Because the main repository contains the older 2.3.4, you have to use some other source like this private PPA (please run these commands in terminal):
    
    sudo add-apt-repository ppa:jtaylor/keepass
    sudo apt-get update
    sudo apt-get install keepass2
    
    Install the OtpKeyProv plugin by downloading the archive, unzipping and copying the content to Keypass' Plugin directory.
    On Linux: sudo cp OtpKeyProv.plgx /usr/lib/keepass2/Plugins/
    For Linux, optional: Install mono-complete package if plugin is not detected when running Keepass2 (you can check that in Tools/Plugins):
    
    sudo apt-get install mono-complete

Keepass OTP Configuration
Existing Database

    Do a backup of your database and keep it until you are really sure everything works fine!
    Make sure you really did a backup. If you mess up, your passwords are lost!
    Open database as usual
    Select File/Change Master Key...

New Database

    Create new database as usual

Common

    Insert Master Password (optional)
    Set Key file / provider: to One-Time Passwords (OATH HOTP)
    Click OK
    With Nitrokey App: select HOTP slot and generate HOTP secret (it will be copied to clipboard automatically). Note: You may want write down this secret and store it anywhere secure. Otherwise if you lose your Nitrokey or it gets broken your password database is lost as well!!!
    Paste the secret to Keepass OTP Plugin window
    Make sure the Counter field and digits count are set the same in both windows. Click OK in Nitrokey App to save the slot.
    Select secret type: Base32
    Set the other settings as you like. Please consult plugin's manual (should be in same downloaded archive). I would recommend to set look-ahead value to non-zero to prevent locking up the database after accidental code request from used HOTP slot. In that case counters on the device and in Keepass would be out of sync and OTP codes will not be the same with expected.

Unlocking Database

    Open database
    Insert Master Password (if set)
    Key file / provider: to One-Time Passwords (OATH HOTP)
    Press OK
    Insert HOTP codes by repeatedly choosing proper HOTP slot from the Nitrokey App and pasting the clipboard content to proper field (the order of the codes is important).
    Press OK

Issues

    Due to nature of HOTP solution it is possible to get counters desynchronized (by selecting wrong OTP slot during day-to-day use). Using look-ahead plugin's setting should prevent that (value 10 or so should suffice - depends on desired security requirements - this would allow to 10 accidental requests). TOTP is not having that problem.
    Setting the OTP protection could be error-prone. There is no secret validation on OtpKeyProv side. In the test movie at 4:22 I have managed to set the Base32 coded secret as Hex (which was not a proper hex value) and it has not complained about it. There is no information what happened to database and how it is now configured. I have not noticed until I have watched the movie.

Tested under Ubuntu 16.10, Nitrokey App v0.6.3 and Nitrokey Storage v0.45.








**Q:** How can I use the True Random Number Generator?

Both devices are compatible to the OpenPGP Card, so that scdrand should work. This script may be useful. The TRNG provides about 40 kbit/s.

The user comio created a systemd file to use scdrand and thus the TRNG more generally. He created a ebuild for Gentoo, too.





**Q:** Do you have resources for development and integration?


    Use Nitrokey library to manage the one-time passwords and password safe functionality.
    The project nitrokey-get-totp and nitrokey-get-password are nice examples for using the python bindings of Nitrokey library to get a custom interface.
    In order to access the integrated smart card, you can use OpenSC's command line tools.
    If your application has a PKCS#11 interface, use OpenSC's PKCS#11 driver.
    To work with the smart card low level, see the OpenPGP Card specification.
    The source code of the firmware and the hardware layout are available too.
    To develop special applications or for command line access one can use the nitrocli created by d-e-s-o.
    Gkey is a go-based command line tool to access the Password Safe and OTP entries.
    A libnitrokey wrapper for Rust providing access to Nitrokey devices.



