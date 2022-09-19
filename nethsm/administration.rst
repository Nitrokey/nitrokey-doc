Administration
==============

This chapter describes administrative tasks for users with the *Administrator* role.
Please refer to chapter `Roles <administration.html#roles>`__ to learn more about the role.

.. important::
   Please make sure you read the information in the beginning of `this document <index.html>`__ before starting to work.

System Management
-----------------

Device Information
~~~~~~~~~~~~~~~~~~

The vendor and product information for a NetHSM can be retrieved as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST info

      .. code-block::

         Host:    localhost:8443
         Vendor:  Nitrokey GmbH
         Product: NetHSM

   .. tab:: REST API
      Information about the `/info` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/GET_info>`__.

State
~~~~~

The NetHSM software has four states: *Unprovisioned*, *Provisioned*, *Locked*, and *Operational*.

+-----------------+-------------------------------------------------------------------------+
| State           | Description                                                             |
+=================+=========================================================================+
| *Unprovisioned* | NetHSM without configuration (factory default)                          |
+-----------------+-------------------------------------------------------------------------+
| *Provisioned*   | NetHSM with configuration.                                              |
|                 | The *Provisioned* state implies either *Operational* or *Locked* state. |
+-----------------+-------------------------------------------------------------------------+
| *Operational*   | NetHSM with configuration and ready to execute commands.                |
|                 | The *Operational* state implies the *Provisioned* state.                |
+-----------------+-------------------------------------------------------------------------+
| *Locked*        | NetHSM with configuration but protected (requires unlock).              |
|                 | The *Operational* state implies the *Provisioned* state.                |
+-----------------+-------------------------------------------------------------------------+

The current state of the NetHSM can be retrieved as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST state

      .. code-block::

         NetHSM localhost:8443 is Unprovisioned
   .. tab:: REST API
      Information about the `/health/state` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/GET_health-state>`__.

A new NetHSM has an *Unprovisioned* state and after provisioning enters the *Operational* state.
The provisioning of a NetHSM is described in the chapter `Provisioning <getting-started.html#provisioning>`__.

A NetHSM in *Operational* state can be locked again to protect it as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST lock

      .. code-block::

         NetHSM localhost:8443 locked
   .. tab:: REST API
      Information about the `/lock` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_lock>`__.

A NetHSM in *Locked* state can be unlocked as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST unlock

      .. code-block::

         NetHSM localhost:8443 unlocked
   .. tab:: REST API
      Information about the `/unlock` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_unlock>`__.

.. important::
   If the NetHSM is in *Locked* or *Operational* state after boot depends on the boot mode.
   Please refer to chapter `Boot Mode <administration.html#boot-mode>`__ to learn more.

Boot Mode
~~~~~~~~~

NetHSM can be used in *Attended Boot* mode and *Unattended Boot* mode.

+-------------------+----------------------------------------------------------------------+
| Boot Mode         | Description                                                          |
+===================+======================================================================+
| *Attended Boot*   | The *Unlock Passphrase* needs to be entered during each start,       |
|                   | which is used to decrypt the *User Data*. For security reasons,      |
|                   | this mode is recommended.                                            |
+-------------------+----------------------------------------------------------------------+
| *Unattended Boot* | No *Unlock Passphrase* is required, therefore the NetHSM can start   |
|                   | unattended.                                                          |
|                   | Use this mode if your availability requirements can not be fulfilled |
|                   | with *Attended Boot* mode.                                           |
+-------------------+----------------------------------------------------------------------+

