import 'package:get/get.dart';

import '../models/umkm_model.dart';
import '../services/service.dart';

class UmkmController extends GetxController {
  var umkmList = <Umkm>[].obs;
  var isLoading = true.obs;
  var responseMessage = ''.obs;

  final UmkmService _service = UmkmService();

  @override
  void onInit() {
    fetchUmkm();
    super.onInit();
  }

  // GET
  Future<void> fetchUmkm() async {
    try {
      isLoading(true);
      var result = await _service.getUmkmList();
      umkmList.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data: $e");
    } finally {
      isLoading(false);
    }
  }

  // POST (mengembalikan true jika berhasil)
  Future<bool> createUmkm({
    required String nama,
    String? kategori,
    String? pemilik,
    String? alamat,
    String? kontak,
  }) async {
    isLoading(true);
    responseMessage('');
    try {
      final result = await _service.createUmkm({
        'nama_umkm': nama,
        'kategori': kategori ?? '',
        'pemilik': pemilik ?? '',
        'alamat': alamat ?? '',
        'kontak': kontak ?? '',
      });
      responseMessage.value = result['message'] ?? 'Data berhasil disimpan';
      await fetchUmkm();
      return true;
    } catch (e) {
      responseMessage.value = 'Error: $e';
      return false;
    } finally {
      isLoading(false);
    }
  }

  // PUT (mengembalikan true jika berhasil)
  Future<bool> updateUmkm({
    required int id,
    required String nama,
    String? kategori,
    String? pemilik,
    String? alamat,
    String? kontak,
  }) async {
    isLoading(true);
    responseMessage('');
    try {
      final result = await _service.updateUmkm(id, {
        'nama_umkm': nama,
        'kategori': kategori ?? '',
        'pemilik': pemilik ?? '',
        'alamat': alamat ?? '',
        'kontak': kontak ?? '',
      });
      responseMessage.value = result['message'] ?? 'Data berhasil diubah';
      await fetchUmkm();
      return true;
    } catch (e) {
      responseMessage.value = 'Error: $e';
      return false;
    } finally {
      isLoading(false);
    }
  }

  // DELETE
  Future<void> deleteUmkm(int id) async {
    try {
      final result = await _service.deleteUmkm(id);
      Get.snackbar("Berhasil", result['message'] ?? 'Data berhasil dihapus');
      await fetchUmkm();
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus data: $e");
    }
  }
}
