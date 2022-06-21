export default [
  {
    header: 'Master Data',
    resource: 'header',
  },
  {
    title: 'Barang',
    icon: 'ShieldIcon',
    resource: 'master_barang',
    children: [
      {
        resource: 'master_barang',
        title: 'Daftar',
        route: 'master-barang-daftar',
      },
      {
        resource: 'master_barang',
        title: 'Ubah Harga',
        route: 'master-barang-harga',
      },
    ],
  },
  {
    title: 'Kontak',
    route: 'master-kontak',
    icon: 'ShieldIcon',
    resource: 'master_kontak',
  },
  {
    title: 'Persediaan',
    route: 'master-persediaan',
    icon: 'ShieldIcon',
    resource: 'master_persediaan',
  },
  {
    title: 'Gudang',
    route: 'master-gudang',
    icon: 'ShieldIcon',
    resource: 'master_gudang',
  },
  {
    title: 'Cabang',
    icon: 'ShieldIcon',
    children: [
      {
        title: 'Daftar',
        route: 'master-cabang-daftar',
        resource: 'master_cabang',
      },
      {
        title: 'Performance',
        route: 'master-cabang-performance',
        resource: 'master_cabang',
      },
      {
        title: 'Setoran',
        route: 'master-cabang-setoran',
        resource: 'master_cabang',
      },
    ],
  },
]
