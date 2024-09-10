# Run this on old lpda server.

rm -rf /tmp/lpda-export

mkdir /tmp/lpda-export

sudo chmod a+rwx /tmp/lpda-export -R

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'imageId' UNION ALL (SELECT foodAllergens.id, t.it, t.en, imageId FROM foodAllergens INNER JOIN translations t ON foodAllergens.nameTranslationId = t.id)) as a INTO OUTFILE '/tmp/lpda-export/allergens.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported allergens to /tmp/lpda-export/allergens.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'imageId' UNION ALL (SELECT foodIngredients.id, t.it as nameIt, t.en as nameEn, td.it as descriptionIt, td.en as descriptionEn, imageId FROM foodIngredients INNER JOIN translations t ON foodIngredients.nameTranslationId = t.id INNER JOIN translations td ON foodIngredients.descriptionTranslationId = td.id)) as a INTO OUTFILE '/tmp/lpda-export/ingredients.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported ingredients to /tmp/lpda-export/ingredients.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'imageId', 'color' UNION ALL (SELECT foodTags.id, t.it, t.en, imageId, color FROM foodTags INNER JOIN translations t ON foodTags.nameTranslationId = t.id)) as a INTO OUTFILE '/tmp/lpda-export/tags.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported tags to /tmp/lpda-export/tags.csv"

# mysql laportadacqua -e "SELECT * FROM media INTO OUTFILE '/tmp/lpda-export/media.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
#   echo "Exported media to /tmp/lpda-export/media.csv"

# Exporting menu

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'enabled', 'price', 'isSpecial', 'imageId', 'registrationDate', 'endDate', 'priority' UNION ALL (SELECT menu.id, tn.it, tn.en, td.it, td.en, enabled, price, isSpecial, imageId, registrationDate, endDate, priority FROM menu INNER JOIN translations tn ON menu.nameTranslationId = tn.id INNER JOIN translations td ON menu.descriptionTranslationId = td.id)) as a INTO OUTFILE '/tmp/lpda-export/menu.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported menu to /tmp/lpda-export/menu.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'enabled', 'imageId' UNION ALL (SELECT foodCategories.id, tn.it, tn.en, td.it, td.en, enabled, imageId FROM foodCategories INNER JOIN translations tn ON foodCategories.nameTranslationId = tn.id INNER JOIN translations td ON foodCategories.descriptionTranslationId = td.id)) as a INTO OUTFILE '/tmp/lpda-export/categories.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported categories to /tmp/lpda-export/categories.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'enabled', 'imageId', 'price' UNION ALL (SELECT foodItem.id, tn.it, tn.en, td.it, td.en, enabled, imageId, price FROM foodItem INNER JOIN translations tn ON foodItem.nameTranslationId = tn.id INNER JOIN translations td ON foodItem.descriptionTranslationId = td.id)) as a INTO OUTFILE '/tmp/lpda-export/dishes.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported dishes to /tmp/lpda-export/dishes.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'categoryId', 'foodItemId', 'priority' UNION ALL (SELECT * FROM categoryItemAssociation)) as a INTO OUTFILE '/tmp/lpda-export/categoryItemAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported categoryItemAssociation to /tmp/lpda-export/categoryItemAssociation.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'menuId', 'categoryId', 'priority' UNION ALL (SELECT * FROM menuCategoryAssociation)) as a INTO OUTFILE '/tmp/lpda-export/menuCategoryAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported menuCategoryAssociation to /tmp/lpda-export/menuCategoryAssociation.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'allergenId', 'foodItemId' UNION ALL (SELECT * FROM foodAllergensAssociation)) as a INTO OUTFILE '/tmp/lpda-export/foodAllergensAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported foodAllergensAssociation to /tmp/lpda-export/foodAllergensAssociation.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'tagId', 'foodItemId' UNION ALL (SELECT * FROM foodTagsAssociation)) as a INTO OUTFILE '/tmp/lpda-export/foodTagsAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported foodTagsAssociation to /tmp/lpda-export/foodTagsAssociation.csv"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'ingredientId', 'foodItemId' UNION ALL (SELECT * FROM foodIngredientsAssociation)) as a INTO OUTFILE '/tmp/lpda-export/foodIngredientsAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';" &&
  echo "Exported foodIngredientsAssociation to /tmp/lpda-export/foodIngredientsAssociation.csv"

zip -r /tmp/lpda-export/all.zip /tmp/lpda-export && echo "zip is available at /tmp/lpda-export/all.zip"

sudo chmod a+rwx /tmp/lpda-export -R