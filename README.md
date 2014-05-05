site-lisp
---------

My emacs conf files


## compress virtualbox solution

mount -n -o remount,ro  -t   ext3   /dev/sda1   /
zerofree -v /dev/sda1

"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyhd my_vdi_file.vdi --compact