The current boot mode can be retrieved as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST get-config --unattended-boot

      .. code-block::

         Configuration for NetHSM localhost:8443:
            Unattended boot: off
   .. tab:: REST API
      Information about the `/config/unattended-boot` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/GET_config-unattended-boot>`__.

The boot mode can be changed as follows.

.. tabs::
   .. tab:: nitropy
      **Arguments**

      +----------+--------------------------------------+
      | Argument | Description                          |
      +==========+======================================+
      | Status   | Enable or disable *Unattended Boot*. |
      |          | Can have value ``on`` or ``off``.    |
      +----------+--------------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST set-unattended-boot on

      .. code-block::

         Updated the unattended boot configuration for NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/config/unattended-boot` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_config-unattended-boot>`__.

Unlock Passphrase
~~~~~~~~~~~~~~~~~

The *Unlock Passphrase* is used to derive an *Unlock Key* if the NetHSM is in *Locked* state.
The passphrase is initially set during provisioning of the NetHSM.

The *Unlock Passphrase* can be set as follows.

.. tabs::
   .. tab:: nitropy
      **Optional Options**

      +-----------------------------------+---------------------------+
      | Option                            | Description               |
      +===================================+===========================+
      | ``-p``, ``--passphrase`` ``TEXT`` | The new unlock passphrase |
      +-----------------------------------+---------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST set-unlock-passphrase

      .. code-block::

         Passphrase:
         Repeat for confirmation:
         Updated the unlock passphrase for localhost:8443
   .. tab:: REST API
      Information about the `/config/unlock-passphrase` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_config-unlock-passphrase>`__.

HTTPS API Certificate
~~~~~~~~~~~~~~~~~~~~~~~~

The HTTPS API certificate is used for the REST API, and thus also used by *nitropy*.
During provisioning a self-signed certificate is created.
A change is only necessary when the certificate is to be replace.
Such change may be to replace it with a signed certificate from a certificate authority (CA).

The TLS certificate can be retrieved as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +-------------------+----------------------------------------------+
      | Option            | Description                                  |
      +===================+==============================================+
      | ``-a``, ``--api`` | Set the certificate for the NetHSM HTTPS API |
      +-------------------+----------------------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST get-certificate --api
        
      .. code-block::

         -----BEGIN CERTIFICATE-----
         MIIBHzCBxaADAgECAgkA7AznVQK3XWkwCgYIKoZIzj0EAwIwFDESMBAGA1UEAwwJ
         a2V5ZmVuZGVyMCAXDTcwMDEwMTAwMDAwMFoYDzk5OTkxMjMxMjM1OTU5WjAUMRIw
         EAYDVQQDDAlrZXlmZW5kZXIwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAARbeCRl
         F1ZIjK1bTfrPvtCoYDThMjdV1q8mq+B9FMDo4GIahTCUG/Ub6bCOcbip5pP92J3h
         yMEcPuos72c1KcGjMAoGCCqGSM49BAMCA0kAMEYCIQC/BNrkCM5gpsVfa9EqQcM0
         PCaADyZG7KKLgDv7asa5LwIhAKDXRE3Tdm9tYObO0X4p0CRQkl1+DnvGljzQe34C
         JBax
         -----END CERTIFICATE-----
   .. tab:: REST API
      Information about the `/config/tls/cert.pem` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/GET_config-tls-cert-pem>`__.

The TLS certificate can be generated as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +-------------------------------------------------------------------------+---------------------------------+
      | Option                                                                  | Description                     |
      +=========================================================================+=================================+
      | ``-t``, ``--type`` ``[RSA|Curve25519|EC_P224|EC_P256|EC_P384|EC_P521]`` | The type for the generated key  |
      +-------------------------------------------------------------------------+---------------------------------+
      | ``-l``, ``--length`` ``INTEGER``                                        | The length of the generated key |
      +-------------------------------------------------------------------------+---------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST generate-tls-key -t Curve25519

      .. code-block::

         Key for HTTPS API generated on NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/config/tls/generate` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_config-tls-generate>`__.

The CSR (Certificate Signing Request) for the certificate can be generated as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +------------------------------------+-----------------------------------------+
      | Option                             | Description                             |
      +====================================+=========================================+
      | ``-a``, ``--api``                  | Generate a CSR for the NetHSM HTTPS API |
      +------------------------------------+-----------------------------------------+
      | ``--country`` ``TEXT``             | The country name                        |
      +------------------------------------+-----------------------------------------+
      | ``--state-or-province`` ``TEXT``   | The state or province name              |
      +------------------------------------+-----------------------------------------+
      | ``--locality`` ``TEXT``            | The locality name                       |
      +------------------------------------+-----------------------------------------+
      | ``--organization`` ``TEXT``        | The organization name                   |
      +------------------------------------+-----------------------------------------+
      | ``--organizational-unit`` ``TEXT`` | The organization unit name              |
      +------------------------------------+-----------------------------------------+
      | ``--common-name`` ``TEXT``         | The common name                         |
      +------------------------------------+-----------------------------------------+
      | ``--email-address`` ``TEXT``       | The email address                       |
      +------------------------------------+-----------------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST csr --api --country="DE" --state-or-province="Berlin" --locality="Berlin" --organization="Nitrokey" --organizational-unit="" --common-name="Nitrokey" --email-address="info@nitrokey.com"

      .. code-block::

         -----BEGIN CERTIFICATE REQUEST-----
         MIGBMDUCAQAwAjEAMCowBQYDK2VwAyEAE+nz+nOj80SWG25UbqVcQk6Ua84zuj5B
         9qCtPpDUX2qgADAFBgMrZXADQQDwk9LrYDu83a1jgBGqW0I9BVXWEhP4gZLxlVV+
         c102GFi963ZPIxG7Z5+uWplz+wr/Vmr7KLr6oM01M/AZPJQO
         -----END CERTIFICATE REQUEST-----
   .. tab:: REST API
      Information about the `/config/tls/csr.pem` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_config-tls-csr-pem>`__.

