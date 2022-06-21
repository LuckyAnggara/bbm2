export default [
  {
    header: 'Transaksi',
    resource: 'header',
  },
  {
    title: 'Penjualan',
    icon: 'HomeIcon',
    children: [
      {
        title: 'Daftar',
        route: 'transaksi-penjualan-daftar',
        resource: 'transaksi_penjualan',
      },
      {
        title: 'Transaksi Baru',
        route: 'transaksi-penjualan-tambah',
        resource: 'transaksi_penjualan',
      },
      {
        title: 'Draft Transaksi',
        route: 'transaksi-penjualan-draft',
        resource: 'transaksi_penjualan',
      },
    ],
  },
  {
    title: 'Pembelian',
    icon: 'HomeIcon',
    children: [
      {
        title: 'Daftar',
        route: 'transaksi-pembelian-daftar',
        resource: 'transaksi_pembelian',
      },
      {
        title: 'Transaksi Baru',
        route: 'transaksi-pembelian-tambah',
        resource: 'transaksi_pembelian',
      },
      {
        title: 'Draft Transaksi',
        route: 'transaksi-pembelian-draft',
        resource: 'transaksi_pembelian',
      },
    ],
  },
  {
    title: 'P.O',
    icon: 'HomeIcon',
    children: [
      {
        title: 'Daftar',
        route: 'transaksi-po-daftar',
        resource: 'transaksi_po',
      },
      {
        title: 'P.O Baru',
        route: 'transaksi-po-tambah',
        resource: 'transaksi_po',
      },
    ],
  },
]
