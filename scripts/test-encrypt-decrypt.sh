#!/bin/bash

## TEST 1: Test encryption and decryption to relative file path

echo "Testing encryption and decryption" > test-encrypt-decrypt

ENCRYPTION_PASSWORD="SomePassword" ./scripts/encrypt.sh test-encrypt-decrypt test-encrypt-decrypt.enc

if [ $? != 0 ]; then
  echo "Encryption failed"
  exit $?
fi

ENCRYPTION_PASSWORD="SomePassword" ./scripts/decrypt.sh test-encrypt-decrypt.enc test-encrypt-decrypt.decrypted

if [ $? != 0 ]; then
  echo "Decryption failed"
  exit $?
fi

if [ "$(cat test-encrypt-decrypt)" != "$(cat test-encrypt-decrypt.decrypted)" ]; then
  echo "Decrypted file is different from the original."
  echo "Original:"
  cat test-encrypt-decrypt
  echo "Decrypted:"
  cat test-encrypt-decrypt.decrypted
  exit 1
fi

rm test-encrypt-decrypt test-encrypt-decrypt.enc test-encrypt-decrypt.decrypted

# echo "relative file path test passed"

## TEST 2: Test encryption and decryption to absolute file path

echo "Testing encryption and decryption" > /tmp/test-encrypt-decrypt

ENCRYPTION_PASSWORD="SomePassword" ./scripts/encrypt.sh /tmp/test-encrypt-decrypt test-encrypt-decrypt.enc

if [ $? != 0 ]; then
  echo "Encryption failed"
  exit $?
fi

ENCRYPTION_PASSWORD="SomePassword" ./scripts/decrypt.sh /tmp/test-encrypt-decrypt.enc test-encrypt-decrypt.decrypted

if [ $? != 0 ]; then
  echo "Decryption failed"
  exit $?
fi

if [ "$(cat /tmp/test-encrypt-decrypt)" != "$(cat /tmp/test-encrypt-decrypt.decrypted)" ]; then
  echo "Decrypted file is different from the original."
  echo "Original:"
  cat /tmp/test-encrypt-decrypt
  echo "Decrypted:"
  cat /tmp/test-encrypt-decrypt.decrypted
  exit 1
fi

rm /tmp/test-encrypt-decrypt /tmp/test-encrypt-decrypt.enc /tmp/test-encrypt-decrypt.decrypted


echo "absolute file test passed"

echo "Trying to perform a export and encryption. May fail if the database is not running."

SQL_FILE=$(./scripts/export-db-docker.sh)

ENCRYPTED_FILE=$(ENCRYPTION_PASSWORD=mario ./scripts/encrypt.sh $SQL_FILE)

echo "Encrypted file: $ENCRYPTED_FILE"

DECRYPTED=$(ENCRYPTION_PASSWORD=mario ./scripts/decrypt.sh $ENCRYPTED_FILE)

echo "Decrypted file: $DECRYPTED"

if [ "$(cat $SQL_FILE)" != "$(cat $DECRYPTED)" ]; then
  echo "Decrypted file is different from the original."
  echo "Original:"
  cat $SQL_FILE
  echo "Decrypted:"
  cat $DECRYPTED
  exit 1
fi

rm $SQL_FILE $ENCRYPTED_FILE $DECRYPTED