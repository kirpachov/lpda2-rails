# Migration folder

This folder contains all the data and utilities needed for the migration from
the first version of the project, already in production since 2019,
to the new version.

## Export Records
```bash
# from migration folder
./export-old-records.sh
```

## Export images
```bash
# From migration folder
./export-old-images.sh
```

## Troubleshooting
When having issues with .csv files, try to open it with libre office calc and save it again. Sometimes mysql exports some rows with `"` and `;`