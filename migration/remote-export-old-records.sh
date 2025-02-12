# Run this on old lpda server.

set -e

rm -rf /tmp/lpda-export

mkdir /tmp/lpda-export

sudo chmod a+rwx /tmp/lpda-export -R


# #####################
# EXPORT
# #####################

mysql laportadacqua -e "SELECT * FROM (select 'id', 'token', 'service', 'date', 'expire' UNION ALL (SELECT \`id\`, \`token\`, \`service\`, \`date\`, \`expire\` FROM tokens)) m INTO OUTFILE '/tmp/lpda-export/tokens.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (select 'id', 'name', 'surname', 'email', 'telephone', 'reservationDate', 'isOutside', 'table', 'people', 'ip', 'token', 'status', 'registrationDate', 'modificationDate', 'eliminationDate', 'notes', 'isViewed', 'color', 'lang' UNION ALL (SELECT id, name, surname, email, telephone, reservationDate, isOutside, \`table\`, people, ip, token, status, registrationDate, modificationDate, eliminationDate, notes, isViewed, color, lang FROM reservations)) m INTO OUTFILE '/tmp/lpda-export/reservations.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'extension' UNION ALL (SELECT id, extension FROM media ORDER BY id)) m INTO OUTFILE '/tmp/lpda-export/media.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

# #####################
# Exporting menu components and associations
# #####################

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'imageId' UNION ALL (SELECT foodAllergens.id, t.it, t.en, imageId FROM foodAllergens LEFT JOIN translations t ON foodAllergens.nameTranslationId = t.id ORDER BY foodAllergens.id)) as a INTO OUTFILE '/tmp/lpda-export/allergens.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'imageId' UNION ALL (SELECT foodIngredients.id, t.it as nameIt, t.en as nameEn, td.it as descriptionIt, td.en as descriptionEn, imageId FROM foodIngredients LEFT JOIN translations t ON foodIngredients.nameTranslationId = t.id LEFT JOIN translations td ON foodIngredients.descriptionTranslationId = td.id ORDER BY foodIngredients.id)) as a INTO OUTFILE '/tmp/lpda-export/ingredients.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'imageId', 'color' UNION ALL (SELECT foodTags.id, t.it, t.en, imageId, color FROM foodTags LEFT JOIN translations t ON foodTags.nameTranslationId = t.id ORDER BY foodTags.id)) as a INTO OUTFILE '/tmp/lpda-export/tags.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'enabled', 'price', 'isSpecial', 'imageId', 'registrationDate', 'endDate', 'priority' UNION ALL (SELECT menu.id, tn.it, tn.en, td.it, td.en, enabled, price, isSpecial, imageId, registrationDate, endDate, priority FROM menu LEFT JOIN translations tn ON menu.nameTranslationId = tn.id LEFT JOIN translations td ON menu.descriptionTranslationId = td.id ORDER BY menu.priority)) as a INTO OUTFILE '/tmp/lpda-export/menu.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'enabled', 'imageId' UNION ALL (SELECT foodCategories.id, tn.it, tn.en, td.it, td.en, enabled, imageId FROM foodCategories LEFT JOIN translations tn ON foodCategories.nameTranslationId = tn.id LEFT JOIN translations td ON foodCategories.descriptionTranslationId = td.id ORDER BY foodCategories.id)) as a INTO OUTFILE '/tmp/lpda-export/categories.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'name.it', 'name.en', 'description.it', 'description.en', 'enabled', 'imageId', 'price' UNION ALL (SELECT foodItem.id, tn.it, tn.en, td.it, td.en, enabled, imageId, price FROM foodItem LEFT JOIN translations tn ON foodItem.nameTranslationId = tn.id LEFT JOIN translations td ON foodItem.descriptionTranslationId = td.id ORDER BY foodItem.id)) as a INTO OUTFILE '/tmp/lpda-export/dishes.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'categoryId', 'foodItemId', 'priority' UNION ALL (SELECT * FROM categoryItemAssociation ORDER BY priority)) as a INTO OUTFILE '/tmp/lpda-export/categoryItemAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'menuId', 'categoryId', 'priority' UNION ALL (SELECT * FROM menuCategoryAssociation ORDER BY priority)) as a INTO OUTFILE '/tmp/lpda-export/menuCategoryAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'allergenId', 'foodItemId' UNION ALL (SELECT * FROM foodAllergensAssociation ORDER BY foodItemId)) as a INTO OUTFILE '/tmp/lpda-export/foodAllergensAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'tagId', 'foodItemId' UNION ALL (SELECT * FROM foodTagsAssociation ORDER BY foodItemId)) as a INTO OUTFILE '/tmp/lpda-export/foodTagsAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

mysql laportadacqua -e "SELECT * FROM (SELECT 'id', 'ingredientId', 'foodItemId' UNION ALL (SELECT * FROM foodIngredientsAssociation ORDER BY foodItemId)) as a INTO OUTFILE '/tmp/lpda-export/foodIngredientsAssociation.csv' FIELDS TERMINATED BY ';' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

zip -r -q /tmp/lpda-export/all.zip /tmp/lpda-export

sudo chmod a+rwx /tmp/lpda-export -R