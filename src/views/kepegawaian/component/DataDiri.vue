<template>
  <section>
    <div ref="container">
      <template>
        <b-row>
          <b-col lg="9" cols="12">
            <div class="mt-2">
              <table class="mt-xl-0 w-100">
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Nama Lengkap</span>
                  </th>
                  <td class="pb-50">
                    {{ dataDiri.nama }}
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Jenis Kelamin</span>
                  </th>
                  <td class="pb-50 text-capitalize">
                    {{ dataDiri.jenis_kelamin }}
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Tanggal Lahir</span>
                  </th>
                  <td class="pb-50 text-capitalize">
                    {{ $moment(dataDiri.tanggal_lahir).format('D MMMM Y') }}
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Pendidikan Terakhir</span>
                  </th>
                  <td class="pb-50">
                    {{ dataDiri.pendidikan_terakhir }}
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Nomor Telepon</span>
                  </th>
                  <td class="pb-50">
                    {{ dataDiri.nomor_telepon }}
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Nomor Rekening</span>
                  </th>
                  <td class="pb-50">
                    {{ dataDiri.nomor_rekenig }}
                  </td>
                </tr>
                <hr />
                <tr>
                  <th>
                    <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                    <span class="font-weight-bold">Tanggal Mulai Bekerja</span>
                  </th>
                  <td>
                    {{ `${$moment(dataDiri.tanggal_masuk).format('D MMMM YYYY')}` }}
                  </td>
                  .
                </tr>
                <tr>
                  <th>
                    <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                    <span class="font-weight-bold">Penempatan</span>
                  </th>
                  <td>
                    {{ dataDiri.cabang }}
                  </td>
                </tr>
                <tr>
                  <th>
                    <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                    <span class="font-weight-bold">Jabatan</span>
                  </th>
                  <td>
                    {{ dataDiri.jabatan }}
                  </td>
                </tr>
                <tr>
                  <th>
                    <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                    <span class="font-weight-bold">Divisi</span>
                  </th>
                  <td>
                    {{ dataDiri.divisi }}
                  </td>
                </tr>
              </table>
            </div>
          </b-col>
        </b-row>
      </template>
    </div>
  </section>
</template>

<script>
import { BRow, BCol } from 'bootstrap-vue'

export default {
  components: {
    BRow,
    BCol,
  },
  data() {
    return {}
  },
  props: {
    dataDiri: {
      type: Object,
      required: true,
    },
  },
}
</script>

<style></style>
