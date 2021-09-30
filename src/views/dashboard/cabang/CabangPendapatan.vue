<template>
  <b-card v-if="data" no-body class="card-revenue-budget">
    <b-row class="mx-0">
      <b-col md="8" class="revenue-report-wrapper">
        <div class="d-sm-flex justify-content-between align-items-center mb-3">
          <h4 class="card-title mb-50 mb-sm-0">
            Revenue Report
          </h4>
          <div class="d-flex align-items-center">
            <div class="d-flex align-items-center mr-2">
              <span class="bullet bullet-primary svg-font-small-3 mr-50 cursor-pointer" />
              <span>Laba Bersih</span>
            </div>
            <div class="d-flex align-items-center ml-75">
              <span class="bullet bullet-warning svg-font-small-3 mr-50 cursor-pointer" />
              <span>Beban</span>
            </div>
          </div>
        </div>

        <!-- chart -->
        <vue-apex-charts id="revenue-report-chart" type="bar" height="230" :options="revenueReport.chartOptions" :series="data.series" />
      </b-col>

      <b-col md="4" class="budget-wrapper">
        <b-dropdown :text="year" size="sm" class="budget-dropdown" variant="outline-primary">
          <b-dropdown-item v-for="year in years" :key="year" @click="yearChange(year)">
            {{ year }}
          </b-dropdown-item>
        </b-dropdown>

        <h2 class="mb-25" v-if="data">{{ data.laba_bersih != null ? formatRupiah(data.laba_bersih) : 'Rp.0' }}</h2>
        <div class="d-flex justify-content-center mb-5">
          <span class="font-weight-bolder mr-25">Laba Bersih Bulan Ini</span>
        </div>

        <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary">
          Increase Budget
        </b-button>
      </b-col>
    </b-row>
  </b-card>
</template>

<script>
import { BCard, BRow, BCol, BDropdown, BDropdownItem, BButton } from 'bootstrap-vue'
import VueApexCharts from 'vue-apexcharts'
import { $themeColors } from '@themeConfig'
import Ripple from 'vue-ripple-directive'
import { formatRupiah } from '@core/utils/filter'

export default {
  components: {
    VueApexCharts,
    BDropdown,
    BDropdownItem,
    BCard,
    BButton,
    BRow,
    BCol,
  },

  directives: {
    Ripple,
  },
  props: {
    data: {
      type: Object,
      default: () => {},
    },
  },
  data() {
    return {
      year: '2021',
      years: ['2021', '2022', '2023'],
      revenue: {
        labaBersih: '0',
        revenueReport: {
          series: [
            {
              name: 'Earning',
              data: [95, 177, 284, 256, 105, 63, 168, 218, 72],
            },
            {
              name: 'Expense',
              data: [-145, -80, -60, -180, -100, -60, -85, -75, -100],
            },
          ],
        },
      },
      revenueReport: {
        chartOptions: {
          chart: {
            stacked: true,
            type: 'bar',
            toolbar: { show: false },
          },
          grid: {
            padding: {
              top: -20,
              bottom: -10,
            },
            yaxis: {
              lines: { show: false },
            },
          },
          xaxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Des'],
            labels: {
              style: {
                colors: '#6E6B7B',
                fontSize: '0.86rem',
                fontFamily: 'Montserrat',
              },
            },
            axisTicks: {
              show: false,
            },
            axisBorder: {
              show: false,
            },
          },
          legend: {
            show: false,
          },
          dataLabels: {
            enabled: false,
          },
          colors: [$themeColors.primary, $themeColors.warning],
          plotOptions: {
            bar: {
              columnWidth: '17%',
              endingShape: 'rounded',
            },
            distributed: true,
          },
          yaxis: {
            labels: {
              style: {
                colors: '#6E6B7B',
                fontSize: '0.86rem',
                fontFamily: 'Montserrat',
              },
            },
          },
        },
      },
    }
  },

  methods: {
    yearChange(x) {
      this.year = x
      this.$emit('tahunLaba', x)
    },
    formatRupiah,
  },
}
</script>
