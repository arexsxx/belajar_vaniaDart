import 'package:vania/vania.dart';
import 'package:vania_api/app/models/customer.dart';

class CustomerController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create(Request req) async {
    req.validate({
      'cust_id': 'required|string|max_length:5',
      'cust_name': 'required|string|max_length:50',
      'cust_address': 'required|string|max_length:100',
      'cust_city': 'required|string|max_length:50',
      'cust_state': 'required|string|max_length:25',
      'cust_zip': 'required|string|max_length:7',
      'cust_country': 'required|string|max_length:25',
      'cust_telp': 'required|string|max_length:15',
    }, {
      'cust_id.required': 'tidak boleh kosong',
      'cust_name.string': 'tidak boleh kosong',
      'cust_address.required': 'tidak boleh kosong',
      'cust_city.required': 'tidak boleh kosong',
      'cust_state.required': 'tidak boleh kosong',
      'cust_zip.required': 'tidak boleh kosong',
      'cust_country.required': 'tidak boleh kosong',
      'cust_telp.required': 'tidak boleh kosong',
    });
    final dataCustomer = req.input();

    final existingCustomer = await Customer()
        .query()
        .where('cust_name', '=', dataCustomer['cust_name'])
        .first();
    if (existingCustomer != null) {
      return Response.json({
        "message": "produk sudah ada",
      }, 409);
    }

    await Customer().query().insert(dataCustomer);

    return Response.json(
      {
        "message": "success",
        "data": dataCustomer,
      },
      200,
    );
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show() async {
    final dataProduct = await Customer().query().get();
    return Response.json({
      'message': 'succes',
      'data': dataProduct,
    }, 200);
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request req, int id) async {
    try {
      req.validate({
        'cust_id': 'required|string|max_length:5',
        'cust_name': 'required|string|max_length:50',
        'cust_address': 'required|string|max_length:100',
        'cust_city': 'required|string|max_length:50',
        'cust_state': 'required|string|max_length:25',
        'cust_zip': 'required|string|max_length:7',
        'cust_country': 'required|string|max_length:25',
        'cust_telp': 'required|string|max_length:15',
      }, {
        'cust_id.required': 'tidak boleh kosong',
        'cust_name.string': 'tidak boleh kosong',
        'cust_address.required': 'tidak boleh kosong',
        'cust_city.required': 'tidak boleh kosong',
        'cust_state.required': 'tidak boleh kosong',
        'cust_zip.required': 'tidak boleh kosong',
        'cust_country.required': 'tidak boleh kosong',
        'cust_telp.required': 'tidak boleh kosong',
      });

      // Cari produk berdasarkan ID
      final customer =
          await Customer().query().where('cust_id', '=', id).first();

      if (customer == null) {
        return Response.json({
          'message': 'Produk dengan ID $id tidak ditemukan.',
        }, 404);
      }

      final updateData = req.input();
      // Update data produk
      await Customer().query().where('cust_id', '=', id).update(updateData);

      return Response.json({
        'message': 'Produk berhasil diperbarui.',
        'data': updateData,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat memperbarui produk.',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> destroy(int id) async {
    try {
      // Cari produk berdasarkan ID
      final product = await Customer().query().where('cust_id', '=', id).first();

      if (product == null) {
        return Response.json({
          'message': 'Produk dengan ID $id tidak ditemukan.',
        }, 404);
      }

      // Hapus produk
      await Customer().query().where('cust_id', '=', id).delete();
      return Response.json({
        'message': 'Produk berhasil dihapus.',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat menghapus produk.',
        'error': e.toString(),
      }, 500);
    }
  }
}

final CustomerController customerController = CustomerController();
