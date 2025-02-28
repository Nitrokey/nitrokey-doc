User Password Reset
===================

1. Follow the next five steps to boot from the installation media

    .. figure:: ./images/user-password-reset/step-one.jpg
       :alt: Step 1

    .. figure:: ./images/user-password-reset/step-two.jpg
       :alt: Step 2

    .. figure:: ./images/user-password-reset/step-three.jpg
       :alt: Step 3

    .. figure:: ./images/user-password-reset/step-four.jpg
       :alt: Step 4

    .. figure:: ./images/user-password-reset/step-five.jpg
       :alt: Step 5

2. In the rescue shell, type: `cryptsetup open /dev/sda3 qubes` or `cryptsetup open /dev/nvme0n1p3 qubes` to unlock the encrypted root drive

3. Mount the root drive `mount /dev/mapper/qubes_dom0-root /mnt`

4. Change root to it `chroot /mnt`

5. Change the password `passwd user` (where "user" is your Qubes login)
6. Type in a new password and confirm
7. Type `exit` to exit the chroot
8. Type `reboot` and then boot as usal without the installation medium
