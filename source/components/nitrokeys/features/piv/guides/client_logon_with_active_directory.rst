Client Logon with Active Directory
==================================

.. include:: ../index.rst
	:start-after: products-begin
	:end-before: products-end

This document explains how to use the PIV application of a Nitrokey 3 for smartcard logon with Active Directory.

In the future, this manual provisioning may be automated through a Windows MiniDriver.

Prerequisites
-------------

The setup requires administrative access to the machines running Active Directory Directory Services (ADDS) and Active Directory Certificate Services (ADCS).
On the client machine only access to the respective user account used for logon is required.

* Windows server (supported versions are Windows Server 2016, 2019, 2022 in all editions)
   * ADDS role installed and configured.
   * ADCS role installed and *Enterprise-CA* with root certificate configured.
      * Each Domain Controller (DC) must have a *Domain Controller*, *Domain Controller Authentication*, and *Kerberos Authentication* certificate issued.
      * If you have clients leaving the company network, make sure the published full and delta certificate revocation lists (CRL) are retrievable from external networks.
* Windows client (supported versions are Windows 10, 11 in editions *Professional* and *Enterprise*)
   * Client must be a domain member of the Active Directory (AD) domain.
* Nitrokey 3 with PIV application.

Configure smartcard logon for use with Active Directory (AD)
------------------------------------------------------------

The smartcard logon requires a certificate template in the certificate authority (CA) of the the domain.
This template defines the values and constraints of the user certificates.
It is used to sign the Certificate Request (CSR) during provisioning of the Nitrokey.

1. Signing a certificate request for smartcard logon requires to create a certificate template in the certificate authority.

   .. tabs::
      .. tab:: MMC
         1. From the Command Line, PowerShell, or Run, type ``certtmpl.msc`` and press Enter.
         2. In the detail pane select the template **Smartcard Logon**.
         3. In the menu bar click **Actions → All Tasks → Duplicate Template**.
         4. Set the settings below on the template, according to the mentioned tab.

            **Compatibility**
               * Disable **Show resulting changes**
               * Set **Certificate Authority** and **Certificate recipient** to the oldest clients in the domain which are supposed to use smartcard logon.

                  .. important::
                     If you want to use Elliptic Curve (EC) keys your clients must be not older than Windows Server 2008 and Windows Vista.

            **General**
               * Set a **Template display name**.
               * Set the **Validity period** and **Renewal period**.

            **Request handling**
               * Set a purpose of **Signature and smartcard logon**.

            **Cryptography**
               * Set a provider category of **Key Storage Provider**.
               * Set a algorithm name and minimum key size.

                  .. important::
                     Microsoft recommends to use the RSA algorithm with a key length of ``2048`` Bit.
                     If you choose to use Eliptic Curve (EC) keys you need to make additional changes on your client computers.

            **Subject Name**
               * Set **Supply in the request**.
         5. Confirm the template creation with **OK**.

2. After the creation of a certificate template, the template must be issued to be used by the clients.

   .. tabs::
      .. tab:: MMC
         1. From the Command Line, PowerShell, or Run, type ``certsrv.msc`` and press Enter.
         2. In the navigation pane expand the Certificate Authority (CA) and navigate to **Certificate Templates**.
         3. In the menu bar click **Action → New → Certificate Template to Issue**.
         4. Select the certificate template you want to issue and confirm with **OK**.


Provision Nitrokey 3 for smartcard logon with Active Directory
--------------------------------------------------------------

The smartcard logon requires to provision a Nitrokey for an user in Active Directory.
The provisiong contains the private key and Certificate Singing Request (CSR) generation.
The certificate is then written to the Nitrokey.

.. warning::
   Before following the steps below make sure the Active Directory user account you want to use for smartcard logon exists.
   A creation time of the certificate before the creation time of the user account will lead to a failed logon.

.. important::
   If the PIV application on the Nitrokey was not used before, perform a initialization with ``nitropy nk3 piv init`` first.

