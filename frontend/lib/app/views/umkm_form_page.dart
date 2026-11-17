import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import '../models/umkm_model.dart';

class UmkmFormPage extends StatefulWidget {
  const UmkmFormPage({super.key});

  @override
  State<UmkmFormPage> createState() => _UmkmFormPageState();
}

class _UmkmFormPageState extends State<UmkmFormPage> {
  final UmkmController controller = Get.find<UmkmController>();
  final _formKey = GlobalKey<FormState>();

  final namaC = TextEditingController();
  final pemilikC = TextEditingController();
  final alamatC = TextEditingController();
  final kategoriC = TextEditingController();
  final kontakC = TextEditingController();

  Umkm? editItem;

  bool get isEdit => editItem != null;

  @override
  void initState() {
    super.initState();
    controller.responseMessage('');
    editItem = Get.arguments as Umkm?;
    if (editItem != null) {
      namaC.text = editItem!.namaUmkm;
      pemilikC.text = editItem!.pemilik ?? '';
      alamatC.text = editItem!.alamat ?? '';
      kategoriC.text = editItem!.kategori ?? '';
      kontakC.text = editItem!.kontak ?? '';
    }
  }

  @override
  void dispose() {
    namaC.dispose();
    pemilikC.dispose();
    alamatC.dispose();
    kategoriC.dispose();
    kontakC.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    bool ok;
    if (isEdit) {
      ok = await controller.updateUmkm(
        id: editItem!.id!,
        nama: namaC.text.trim(),
        kategori: kategoriC.text.trim(),
        pemilik: pemilikC.text.trim(),
        alamat: alamatC.text.trim(),
        kontak: kontakC.text.trim(),
      );
    } else {
      ok = await controller.createUmkm(
        nama: namaC.text.trim(),
        kategori: kategoriC.text.trim(),
        pemilik: pemilikC.text.trim(),
        alamat: alamatC.text.trim(),
        kontak: kontakC.text.trim(),
      );
    }

    if (ok) {
      Get.back();
      Get.snackbar("Berhasil", controller.responseMessage.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit UMKM' : 'Tambah UMKM')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaC,
                decoration: const InputDecoration(
                  labelText: 'Nama UMKM',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().length < 3) {
                    return 'Nama UMKM minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: pemilikC,
                decoration: const InputDecoration(
                  labelText: 'Pemilik',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: alamatC,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: kategoriC,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: kontakC,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Kontak',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
                  ),
                );
              }),
              const SizedBox(height: 16),
              Obx(
                () => Text(
                  controller.responseMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
