
DROP PROCEDURE IF EXISTS `AddNewCategoryIntoMagento`;

DELIMITER //

CREATE PROCEDURE AddNewCategoryIntoMagento(
IN entity_name VARCHAR(255),
IN entity_url_name VARCHAR(255),
IN entity_url_name_html VARCHAR(255),
IN entity_description VARCHAR(255),
IN entity_meta_keywords VARCHAR(255),
IN entity_meta_description VARCHAR(255),
IN entity_level INT,
IN children_count INT)

BEGIN

-- Example INPUT values
-- SET @entity_name = 'Medical Category Name';
-- SET @entity_description = 'Medical Category Description';
-- SET @entity_meta_keywords = 'Medical Category Meta Keywords';
-- SET @entity_meta_description = 'Medical Category Meta Description';
-- SET @entity_url_name = 'medical-category-name';
-- SET @entity_url_name_html = 'medical-category-name.html';
-- SET @entity_level = 2;
-- SET @children_count = 0;

-- Map all IN parameters into variables to work with SELECT queries inside the procedure
SET @entity_name = entity_name;
SET @entity_description = entity_description;
SET @entity_meta_keywords = entity_meta_keywords;
SET @entity_meta_description = entity_meta_description;
SET @entity_url_name = entity_url_name;
SET @entity_url_name_html = entity_url_name_html;
SET @entity_level = entity_level;
SET @children_count = children_count;

-- SET default value for some parameters
IF @entity_url_name = '' THEN SET @entity_url_name = CONCAT(REPLACE(REPLACE(TRIM(LCASE(@entity_name)), '  ', ''),' ','-'),'-url'); END IF;
IF @entity_url_name_html = '' THEN SET @entity_url_name_html = CONCAT(@entity_url_name,'.html'); END IF;

SET @entity_id = 0;
SELECT MAX(entity_id)+1 FROM `catalog_category_entity` INTO @entity_id;

INSERT INTO `catalog_category_entity` (`entity_id`, `entity_type_id`, `attribute_set_id`, `parent_id`, `created_at`, `updated_at`, `path`, `position`, `level`, `children_count`) SELECT @entity_id,3,3,2,NOW(),NOW(),'1/2/3', MAX(`position`)+1, @entity_level, @children_count FROM `catalog_category_entity`;
--
INSERT INTO `catalog_category_entity_datetime` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,59,0,@entity_id,NULL FROM `catalog_category_entity_datetime`;
INSERT INTO `catalog_category_entity_datetime` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,60,0,@entity_id,NULL FROM `catalog_category_entity_datetime`;
-- 
INSERT INTO `catalog_category_entity_decimal` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,70,0,@entity_id,NULL FROM `catalog_category_entity_decimal`;
-- 
INSERT INTO `catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,42,0,@entity_id,1 FROM `catalog_category_entity_int`;
INSERT INTO `catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,67,0,@entity_id,1 FROM `catalog_category_entity_int`;
INSERT INTO `catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,50,0,@entity_id,NULL FROM `catalog_category_entity_int`;
INSERT INTO `catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,51,0,@entity_id,0 FROM `catalog_category_entity_int`;
INSERT INTO `catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,68,0,@entity_id,0 FROM `catalog_category_entity_int`;
INSERT INTO `catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,69,0,@entity_id,0 FROM `catalog_category_entity_int`;
-- 
INSERT INTO `catalog_category_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,44,0,@entity_id,@entity_description FROM `catalog_category_entity_text`;
INSERT INTO `catalog_category_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,47,0,@entity_id,@entity_meta_keywords FROM `catalog_category_entity_text`;
INSERT INTO `catalog_category_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,48,0,@entity_id,@entity_meta_description FROM `catalog_category_entity_text`;
INSERT INTO `catalog_category_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,62,0,@entity_id,NULL FROM `catalog_category_entity_text`;
INSERT INTO `catalog_category_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,65,0,@entity_id,NULL FROM `catalog_category_entity_text`;
-- 
INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,41,0,@entity_id,@entity_name FROM `catalog_category_entity_varchar`;
INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,46,0,@entity_id,NULL FROM `catalog_category_entity_varchar`;
INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,49,0,@entity_id,'PRODUCTS' FROM `catalog_category_entity_varchar`;
INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,58,0,@entity_id,NULL FROM `catalog_category_entity_varchar`;
INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,61,0,@entity_id,NULL FROM `catalog_category_entity_varchar`;
INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,43,0,@entity_id,@entity_url_name FROM `catalog_category_entity_varchar`;
INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,57,1,@entity_id,@entity_url_name_html FROM `catalog_category_entity_varchar`;
INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`) SELECT MAX(`value_id`)+1,3,57,0,@entity_id,@entity_url_name_html FROM `catalog_category_entity_varchar`;
-- 
INSERT INTO `core_url_rewrite` (`url_rewrite_id`, `store_id`, `id_path`, `request_path`, `target_path`, `is_system`, `options`, `description`, `category_id`, `product_id`) VALUES (NULL,1,CONCAT('category/',@entity_id),@entity_url_name_html,CONCAT('catalog/category/view/id/',@entity_id),1,NULL,NULL,@entity_id,NULL);
-- 

END //
DELIMITER ;

