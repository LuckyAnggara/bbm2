export default [
  {
    header: 'Manajemen',
  },
  {
    title: 'Barang',
    icon: 'ShieldIcon',
    // acl: {
    // },
    resource: 'admin',
    children: [
      {
        title: 'Daftar',
        route: 'master-barang-daftar',
      },
      {
        title: 'Ubah Harga',
        route: 'master-barang-harga',
      },
    ],
  },
  {
    title: 'Kontak',
    route: 'master-kontak',
    icon: 'ShieldIcon',
    // acl: {
    // action: 'read',
    // resource: 'ACL',
    // },
  },
  {
    title: 'Persediaan',
    route: 'master-persediaan',
    icon: 'ShieldIcon',
    // acl: {
    // action: 'read',
    // resource: 'ACL',
    // },
  },
  {
    title: 'Gudang',
    route: 'master-gudang',
    icon: 'ShieldIcon',
    // acl: {
    // action: 'read',
    // resource: 'ACL',
    // },
  },
  {
    title: 'Cabang',
    route: 'master-persediaan',
    icon: 'ShieldIcon',
    children: [
      {
        title: 'Performance',
        route: 'master-cabang-performance',
      },
      {
        title: 'Setoran',
        route: 'master-cabang-setoran',
      },
    ],
    // acl: {
    // action: 'read',
    // resource: 'ACL',
    // },
  },
]
