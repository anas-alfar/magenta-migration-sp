-- CALL AddNewDownloadableProductIntoMagento(20, 'product_name', 'product_description', 'product_short_description', 'product_keywords', 'product_meta_title', 'product_meta_description','/a/n/anas-profile-at-yahoo.jpg', '/e/r/erp-proposal.pdf','/h/a/hamleh.jpg', 'product_downloadable_title', 'erp-proposal', 'erp-proposal.html', 'erp-proposal.pdf');

DROP PROCEDURE IF EXISTS `AddNewDownloadableProductIntoMagento`;

DELIMITER //

CREATE PROCEDURE AddNewDownloadableProductIntoMagento (
IN category_id INT,
IN product_name VARCHAR(255),
IN product_keywords VARCHAR(255),
IN product_meta_title VARCHAR(255),
IN product_image VARCHAR(255),
IN product_downloadable_file VARCHAR(255),
IN product_downloadable_sample VARCHAR(255),
IN product_downloadable_title VARCHAR(255),
IN product_url_name VARCHAR(255),
IN product_url_html VARCHAR(255),
IN product_links_title VARCHAR(255),
IN product_meta_description VARCHAR(5000),
IN product_short_description VARCHAR(255),
IN product_description VARCHAR(5000)
)

BEGIN

SET @category_id = category_id; -- 20;
SET @product_name = product_name; -- '';
SET @product_description = product_description; -- '';
SET @product_short_description = product_short_description; -- '';
SET @product_keywords = product_keywords; -- '';
SET @product_meta_title = product_meta_title; -- '';
SET @product_meta_description = product_meta_description; -- '';
SET @product_base_image = product_image; -- '/l/o/logo_2.jpg';
SET @product_small_image = product_image; -- '/l/o/logo_2.jpg';
SET @product_thumbnail_image = product_image; -- '/l/o/logo_2.jpg';
SET @product_downloadable_file = product_downloadable_file; -- '/l/o/logo_2.jpg';
SET @product_downloadable_sample = product_downloadable_sample; -- '/l/o/logo_2.jpg';
SET @product_downloadable_title = product_downloadable_title; -- 'File #1';
SET @product_url_name = product_url_name; -- 'test-product-name';
SET @product_url_html = product_url_html; -- 'test-product-name-5.html';
SET @product_links_title = product_links_title; -- 'MATERIALS LINKS';
--
SET @product_id = 0;
SET @product_price = 33.2;
SET @product_quantity = 999999.0000;
SET @category_url_name = '';
--
IF @product_url_name = '' THEN SET @product_url_name = CONCAT(REPLACE(REPLACE(TRIM(LCASE(@product_name)), '  ', ''),' ','-'),'-url'); END IF;
IF @product_url_html = '' THEN SET @product_url_html = CONCAT(@product_url_name,'.html'); END IF;
IF @product_links_title = '' THEN SET @product_links_title = CONCAT(@product_url_name,SUBSTRING(@product_downloadable_file, -4)); END IF;

SET @sku = CONCAT(SUBSTRING(@product_url_name, 1, 45), '-', @product_id);
--
SELECT MAX(entity_id)+1 FROM `catalog_product_entity` INTO @product_id;
SELECT `value` FROM `catalog_category_entity_varchar` WHERE `attribute_id` = 43 AND `entity_id` = @category_id AND `store_id` = 0 INTO @category_url_name;
-- INSERT PRODUCT
INSERT INTO `catalog_product_entity` (`entity_id`, `entity_type_id`, `attribute_set_id`, `type_id`, `sku`, `has_options`, `required_options`, `created_at`, `updated_at`) VALUES (@product_id, 4, 4,'downloadable',@sku,1,0,NOW(),NOW());

-- TEST 
SELECT * FROM `catalog_product_entity`;

-- MAP CATEGORY TO PRODUCT
SELECT MAX(`position`) FROM `catalog_category_product` WHERE category_id = @category_id INTO @position;
IF @position IS NULL THEN SET @position = 0; END IF;
INSERT INTO `catalog_category_product` (`category_id`, `product_id`, `position`) VALUES (@category_id,@product_id,@position+1);

-- TEST 
SELECT * FROM `catalog_category_product`;


