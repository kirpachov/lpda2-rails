# Run this on old lpda server.

rm -rf /tmp/lpda-export

mkdir /tmp/lpda-export

sudo chmod a+rwx /tmp/lpda-export -R

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'imageId' UNION ALL (SELECT foodAllergens.id, t.it, t.en, imageId FROM foodAllergens INNER JOIN translations t ON foodAllergens.nameTranslationId = t.id)) as a INTO OUTFILE '/tmp/lpda-export/allergens.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
echo "Exported allergens to /tmp/lpda-export/allergens.csv"


mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'imageId' UNION ALL (SELECT foodIngredients.id, t.it as nameIt, t.en as nameEn, td.it as descriptionIt, td.en as descriptionEn, imageId FROM foodIngredients INNER JOIN translations t ON foodIngredients.nameTranslationId = t.id INNER JOIN translations td ON foodIngredients.descriptionTranslationId = td.id)) as a INTO OUTFILE '/tmp/lpda-export/ingredients.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
echo "Exported ingredients to /tmp/lpda-export/ingredients.csv"


mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'enabled', 'price', 'isSpecial', 'imageId', 'registrationDate', 'endDate', 'priority' UNION ALL (SELECT menu.id, tn.it, tn.en, td.it, td.en, enabled, price, isSpecial, imageId, registrationDate, endDate, priority FROM menu INNER JOIN translations tn ON menu.nameTranslationId = tn.id INNER JOIN translations td ON menu.descriptionTranslationId = td.id)) as a INTO OUTFILE '/tmp/lpda-export/menu.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
echo "Exported menu to /tmp/lpda-export/menu.csv"


mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'imageId', 'color' UNION ALL (SELECT foodTags.id, t.it, t.en, imageId, color FROM foodTags INNER JOIN translations t ON foodTags.nameTranslationId = t.id)) as a INTO OUTFILE '/tmp/lpda-export/tags.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported tags to /tmp/lpda-export/tags.csv"

mysql laportadacqua -e "SELECT * FROM media INTO OUTFILE '/tmp/lpda-export/media.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported media to /tmp/lpda-export/media.csv"

zip -r /tmp/lpda-export/all.zip /tmp/lpda-export && echo "zip is available at /tmp/lpda-export/all.zip"

sudo chmod a+rwx /tmp/lpda-export -R