The certificate can be replaced as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +-------------------+----------------------------------------------+
      | Option            | Description                                  |
      +===================+==============================================+
      | ``-a``, ``--api`` | Set the certificate for the NetHSM HTTPS API |
      +-------------------+----------------------------------------------+
      
      **Arguments**

      +--------------+------------------+
      | Argument     | Description      |
      +==============+==================+
      | ``FILENAME`` | Certificate file |
      +--------------+------------------+

      **Example**
      
      .. code-block:: bash

         nitropy nethsm --host $NETHSM_HOST set-certificate --api /tmp/nethsm-certificate
   .. tab:: REST API
      Information about the `/config/tls/csr.pem` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_config-tls-cert-pem>`__.

Network
~~~~~~~

The network configuration defines the settings used for the ETH network interface.

.. note::
   This settings do not configure the BMC ETH network interface.


The network configuration can be retrieved as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +---------------+----------------------------------------------+
      | Option        | Description                                  |
      +===============+==============================================+
      | ``--network`` | Set the certificate for the NetHSM HTTPS API |
      +---------------+----------------------------------------------+

      **Example**
      
      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST get-config --network

      .. code-block::

         Configuration for NetHSM localhost:8443:
         Network:
               IP address:    192.168.1.1
               Netmask:       255.255.255.0
               Gateway:       0.0.0.0
   .. tab:: REST API
      Information about the `/config/network` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/GET_config-network>`__.

Set the network configuration as follows.

.. note::
   The NetHSM does not support DHCP (Dynamic Host Configuration Protocol).

.. note::
   The NetHSM does not support IPv6 (Internet Protocol version 6).

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +---------------------------+--------------------+
      | Option                    | Description        |
      +===========================+====================+
      | ``-a``, ``--ip-address``  | The new IP address |
      +---------------------------+--------------------+
      | ``-n``, ``--netmask``     | The new netmask    |
      +---------------------------+--------------------+
      | ``-g``, ``--gateway``     | The new gateway    |
      +---------------------------+--------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST set-network-config -a 192.168.1.1 -n 255.255.255.0 -g 0.0.0.0

      .. code-block::

         Updated the network configuration for NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/config/network` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_config-network>`__.

Time
~~~~

The time configuration sets the system time of the NetHSM software.
It is usually not required to set the system time, as it is set during provisioning.