-- INSERT DATE_TIME ATTRIBUTES
INSERT INTO `catalog_product_entity_datetime` VALUES (NULL,4,77,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_datetime` VALUES (NULL,4,78,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_datetime` VALUES (NULL,4,93,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_datetime` VALUES (NULL,4,94,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_datetime` VALUES (NULL,4,104,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_datetime` VALUES (NULL,4,105,0,@product_id,NULL);

-- TEST 
SELECT * FROM `catalog_product_entity_datetime`;

-- INSERT DECIMAL ATTRIBUTES
INSERT INTO `catalog_product_entity_decimal` VALUES (NULL,4,75,0,@product_id,@product_price);
INSERT INTO `catalog_product_entity_decimal` VALUES (NULL,4,76,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_decimal` VALUES (NULL,4,79,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_decimal` VALUES (NULL,4,120,0,@product_id,NULL);

-- TEST 
SELECT * FROM `catalog_product_entity_decimal`;

-- INSERT INT ATTRIBUTES
INSERT INTO `catalog_product_entity_int` VALUES (NULL,4,96,0,@product_id,1);
INSERT INTO `catalog_product_entity_int` VALUES (NULL,4,102,0,@product_id,4);
INSERT INTO `catalog_product_entity_int` VALUES (NULL,4,121,0,@product_id,0);
INSERT INTO `catalog_product_entity_int` VALUES (NULL,4,128,0,@product_id,0);
INSERT INTO `catalog_product_entity_int` VALUES (NULL,4,131,0,@product_id,1);

-- TEST 
SELECT * FROM `catalog_product_entity_int`;

-- INSERT TEXT ATTRIBUTES
INSERT INTO `catalog_product_entity_text` VALUES (NULL,4,72,0,@product_id,@product_description);
INSERT INTO `catalog_product_entity_text` VALUES (NULL,4,73,0,@product_id,@product_short_description);
INSERT INTO `catalog_product_entity_text` VALUES (NULL,4,83,0,@product_id,@product_keywords);
INSERT INTO `catalog_product_entity_text` VALUES (NULL,4,106,0,@product_id,NULL);

-- TEST 
SELECT * FROM `catalog_product_entity_text`;

-- INSERT VARCHAR ATTRIBUTES
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,71,0,@product_id,@product_name);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,82,0,@product_id,@product_meta_title);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,84,0,@product_id,@product_meta_description);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,85,0,@product_id,@product_base_image);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,86,0,@product_id,@product_small_image);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,87,0,@product_id,@product_thumbnail_image);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,97,0,@product_id,@product_url_name);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,98,0,@product_id,@product_url_html);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,103,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,107,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,109,0,@product_id,'container1');
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,112,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,113,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,114,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,118,0,@product_id,'2');
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,119,0,@product_id,'4');
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,122,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,129,0,@product_id,NULL);
INSERT INTO `catalog_product_entity_varchar` VALUES (NULL,4,130,0,@product_id,@product_links_title);

-- TEST 
SELECT * FROM `catalog_product_entity_varchar`;

-- INSERT MEDIA

INSERT INTO `catalog_product_entity_media_gallery` VALUES (NULL, 88,@product_id,@product_base_image);

-- TEST 
SELECT * FROM `catalog_product_entity_media_gallery`;


SELECT MAX(`value_id`) FROM `catalog_product_entity_media_gallery` INTO @media_gallery_value_id;
INSERT INTO `catalog_product_entity_media_gallery_value` VALUES (@media_gallery_value_id,0,NULL,1,0);

-- TEST 
SELECT * FROM `catalog_product_entity_media_gallery_value`;


INSERT INTO `catalog_product_website` VALUES (@product_id,1);

-- TEST 
SELECT * FROM `catalog_product_website`;


INSERT INTO `cataloginventory_stock_item` VALUES (NULL, @product_id,1,@product_quantity,0.0000,1,0,0,1,1.0000,1,0.0000,1,1,NULL,NULL,1,0,1,0,1,0.0000,1,0,0);

-- TEST 
SELECT * FROM `cataloginventory_stock_item`;

INSERT INTO `cataloginventory_stock_status` VALUES (@product_id,1,1,@product_quantity,1);

-- TEST 
SELECT * FROM `cataloginventory_stock_status`;


INSERT INTO `core_url_rewrite` VALUES (NULL,1,CONCAT('product/',@product_id),@product_url_html,CONCAT('catalog/product/view/id/',@product_id),1,NULL,NULL,NULL,@product_id);

-- TEST 
SELECT * FROM `core_url_rewrite`;

INSERT INTO `core_url_rewrite` VALUES (NULL,1,CONCAT('product/',@product_id,'/',@category_id),CONCAT(@category_url_name,'/',@product_url_html),CONCAT('catalog/product/view/id/',@product_id,'/category/',@category_id),1,NULL,NULL,@category_id,@product_id);

-- TEST 
SELECT * FROM `core_url_rewrite`;


INSERT INTO `downloadable_link` VALUES (NULL,@product_id,0,0,2,NULL,@product_downloadable_file,'file',NULL,@product_downloadable_sample,'file');

-- TEST 
SELECT * FROM `downloadable_link`;


SELECT MAX(`link_id`) FROM `downloadable_link` INTO @link_id;
INSERT INTO `downloadable_link_price` VALUES (NULL,@link_id,0,0.0000);

-- TEST 
SELECT * FROM `downloadable_link_price`;


INSERT INTO `downloadable_link_title` VALUES (NULL,@link_id,0,@product_downloadable_title);

-- TEST 
SELECT * FROM `downloadable_link_title`;


END //
DELIMITER ;