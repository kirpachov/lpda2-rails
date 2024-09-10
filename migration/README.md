# Migration folder

This folder contains all the data and utilities needed for the migration from
the first version of the project, already in production for two years,
to the new version.

## How to
```bash
# from migration folder
scp export-old-menu.sh laportadacqua.com:/tmp/
ssh laportadacqua.com
sudo su
/tmp/export-old-menu.sh
# Exit from production server
scp laportadacqua.com:/tmp/lpda-export/all.zip .
unzip all.zip
mv tmp/lpda-export/* menu/
# Done! Now clean up:
rm -rf tmp all.zip
ssh laportadacqua.com
sudo rm -rf /tmp/export-old-menu.sh /tmp/lpda-export/
```