The time configuration can be retrieved as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +------------+----------------------------------------------+
      | Option     | Description                                  |
      +============+==============================================+
      | ``--time`` | Set the certificate for the NetHSM HTTPS API |
      +------------+----------------------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm -host $NETHSM_HOST get-config --time

      .. code-block::

         Configuration for NetHSM localhost:8443:
         Time:            2022-08-17 11:40:00+00:00
   .. tab:: REST API
      Information about the `/config/time` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/GET_config-time>`__.

Set the time of the NetHSM.

.. important::
   Make sure to pass the time in UTC timezone.

.. tabs::
   .. tab:: nitropy
      **Arguments**

      +----------+-------------------------------------------------------+
      | Argument | Description                                           |
      +==========+=======================================================+
      | ``time`` | The system time to set (Format: YYYY-MM-DDTHH:MM:SSZ) |
      +----------+-------------------------------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST set-time 2022-08-17T11:40:00Z

      .. code-block::

         Updated the system time for NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/config/time` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_config-time>`__.

Metrics
~~~~~~~

The NetHSM logs metrics of system parameters.

.. note::
   This command requires the authentication of an user with the *Metrics* role.
   Please refer to chapter `Roles <administration.html#roles>`__ to learn more about the role.

The metrics can be retrieved as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST metrics

      .. code-block::

         Metric                      	Value
         ----------------------------	--------
         client connections          	0
         established state           	6
         external.received bytes     	989931
         external.received packets   	13239
         external.transmitted bytes  	25908953
         external.transmitted packets	22037
         free chunk count            	322
         gc compactions              	0
         gc major bytes              	21348352
         gc major collections        	35
         gc minor collections        	2652
         http response 200           	28
         http response 201           	1
         http response 204           	1
         http response 400           	1
         http response 403           	1
         http response 404           	145
         http response 412           	1
         http response time          	0.084998
         http response total         	178
         internal.received bytes     	66541
         internal.received packets   	1130
         internal.transmitted bytes  	63802
         internal.transmitted packets	1133
         kv write                    	2
         log errors                  	3
         log warnings                	3
         maximum allocated space     	64528384
         maximum releasable bytes    	1216
         mmapped region count        	0
         new sleeper size            	1
         non-mmapped allocated bytes 	64528384
         sleep queue size            	11
         syn-rcvd state              	0
         timers                      	2
         total allocated space       	43940832
         total client                	1
         total established           	515
         total free space            	20587552
         total sleeper size          	12
         total syn-rcvd              	514
         total timers                	526
         uptime                      	17626
   .. tab:: REST API
      Information about the `/metrics` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/GET_metrics>`__.

Logging
~~~~~~~

The NetHSM can log system events to the serial port or to a syslog server on the network.

The serial console works right from the start of the NetHSM hardware.
It includes events from the NetHSM firmware and the NetHSM software.

The serial console connection settings are as follows.

+--------------+--------+
| Setting      | Value  |
+==============+========+
| Baud rate    | 115200 |
+--------------+--------+
| Data bits    | 8      |
+--------------+--------+
| Stop bits    | 1      |
+--------------+--------+
| Parity       | None   |
+--------------+--------+
| Flow Control | None   |
+--------------+--------+

The syslog server configuration can be retrieved as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +---------------+----------------------------------------------+
      | Option        | Description                                  |
      +===============+==============================================+
      | ``--logging`` | Set the certificate for the NetHSM HTTPS API |
      +---------------+----------------------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST get-config --logging

      .. code-block::

         Logging:
            IP address:    0.0.0.0
            Port:          514
            Log level:     info
   .. tab:: REST API
      Information about the `/config/logging` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/GET_config-logging>`__.

The syslog server configuration can be set as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +--------------------------------------------------------+-----------------------------------------------+
      | Option                                                 | Description                                   |
      +========================================================+===============================================+
      | ``-a``, ``--ip-address`` ``TEXT``                      | The IP address of the new logging destination |
      +--------------------------------------------------------+-----------------------------------------------+
      | ``-p``, ``--port`` ``INTEGER``                         | The port of the new logging destination       |
      +--------------------------------------------------------+-----------------------------------------------+
      | ``-l``, ``--log-level`` ``[debug|info|warning|error]`` | The new log level                             |
      +--------------------------------------------------------+-----------------------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST set-logging-config -a 192.168.0.1 -p 514 -l info

      .. code-block::

         Updated the logging configuration for NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/config/logging` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_config-logging>`__.

