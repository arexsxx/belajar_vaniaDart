import 'package:vania/vania.dart';
import 'package:vania_api/app/models/product.dart';

class ProductController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create(Request req) async {
    req.validate({
      'name': 'required|String',
      'description': 'required',
      'price': 'required',
    }, {
      'name.required': 'Nama tidak boleh kosong',
      'name.string': 'Nama tidak boleh angka',
      'description.required': 'Nama tidak boleh kosong',
      'price.required': 'Nama tidak boleh kosong',
    });
    final dataProduct = req.input();
    dataProduct['created_at'] = DateTime.now().toIso8601String();

    final existingProduct =
        await Product().query().where('name', '=', dataProduct['name']).first();
    if (existingProduct != null) {
      return Response.json({
        "message": "produk sudah ada",
      }, 409);
    }

    await Product().query().insert(dataProduct);

    return Response.json(
      {
        "message": "success",
        "data": dataProduct,
      },
      200,
    );
  }

  Future<Response> show(Request req, int id) async {
    try {
      print('Mencari product berdasarkan id:$id');
      final listProduct = await Product().query().where('id', '=', id).first();

      if (listProduct == null) {
        print('Produk dengan ID $id tidak ditemukan.');
        return Response.json({'message': 'Produk tidak ditemukan.'});
      }

      print('Product ditemukan: $listProduct');

      return Response.json({
        'message': 'Produk ditemukan',
        'data': listProduct,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan saat mengambil data produk.',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request req, int id) async {
    try {
      req.validate({
        'name': 'String',
        'description': 'String',
        'price': 'numeric',
      }, {
        'name.string': 'Nama harus berupa string.',
        'description.string': 'Deskripsi harus berupa string.',
        'price.numeric': 'Harga harus berupa angka.',
      });

      // Cari produk berdasarkan ID
      final product = await Product().query().where('id', '=', id).first();

      if (product == null) {
        return Response.json({
          'message': 'Produk dengan ID $id tidak ditemukan.',
        }, 404);
      }

      final updateData = req.input();

      updateData['updated_at'] = DateTime.now().toIso8601String();

      // Update data produk
      await Product().query().where('id', '=', id).update(updateData);


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
      final product = await Product().query().where('id', '=', id).first();

      if (product == null) {
        return Response.json({
          'message': 'Produk dengan ID $id tidak ditemukan.',
        }, 404);
      }

      // Hapus produk
      await Product().query().where('id', '=', id).delete();
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

final ProductController productController = ProductController();
