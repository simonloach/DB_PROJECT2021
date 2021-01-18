DROP FUNCTION function() CASCADE ;
CREATE OR REPLACE FUNCTION refreshStock()
RETURNS TRIGGER AS $trigger$
	BEGIN
		UPDATE product
		SET no_instock = COALESCE(no_instock, 0) - NEW.product_quantity
		WHERE product.pid = NEW.pid;
		return NEW;

		END;
		$trigger$ language plpgsql;

CREATE TRIGGER trigger
	AFTER INSERT ON ordered_product
	FOR EACH ROW
	EXECUTE PROCEDURE refreshStock();
