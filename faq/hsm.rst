Nitrokey HSM FAQ
===========

**Q:** Which API can I use?
    OpenSC: Comprehensive instructions exist for OpenSC framework. There is nitrotool as a more comfortable frontend to OpenSC.
    GPGSM (from GnuPG): Nitrokey HSM is supported since GnuPG 2.1.
    Embedded Systems: For systems with minimal memory footprint a read/only PKCS#11 module is provided by the sc-hsm-embedded project.
    This PKCS#11 module is useful for deployments where key generation at the user's workplace is not required. The PKCS#11 module also supports major electronic signature cards available in the German market.
    OpenSCDP: The SmartCard-HSM is fully integrated with OpenSCDP, the open smart card development platform. See the public support scripts for details. To import existing keys you can use its SCSH or NitroKeyWrapper.


**Q:** How to use the HSM for Login
For: Nitrokey HSM

Select your use case:

    Login With Nitrokey HSM on Stand Alone Windows Computers
    Login With Nitrokey HSM on Windows Domain Computers Using MS Active Directory
    For Unix environments an integration with PAM and OpenSSH is available.

**Q:**  How to use the HSM for Email Encryption

Encrypt your email using the S/MIME industry standard available in all major e-mail clients.

The Nitrokey HSM has been tested to work with Mozilla Thunderbird and Microsoft Outlook. Other email clients with support for PKCS#11 or Microsoft CSP should work as well.

Note: A certificate can be purchased cheaply from CERTUM.

**Q:**   How to use the Nitrokey for Hard Disk Encryption with VeraCrpt?

VeraCrypt is a free and Open Source disk encryption software for Windows, macOS, and GNU/Linux. It is the successor of TrueCrypt and thus recommended, although the following instructions should apply to TrueCrypt as well. Follow these steps to use the program with Nitrokey:

    Install OpenSC
    Choose the library in VeraCrypt under Settings>Preferences>Security Token (location depends on system, e.g. /usr/lib/opensc).
    Generate a 64 Byte key file via Tools>Keyfile Generator.
    Now you should be able to import the generated key file via Tools>Manage Security Token Keyfiles. You should choose the first Slot ([0] User PIN). The keyfile is then stored on the Nitrokey as 'Private Data Object 1' (PrivDO1).
    After this you should wipe the original keyfile on your Computer securely!
    Now you can use VeraCrypt with the Nitrokey: Create a container, choose the keyfile on the device as an alternative to a password.

Security Consideration: Please note that VeraCrypt doesn't make use of the full security which Nitrokey (and smart cards in general) offer. Instead it stores a keyfile on the Nitrokey which theoretically could be stolen by a computer virus after the user enters the password.

Note: Aloaha Crypt is based on TrueCrypt/VeraCrypt but without the described security limitation. (Not tested with Nitrokey HSM!)


**Q:** How to sign and encrypt files and pdfs?

GnuPG

Starting with version 2.1, GnuPG has build-in but limited support for the Nitrokey HSM. Use the gpgsm tool to sign, verify, encrypt and decrypt files or S/MIME messaging using your Nitrokey HSM. Use a signature key on a Nitrokey HSM to sign documents using Acrobat Reader, Open Office / Libre Office or any other PDF reader supporting electronic signatures.
ECC HSM Encryptor

ECC HSM Encryptor is a small application to encrypt and decrypt files with a Nitrokey HSM.

**Q:** How to do certificat-based Web login
Protect access to sensitive information on your website with 2nd factor authentication.

Use a Nitrokey HSM as authentication token via the build-in device authentication PKI or use keys and certificates on a Nitrokey HSM for TLS/SSL client authentication.

**Q:** SSH for Server Administration with windows
For: Nitrokey Pro, Nitrokey Storage, Nitrokey Start, Nitrokey HSM

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

**Q:** SSH Server administration on linux

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

**Q:** DNSSEC


For: Nitrokey HSM