1. Generate a private key and write the CSR to file with the command below.

   ::

      nitropy nk3 piv generate-key --key 9A --algo <algorithm> --subject-name <subject-name> --subject-alt-name-upn <subject-alternative-name> --out-file <file>

   The value of ``<algorithm>`` is the used algorithm with its key length, e.g. ``rsa2048``.
   The values of ``<subject-name>`` and ``<subject-alternative-name>`` corresponds typically to the ``commonName`` and ``userPrincipalName`` attribute of the Active Directory user account.

2. Sign the CSR with the certificate authority (CA) of the domain with the command below.

   ::

      certreq -attrib CertificateTemplate:<template-name> -submit <file>
   
   The value of ``<template-name>`` is the name of the certificate template for smartcard logon.
   The value of ``<file>`` is the certificate singing request file.

3. Write the signed certificate to the Nitrokey with the command below.

   ::

      nitropy nk3 piv write-certificate --format PEM --path <file>

   The value of ``<file>`` is the certificate file.


Revoke smartcard logon for use with Active Directory (AD)
---------------------------------------------------------

The issued user logon certificates are listed in the Active Directory Certificate Services (ADCS).
From ADCS the certificates can be revoked, which adds them to the configured Certificate Revocation List (CRL).
This is required in case of a lost or broken Nitrokey.

.. important::
   It is strongly advised to never leave unused user certificates without revoking them.

.. note::
   It is possible to temporarily revoke a certificate with the reason *Certificate Hold*.
   This revocation can be reverted and is hence not permanent.

.. tabs::
   .. tab:: MMC (certsrv.msc)
      1. From the Command Line, PowerShell, or Run, type ``certsrv.msc`` and press Enter.
      2. In the navigation pane expand the certificate authority (CA) and navigate to **Issued Certificates**.
      3. In the detail pane select the user certificate you want to revoke.
      4. In the menu bar click **Action → All Tasks → Revoke Certificate**.
      5. Specifiy a reason for the revocation, date and time, and confirm with **Yes**.
      6. In the navigation pane navigate to **Revoked Certificates**.
      7. In the menu bar click **Action → All Tasks → Publish**.
      8. Select the revocation list you want to publish and confirm with **OK**.

.. note::
   During each smartcard logon attempt Windows checks if the certificate presented by the smartcard is listed on a Certificate Revocation List (CRL).
   If the certificate is found on a CRL the logon is denied.
   Each CRL contains a validity to make them expire.
   Windows caches the fetched CRL and updates them if the CRL is about to expire.
   Hence a revocation is not immediate and depends on the expiration of the CRL the client has.


Import a user smartcard certificate to the personal certificate store
---------------------------------------------------------------------

The user certificate which is stored on the Nitrokey can be imported to the user's personal certificate store.
In certain situations this is a required procedure.

.. tabs::
   .. tab:: MMC (certmgr.msc)
      1. Make sure you are logged on to the user account the certificate corresponds to.
      2. From the Command Line, PowerShell, or Run, type ``certsrv.msc`` and press Enter.
      3. In the navigation pane expand the **Personal** key store and navigate to **Certificates**.
      4. In the menu bar click **Action → All Tasks → Import**.
      5. Follow the import wizard and provide the user certificate file when requested.
      6. After the import completed check the detail pane for the imported certificate.
         If the Nitrokey is connected, the properties of the certificate should show the message *You have a private key that corresponds to this certificate.* indicating that the private on the Nitrokey could be identified.

   .. tab:: PowerShell
      1. Make sure you are logged on to the user account the certificate corresponds to.
      2. Open PowerShell.
      3. Change to the personal certficate store of the user with ``Set-Location -Path cert:\CurrentUser\My``.
      4. Import the certificate to the store with ``Import-Certificate -Filepath '<path>'``, replacing ``<path>`` with the certificate file path.
