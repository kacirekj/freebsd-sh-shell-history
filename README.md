# FreeBSD sh history backup script

This script backs up your `sh` history into a global history file and then merges it back into your regular `sh` history file.

## Overview

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