Protect your domain name resolution using DNSSEC and a Nitrokey HSM as secure key store. It's based on Smartcard-HSM which is why the following resource apply:

    Signing NSD DNSSEC Zones with Nitrokey HSM by Vadim Penzin.
    Integration with OpenDNSSEC has been successfully tested in a demo by Richard Lamb.
    Luis D Espinoza Sanchez & Eberhard W Lisse held a session on using the SmartCard-HSM for DNSSEC at the 2015 ICAAN Meeting in Singapore.
    Jan-Piet Mens wrote a nice article about integrating the SmartCard-HSM with PowerDNS.


**Q:** Physical Access Control
With it's unique build-in device authentication PKI, a Nitrokey HSM has a cryptographically protected unique identity that can be verified in a fast authentication protocol. An access control terminal can verify authenticity and identity of the device, create a secure communication channel and perform offline PIN verification. The coolPACS project has all the details.

**Q:**

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


**Q:** 

  PKI / Certificate Authority (CA)

**Q:** Secret Management and Cloud Infrastructure

An approach to secure keys for Hashicorp Vault/Bank-Vault on a Nitrokey HSM can be found at banzaicloud.com.

**Q:** How to do N-of-m Schemes

The Nitrokey HSM 2 supports two different n-of-m schemes - one for secure sharing of key material/passwords and one for public key authentication to control the access to the device. Please see this blog post for more detailed information.
N-of-m for DKEK Shares

This feature can be used with OpenSC as described here. The general approach is seen in the videos below (external links).

Nitrokey HSM's Secure Key Backup and Restore:

Screencast

Nitrokey HSM's M-of-N Threshold Scheme:

screencast
N-of-m for public key authentication

So far n-of-m authentication is only supported in OpenSCDP. The blog post gives an overview and a how-to here (CDN access required) is shown the process step by step in the Smart Card Shell. For OpenSC there is a ticket to get that integrated.

n-of-m authentication is also supported in the PKI-as-a-Service Portal for locally and remote connected HSMs. The PKI-as-a-Service Portal is based on OpenSCDP.

**Q:** How to safe Cryptocurrences in the Nitrokey HSM


    J.v.d.Bosch wrote a simple, free python program to secure the private key of a Bitcoin wallet in a HSM. See here for further information.
    Using the HSM in an Ethereum PoA Chain.
    Tezos has been reported to work with Nitrokey HSM.

**Q:** How to use the True Random Number Generator?
Nitrokey HSM can be used with Botan and TokenTools by using OpenSC as a PKCS#11 driver.

OpenSSL can't use Nitrokey HSM's RNG directly because engine-pkcs11 doesn't contain a mapping for OpenSSL to C_GenerateRandom.

**Q:** What can I use for development and integration?

    se OpenSC's commandline tools
    If your application has a PKCS#11 interface, use OpenSC's PKCS#11 driver. Depending on your Linux distribution, the PKCS driver may may be located at /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so for example.
        Alternatively to OpenSC, you might use sc-hsm-embedded PKCS#11 and CSP-Minidriver Module.
    In case you use Java, you find a JCE Provider as part of Smart Card Shell.
    You can find information about the m-of-n scheme here.
    Secure Messaging can be used with the JCE provider.
    Please register at the CardContact Developer Network to get access to the user manual and further tools. You can also request the manual from us.
    Smart card forwarding with Fedora
    A user generated tool on GitHub to provide an easy frontend to OpenSCs toolset - nitrotool
    A forum post describes the procedure to sign executables with a key stored on HSM on Windows.

Key Use Counter

The Key Use Counter is displayed in the Key Manager of the Smart Card Shell. At the moment you can only set it with a script (SmartCardHSMKeySpecGenerator.prototype.setKeyUseCounter in the class scsh/sc-hsm/SmartCardHSM.js).

In our PKCS#11 module there is a proprietary attribute CKA_SC_HSM_KEY_USE_COUNTER with the key use of the C_GenerateKeyPair counter can be set. The attribute can then also be set for a key can be queried.

In OCF and the JCE Provider, the Key Use Counter can be queried with SmartCardHSMKey.getUseCounter() and confirm with SmartCardHSMKeySpec.setKeyUseCounter() can be set.