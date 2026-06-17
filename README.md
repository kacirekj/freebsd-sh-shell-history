# FreeBSD sh history backup script

It will backup your sh history into your global history file and then merges it back to your sh history file.

## Overview

On FreeBSD ~14.0+ the default sh shell can store history, however, it has some quirks which can lead to lost of history commands.
If you depend on history a lot, this script may help you to manage this problem.

When you run the script, it merges the sh history into your backup file. The `merge` means that it will remove command duplicities, keeping only the last used command of each such
duplicity. Then, it will overwrite your sh file by the curated backup file.

## Usage and installation

1. Add this script in your ./bin, e.g.:

```
  /usr/local/bin/the_script.sh
```

2. Add this code to your `.shrc` - it will trigger the script execution automatically on exit:

```
do_backup_sh_history_file() {
  echo "Sync sh history with backup"
  the_script.sh /root/.sh_history /root/my_sh_history_backup
}

trap do_backup_sh_history_file EXIT HUP TERM
```



