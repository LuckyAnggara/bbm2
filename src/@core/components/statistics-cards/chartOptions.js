import { $themeColors } from '@themeConfig'

export const areaChartLabel = {
  grid: {
    show: false,
    padding: {
      left: 0,
      right: 0,
    },
  },
  chart: {
    toolbar: {
      show: false,
    },
    sparkline: {
      enabled: true,
    },
  },
  dataLabels: {
    enabled: false,
  },
  stroke: {
    curve: 'smooth',
    width: 2.5,
  },
  fill: {
    type: 'gradient',
    gradient: {
      shadeIntensity: 0.9,
      opacityFrom: 0.5,
      opacityTo: 0.2,
      stops: [0, 80, 100],
    },
  },

  theme: {
    monochrome: {
      enabled: true,
      shadeTo: 'light',
      shadeIntensity: 0.65,
    },
  },
  xaxis: {
    type: 'String',
    categories: [],
  },
}

export const areaChartOptions = {
  grid: {
    show: false,
    padding: {
      left: 0,
      right: 0,
    },
  },
  chart: {
    toolbar: {
      show: false,
    },
    sparkline: {
      enabled: true,
    },
  },
  dataLabels: {
    enabled: false,
  },
  stroke: {
    curve: 'smooth',
    width: 2.5,
  },
  fill: {
    type: 'gradient',
    gradient: {
      shadeIntensity: 0.9,
      opacityFrom: 0.5,
      opacityTo: 0.2,
      stops: [0, 80, 100],
    },
  },
  xaxis: {
    type: 'numeric',
    lines: {
      show: false,
    },
    axisBorder: {
      show: false,
    },
    labels: { show: false },
  },
  yaxis: [
    {
      y: 0,
      offsetX: 0,
      offsetY: 0,
      padding: {
        left: 0,
        right: 0,
      },
    },
  ],
  tooltip: {
    x: { show: false },
  },
  theme: {
    monochrome: {
      enabled: true,
      color: $themeColors.primary,
      shadeTo: 'light',
      shadeIntensity: 0.65,
    },
  },
}

export const lineChartOptions = {
  grid: {
    show: false,
    padding: {
      left: 0,
      right: 0,
    },
  },
  chart: {
    type: 'line',
    dropShadow: {
      enabled: true,
      top: 5,
      left: 0,
      blur: 4,
      opacity: 0.1,
    },
    toolbar: {
      show: false,
    },
    sparkline: {
      enabled: true,
    },
  },
  stroke: {
    width: 5,
    curve: 'smooth',
  },
  xaxis: {
    type: 'numeric',
  },
  colors: [$themeColors.primary],
  fill: {
    type: 'gradient',
    gradient: {
      shade: 'dark',
      gradientToColors: ['#A9A2F6'],
      shadeIntensity: 1,
      type: 'horizontal',
      opacityFrom: 1,
      opacityTo: 1,
      stops: [0, 100, 100, 100],
    },
  },
  markers: {
    size: 0,
    hover: {
      size: 5,
    },
  },
  tooltip: {
    x: { show: false },
  },
}

export const donutChartOptions = {
  chart: {
    type: 'donut',
    toolbar: {
      show: false,
    },
  },
  dataLabels: {
    enabled: false,
  },
  legend: { show: false },
  comparedResult: [2, -3, 8],
  labels: [],
  stroke: { width: 0 },
  colors: ['#28c76f33', '#28c76f66', $themeColors.success],
  grid: {
    padding: {
      right: -20,
      bottom: -8,
      left: -20,
    },
  },
  plotOptions: {
    pie: {
      startAngle: -10,
      donut: {
        labels: {
          show: true,
          name: {
            offsetY: 15,
          },
          value: {
            offsetY: -15,
            formatter(val) {
              // eslint-disable-next-line radix
              return `${parseInt(val)}%`
            },
          },
        },
      },
    },
  },
  responsive: [
    {
      breakpoint: 1325,
      options: {
        chart: {
          height: 100,
        },
      },
    },
    {
      breakpoint: 1200,
      options: {
        chart: {
          height: 120,
        },
      },
    },
    {
      breakpoint: 1045,
      options: {
        chart: {
          height: 100,
        },
      },
    },
    {
      breakpoint: 992,
      options: {
        chart: {
          height: 120,
        },
      },
    },
  ],
}
