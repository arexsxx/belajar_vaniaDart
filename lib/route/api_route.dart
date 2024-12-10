import 'package:vania/vania.dart';
import 'package:vania_api/app/http/controllers/customer_controller.dart';
import 'package:vania_api/app/http/controllers/product_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix

    Router.post('/product', productController.create);
    Router.get('/product/{id}', productController.show);
    Router.delete('/product/{id}', productController.destroy);
    Router.put('/product/{id}', productController.update);

    // customer
    Router.post('/create-customers', customerController.create);
    Router.get('/customers', customerController.show);
    Router.put('/customers/{cust_id}', customerController.update);
    Router.delete('/customers/{cust_id}', customerController.destroy);
  }
}
