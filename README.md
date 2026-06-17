# FreeBSD sh history backup script

This simple script merges your `sh` history into a global history file and then merges it back into your regular `sh` history file.

## Overview

NOTE: The script can be discussed in this topic https://forums.freebsd.org/threads/fix-for-the-problem-with-history-in-sh-shell.103002/

On FreeBSD ~14.0+, the default `sh` shell can store command history. However, it has some quirks that may cause history entries to be lost.

If you rely on shell history a lot, this script may help you manage that problem.

When the script runs, it merges your current `sh` history into your backup history file.

In this context, `merge` means that duplicate commands are removed while keeping only the most recent occurrence of each command.

After that, the script overwrites your regular `sh` history file with the curated backup file.

## Usage and installation

1. Put the script somewhere in your `PATH`, for example:

```sh
/usr/local/bin/the_script.sh
```

2. Add this code to your `.shrc`. It will automatically run the script when the shell exits:

```sh
do_backup_sh_history_file() {
  echo "Sync sh history with backup"
  the_script.sh /root/.sh_history /root/my_sh_history_backup
}

trap do_backup_sh_history_file EXIT HUP TERM
```

Done. Each time you exit the shell properly, it will backup your history. However, it doesn't prohibit commands lost due to violent exit (like reboot, or ssh connection lost).

## Limitations

- To keep script simple, it is not possible to avoid removing duplicities. The feature of removing duplicities is the byproduct of the script simplicity. Anyway, it is worthless to have duplicities in the sh history.
- Violent terminal exits will prohibit script to execute
- Currently not possible to modify history by hand, it will get overwrite
