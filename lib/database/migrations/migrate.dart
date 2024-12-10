import 'dart:io';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'create_product_table.dart';
import 'customers_table.dart';
import 'orders_table.dart';
import 'orderitems_table.dart';
import 'products.dart';
import 'productnotes_table.dart';
import 'vendors_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		//  await CreateUserTable().up();
		//  await CreateProductTable().up();
		 await CustomersTable().up();
		 await OrdersTable().up();
		 await OrderitemsTable().up();
		 await Products().up();
		 await ProductnotesTable().up();
		 await VendorsTable().up();
	}

  dropTables() async {
		 await VendorsTable().down();
		 await ProductnotesTable().down();
		 await Products().down();
		 await OrderitemsTable().down();
		 await OrdersTable().down();
		 await CustomersTable().down();
		//  await CreateProductTable().down();
		//  await CreateUserTable().down();
	 }
}
