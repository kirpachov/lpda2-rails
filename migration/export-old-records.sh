#!/bin/bash

set -e  # Termina lo script se un comando fallisce

REMOTE_HOST="laportadacqua.com"
REMOTE_TMP="/tmp"
LOCAL_TMP="tmp"
EXPORT_SCRIPT="remote-export-old-records.sh"
REMOTE_EXPORT_DIR="/tmp/lpda-export"
LOCAL_EXPORT_DIR="records"
ARCHIVE_NAME="all.zip"

mkdir -p "$LOCAL_EXPORT_DIR" && rm -rf "$LOCAL_TMP" "$ARCHIVE_NAME"

# Copia lo script sul server
scp "$EXPORT_SCRIPT" "$REMOTE_HOST:$REMOTE_TMP/"
if [ $? -ne 0 ]; then
    echo "Errore nel trasferimento dello script al server."
    exit 1
fi

# Esegui lo script sul server
ssh -t "$REMOTE_HOST" "sudo -S chmod +x $REMOTE_TMP/$EXPORT_SCRIPT && sudo $REMOTE_TMP/$EXPORT_SCRIPT"
if [ $? -ne 0 ]; then
    echo "Errore nell'esecuzione dello script remoto."
    exit 1
fi

# Scarica i dati esportati e li sposta nella cartella records
scp "$REMOTE_HOST:$REMOTE_EXPORT_DIR/$ARCHIVE_NAME" .
if [ $? -ne 0 ]; then
    echo "Errore nel download del file zip."
    exit 1
fi

unzip -q "$ARCHIVE_NAME"
if [ $? -ne 0 ]; then
    echo "Errore nello scompattare l'archivio."
    exit 1
fi

mv "$LOCAL_TMP/lpda-export/"* "$LOCAL_EXPORT_DIR/"
if [ $? -ne 0 ]; then
    echo "Errore nello spostamento dei file esportati."
    exit 1
fi

# Pulizia locale
test -d "$LOCAL_TMP" && rm -rf "$LOCAL_TMP"
rm -f "$ARCHIVE_NAME"

# Pulizia sul server
ssh -t "$REMOTE_HOST" "sudo -S rm -rf $REMOTE_TMP/$EXPORT_SCRIPT $REMOTE_EXPORT_DIR/"
if [ $? -ne 0 ]; then
    echo "Errore nella pulizia del server."
    exit 1
fi

echo "Operazione completata con successo!"
