import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import '../models/umkm_model.dart';

class UmkmView extends StatelessWidget {
  const UmkmView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UmkmController());

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar UMKM")),
      body: Obx(() {
        if (controller.isLoading.value && controller.umkmList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.umkmList.isEmpty) {
          return const Center(child: Text("Belum ada data UMKM"));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchUmkm,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controller.umkmList.length,
            itemBuilder: (context, index) {
              final item = controller.umkmList[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(item.id?.toString() ?? "?"),
                  ),
                  title: Text(item.namaUmkm),
                  subtitle: Text(
                    "${item.kategori ?? '-'} | ${item.alamat ?? '-'}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            Get.toNamed('/umkm/form', arguments: item),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(controller, item),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/umkm/form'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(UmkmController controller, Umkm item) {
    Get.defaultDialog(
      title: "Hapus UMKM",
      middleText: "Yakin ingin menghapus ${item.namaUmkm}?",
      textConfirm: "Hapus",
      textCancel: "Batal",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        controller.deleteUmkm(item.id!);
      },
    );
  }
}