Backup
~~~~~~

The NetHSM *User Data* can be saved to a backup file.
This backup file contains all *User Data*,
namely *Configuration Store*, *Authentication Store*, *Domain Key Store* and *Key Store*.

.. important::
   A NetHSM system software in *Unattended Boot* mode will require the *Unlock Passphrase* if restored on a different NetHSM hardware.
   Please refer to chapter `Unlock Passphrase <administration.html#unlock-passphrase>`__ to learn more.

.. important::
   A NetHSM in *Unattended Boot* mode will be in the same mode after a restore.

Before a backup can be initiated the *Backup Passphrase* must be set.
The *Backup Passphrase* is used to encrypt the data in the backup file.

The backup passphrase can be set as follows.

.. tabs::
   .. tab:: nitropy
      **Optional Options**

      +-----------------------------------+----------------------------------------------+
      | Option                            | Description                                  |
      +===================================+==============================================+
      | ``-p``, ``--passphrase`` ``TEXT`` | Set the certificate for the NetHSM HTTPS API |
      +-----------------------------------+----------------------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST -u admin set-backup-passphrase

      .. code-block::

         Passphrase:
         Repeat for confirmation:
         Updated the backup passphrase for NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/config/backup-passphrase` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_config-backup-passphrase>`__.

.. note::
   This command requires the authentication of an user with the *Backup* role.
   Please refer to chapter `Roles <administration.html#roles>`__ to learn more.

The backup can be executed as follows.

.. tabs::
   .. tab:: nitropy
      **Arguments**

      +--------------+-------------+
      | Argument     | Description |
      +==============+=============+
      | ``FILENAME`` | Backup file |
      +--------------+-------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST backup /tmp/nethsm-backup

      .. code-block::

         Backup for localhost:8443 written to /tmp/backup
   .. tab:: REST API
      Information about the `/system/backup` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_system-backup>`__.

.. note::
   This backup file can be restored on an unprovisioned NetHSM instance only.

Restore
~~~~~~~

The NetHSM can be restored from a backup file.

.. note::
   The NetHSM must be in an *Unprovisioned State*.

The restore can be applied as follows.

.. tabs::
   .. tab:: nitropy
      **Optional options**

      +------------------------------------------------+-----------------------------------------------------------+
      | Option                                         | Description                                               |
      +================================================+===========================================================+
      | ``-p``, ``--backup-passphrase`` ``passphrase`` | The *Backup Passphrase*                                   |
      +------------------------------------------------+-----------------------------------------------------------+
      | ``-t``, ``--system-time``                      | The system time to set (Format: ``YYYY-MM-DDTHH:MM:SSZ``) |
      +------------------------------------------------+-----------------------------------------------------------+

      .. important::
         Make sure the time of your system is correctly set, or manually override the to set time.
      
      **Arguments**

      +--------------+--------------+
      | Argument     | Description  |
      +==============+==============+
      | ``FILENAME`` | Restore file |
      +----------+------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST restore /tmp/nethsm-backup

      .. code-block::

         Backup passphrase:
         Backup restored on NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/system/restore` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_system-restore>`__.

Update
~~~~~~

Updates for the NetHSM can be installed in a two-step process.
First the update image needs to be uploaded to the NetHSM.
The image is checked and validated automatically.

.. warning::

   Data loss may occur due to the installation of a beta update!

The update file can be uploaded as follows.

.. tabs::
   .. tab:: nitropy
      **Arguments**

      +--------------+-------------+
      | Argument     | Description |
      +==============+=============+
      | ``FILENAME`` | Update file |
      +--------------+-------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST update /tmp/nethsm-update.img.cpio

      .. code-block::

         Image /tmp/nethsm-update.img.cpio uploaded to NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/system/update` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_system-update>`__.

The update can now be applied or aborted. Please refer to the desired option below.

The update can be applied (committed) as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST commit-update

      .. code-block::

         Update successfully committed on NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/system/commit-update` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_system-commit-update>`__.

The update can be cancelled as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST cancel-update

      .. code-block::

         Update successfully cancelled on NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/system/cancel-update` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_system-cancel-update>`__.

Reboot and Shutdown
~~~~~~~~~~~~~~~~~~~

The NetHSM can be rebooted and shutdown, either remotely, or with the restart and poweroff button on the front of the NetHSM hardware.

The remote reboot can be initiated as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST reboot

      .. code-block::

         NetHSM localhost:8443 is about to reboot
   .. tab:: REST API
      Information about the `/system/reboot` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_system-reboot>`__.

