#!/bin/sh

# ======================================================================
# Marge sh history to global history and replace the original sh history
# ======================================================================

# set -x

# Parse input params
# ==================

if [ "$#" -ne 2 ]; then
    echo "Usage:"
    echo "  sh_history_file global_sh_history_file"
    echo
    echo "Merges sh_history_file into global_sh_history_file, removes duplicate commands,"
    echo "keeps the last occurrence of each command, and then replaces sh_history_file"
    echo "with the updated global history."
    exit 1
fi

LOCAL_SH_HISTORY="$1"
GLOBAL_SH_HISTORY="$2"


# Create reverted temporary global history file
# =============================================

GLOBAL_SH_HISTORY_REVERTED_TMP="/tmp/GLOBAL_SH_HISTORY_REVERTED_TMP"
touch "${GLOBAL_SH_HISTORY}"
cat "${GLOBAL_SH_HISTORY}" | tail -r > "${GLOBAL_SH_HISTORY_REVERTED_TMP}"


# Create reverted temporary local history file
# ============================================

LOCAL_SH_HISTORY_REVERTED_TMP="/tmp/LOCAL_SH_HISTORY_REVERTED_TMP"
unvis "${LOCAL_SH_HISTORY}" | tail -r > "${LOCAL_SH_HISTORY_REVERTED_TMP}"


# Create reverted temporary merge file
# ====================================

GLOBAL_SH_HISTORY_RESULT_REVERTED_TMP="/tmp/GLOBAL_SH_HISTORY_RESULT_REVERTED_TMP"
awk '!seen[$0]++' "${LOCAL_SH_HISTORY_REVERTED_TMP}" "${GLOBAL_SH_HISTORY_REVERTED_TMP}" > "${GLOBAL_SH_HISTORY_RESULT_REVERTED_TMP}"


# Revert to normal order and store
# ================================

tail -r "${GLOBAL_SH_HISTORY_RESULT_REVERTED_TMP}" > "${GLOBAL_SH_HISTORY}"


# Replace the original history file
# =================================

vis "${GLOBAL_SH_HISTORY}" > "${LOCAL_SH_HISTORY}"
chmod 755 "${GLOBAL_SH_HISTORY}"


# Cleanup
# =======

rm "$GLOBAL_SH_HISTORY_REVERTED_TMP"
rm "$LOCAL_SH_HISTORY_REVERTED_TMP"
rm "$GLOBAL_SH_HISTORY_RESULT_REVERTED_TMP"


