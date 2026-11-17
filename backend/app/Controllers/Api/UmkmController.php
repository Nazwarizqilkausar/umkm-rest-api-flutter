<?php

namespace App\Controllers\Api;

use App\Models\UmkmModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class UmkmController extends ResourceController
{
    protected $modelName = UmkmModel::class;
    protected $format    = 'json';

    // GET /api/umkm
    public function index(): ResponseInterface
    {
        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil diambil',
            'data'    => $this->model->findAll(),
        ], 200);
    }

    // POST /api/umkm
    public function create(): ResponseInterface
    {
        $data  = $this->request->getPost();
        $rules = [
            'nama_umkm' => 'required|min_length[3]|is_unique[umkm.nama_umkm]',
            'kategori'  => 'permit_empty|string',
            'pemilik'   => 'permit_empty|string',
            'alamat'    => 'permit_empty|string',
            'kontak'    => 'permit_empty|string',
        ];

        $validation = service('validation');
        if (! $validation->setRules($rules)->run($data)) {
            return $this->respond([
                'success' => false,
                'message' => 'Validasi gagal',
                'errors'  => $validation->getErrors(),
            ], 400);
        }

        $id = $this->model->insert($data);
        if ($id === false) {
            return $this->respond([
                'success' => false,
                'message' => 'Gagal menambahkan data UMKM',
                'errors'  => $this->model->errors(),
            ], 500);
        }

        return $this->respondCreated([
            'success' => true,
            'message' => 'Data UMKM berhasil ditambahkan',
            'data'    => $this->model->find($id),
        ]);
    }

    // PUT /api/umkm/{id}
    public function update($id = null): ResponseInterface
    {
        if (! $this->model->find($id)) {
            return $this->respond(['success' => false, 'message' => 'Data UMKM tidak ditemukan'], 404);
        }

        $data = $this->request->getRawInput();
        $this->model->update($id, $data);

        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil diperbarui',
            'data'    => $this->model->find($id),
        ], 200);
    }

    // DELETE /api/umkm/{id}
    public function delete($id = null): ResponseInterface
    {
        $row = $this->model->find($id);
        if (! $row) {
            return $this->respond(['success' => false, 'message' => 'Data UMKM tidak ditemukan'], 404);
        }

        $this->model->delete($id);

        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil dihapus',
            'data'    => ['id' => (int) $row['id'], 'nama_umkm' => $row['nama_umkm']],
        ], 200);
    }
}