The remote shutdown can be initiated as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST shutdown

      .. code-block::

         NetHSM localhost:8443 is about to shutdown
   .. tab:: REST API
      Information about the `/system/shutdown` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_system-shutdown>`__.

Reset to Factory Defaults
~~~~~~~~~~~~~~~~~~~~~~~~~

The NetHSM can be reset to factory defaults. During this process all user data gets deleted.

The reset to factory defaults can be performed as follows.

.. tabs::
   .. tab:: nitropy
      **Example**

      .. code-block:: bash

         $ nitropy nethsm -h $NETHSM_HOST factory-reset

      .. code-block::

         NetHSM localhost:8443 is about to perform a factory reset
   .. tab:: REST API
      Information about the `/system/factory-reset` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_system-factory-reset>`__.

User Management
---------------

Roles
~~~~~

The NetHSM allows the separation of duties by using different roles.
Each user account configured on the NetHSM has one of the following *Roles* assigned to it.

+-----------------+-------------------------------------------------------------+
| Role            | Description                                                 |
+=================+=============================================================+
| *Administrator* | An user account with this Role has access to all            |
|                 | operations provided by the NetHSM, except for key usage     |
|                 | operations, i.e. message signing and decryption.            |
+-----------------+-------------------------------------------------------------+
| *Operator*      | An user account with this Role has access to all key usage  |
|                 | operations, a read-only subset of key management operations |
|                 | and user management operations allowing changes to their    |
|                 | own account only.                                           |
+-----------------+-------------------------------------------------------------+
| *Metrics*       | An user account with this Role has access to read-only      |
|                 | metrics operations only.                                    |
+-----------------+-------------------------------------------------------------+
| *Backup*        | An user account with this Role has access to the operations |
|                 | required to initiate a system backup only.                  |
+-----------------+-------------------------------------------------------------+

.. note::
   In a future release, additional *Roles* may be introduced.

Add User
~~~~~~~~

Add an user account to the NetHSM.
Each user account has a *Role*, which needs to be specified.
Please refer to chapter `Roles <administration.html#roles>`__ to learn more about *Roles*.

.. note::
   The NetHSM assigns a random user ID if none is specified.

An user account can be added as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +----------------------------------------------------------------+----------------------------------+
      | Option                                                         | Description                      |
      +================================================================+==================================+
      | ``-n``, ``--real-name`` ``TEXT``                               | The real name of the user        |
      +----------------------------------------------------------------+----------------------------------+
      | ``-r``, ``--role`` ``[Administrator|Operator|Metrics|Backup]`` | The *Role* of the new user       |
      +----------------------------------------------------------------+----------------------------------+
      | ``-p``, ``--passphrase`` ``TEXT``                              | The passphrase of the new user   |
      +----------------------------------------------------------------+----------------------------------+

      **Optional Options**

      +--------------------------------+-----------------------------+
      | Option                         | Description                 |
      +================================+=============================+
      | ``-u``, ``--user-id`` ``TEXT`` | The user ID of the new user |
      +--------------------------------+-----------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST  add-user --real-name "Jane User" --role Operator

      .. code-block::

         Passphrase: 
         Repeat for confirmation:
         User e8836f4cf2c7fa968bf0 added to NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/users` endpoint, to create an user without specifying the user ID, can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_users>`__.

      Information about the `/users/{UserID}` endpoint, to create an user with specifying the user ID, can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_users-UserID>`__.

Delete User
~~~~~~~~~~~

Delete an user account from the NetHSM.

.. warning::
   Deletion is permanent and can not be reverted.

An user account can be deleted as follows.

.. tabs::
   .. tab:: nitropy
      **Arguments**

      +-------------+--------------------------+
      | Argument    | Description              |
      +=============+==========================+
      | ``USER_ID`` | The user Id of the user. |
      +-------------+--------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST delete-user "Jane User"

      .. code-block::

         User e8836f4cf2c7fa968bf0 deleted on NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/users/{UserID}` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/DELETE_users-UserID>`__.

User Passphrase
~~~~~~~~~~~~~~~

The passphrase of an user account can be reset.
A passphrase is initial set during adding of an user account.

.. note::
   Passphrases must have >= 10 and <= 200 characters.

The user passphrase can be set as follows.

.. tabs::
   .. tab:: nitropy
      **Required Options**

      +-----------------------------------+--------------------------------+
      | Option                            | Description                    |
      +===================================+================================+
      | ``-u``, ``--user-id`` ``TEXT``    | The user ID of the user        |
      +-----------------------------------+--------------------------------+
      | ``-p``, ``--passphrase`` ``TEXT`` | The new passphrase of the user |
      +-----------------------------------+--------------------------------+

      **Example**

      .. code-block:: bash

         $ nitropy nethsm --host $NETHSM_HOST set-passphrase --user-id e8836f4cf2c7fa968bf0
      
      .. code-block::

         Passphrase:
         Repeat for confirmation:
         Updated the passphrase for user e8836f4cf2c7fa968bf0 on NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/users/{UserID}/passphrase` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/POST_users-UserID-passphrase>`__.

Tags for Users
~~~~~~~~~~~~~~

*Tags* can be used to set access restrictions on keys, and are an optional feature.
They can only be assigned to user accounts with the *Operator* role.
The *Operators* can see all keys, but only use those with at least one corresponding *Tag*.
A key can not be modified by an *Operator* user.

To learn about how to use *Tags* on keys, please refer to `Tags for Keys <operation.html#tags-for-keys>`__.

The *Tag* can be added as follows.

.. tabs::
   .. tab:: nitropy
      **Arguments**

      +-------------+--------------------------------+
      | Argument    | Description                    |
      +=============+================================+
      | ``USER_ID`` | The user ID to set the tag on. |
      +-------------+--------------------------------+
      | ``TAG``     | The tag to set on the user ID. |
      +-------------+--------------------------------+

      **Example**

      .. code-block:: bash

         nitropy nethsm --host $NETHSM_HOST add-operator-tag e8836f4cf2c7fa968bf0 berlin

      .. code-block::

         Added tag berlin for user 5d0d171c067e1f519b33 on the NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/users/{UserID}/tags/{Tag}` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/PUT_users-UserID-tags-Tag>`__.

The *Tag* can be deleted as follows.

.. tabs::
   .. tab:: nitropy
      **Arguments**

      +-------------+--------------------------------+
      | Argument    | Description                    |
      +=============+================================+
      | ``USER_ID`` | The user ID to set the tag on. |
      +-------------+--------------------------------+
      | ``TAG``     | The tag to set on the user ID. |
      +-------------+--------------------------------+

      **Example**

      .. code-block:: bash

         nitropy nethsm --host $NETHSM_HOST delete-operator-tag e8836f4cf2c7fa968bf0 berlin

      .. code-block::

         Deleted tag berlin for user 5d0d171c067e1f519b33 on the NetHSM localhost:8443
   .. tab:: REST API
      Information about the `/users/{UserID}/tags/{Tag}` endpoint can be found in the `API documentation <https://nethsmdemo.nitrokey.com/api_docs/index.html#/default/DELETE_users-UserID-tags-Tag>`__.
