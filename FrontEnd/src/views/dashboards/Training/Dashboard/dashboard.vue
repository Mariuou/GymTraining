<script setup lang="ts">
import { computed } from 'vue';
import { useTheme } from 'vuetify';
import { getPrimary, getSecondary } from '@/utils/UpdateColors';
import { ref } from 'vue';

// common components
import BaseBreadcrumb from '@/components/shared/BaseBreadcrumb.vue';
import UiParentCard from '@/components/shared/UiParentCard.vue';
import UiChildCard from '@/components/shared/UiChildCard.vue';
// theme breadcrumb
const page = ref({ title: 'Programa de seguimiento' });
const breadcrumbs = ref([
    {
        text: 'Training',
        disabled: false,
        href: '#'
    },
]);

const theme = useTheme();
const success = theme.current.value.colors.success;
const accent = theme.current.value.colors.accent;
const warning = theme.current.value.colors.warning;

const donutchartOptions = computed(() => {
    return {
        chart: {
            type: 'donut',
            height: 300,
            fontFamily: `inherit`,
            foreColor: '#adb0bb',
        },
        dataLabels: {
            enabled: false
        },
        plotOptions: {
            pie: {
                donut: {
                    size: '70px'
                }
            }
        },
        legend: {
            show: true,
            position: 'bottom',
            width: '50px'
        },
        colors: ['#6ac3fd', '#0b70fb', '#f64e60', '#26c6da', '#ffa800'],
        responsive: [
            {
                breakpoint: 480,
                options: {
                    chart: {
                        width: 200
                    },
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        ]
    };
});

const donutChart = {
    series: [44, 55, 41, 17, 15]
};

const piechartOptions = computed(() => {
    return {
        chart: {
            type: 'pie',
            height: 300,
            fontFamily: `inherit`,
            foreColor: '#adb0bb',
            toolbar: {
                show: false
            }
        },
        dataLabels: {
            enabled: false
        },
        plotOptions: {
            pie: {
                donut: {
                    size: '70px'
                }
            }
        },
        legend: {
            show: true,
            position: 'bottom',
            width: '50px'
        },
        colors: ['#6ac3fd', '#0b70fb', '#f64e60', '#26c6da', '#ffa800'],
        tooltip: {
            fillSeriesColor: false
        },
        labels: ['Team A', 'Team B', 'Team C', 'Team D', 'Team E'],
        responsive: [
            {
                breakpoint: 480,
                options: {
                    chart: {
                        width: 200
                    },
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        ]
    };
});

const pieChart = {
    series: [44, 55, 13, 43, 22]
};

const chartOptions = computed(() => {
    return {
        chart: {
            type: 'bar',
            height: 350,
            fontFamily: `inherit`,
            foreColor: '#adb0bb',
            toolbar: {
              show: false,
            },
        },
        colors: ['#6ac3fd', '#0b70fb', '#f64e60'],
        plotOptions: {
            bar: {
                horizontal: false,
                endingShape: 'rounded',
                columnWidth: '20%'
            }
        },
        dataLabels: {
            enabled: false,
        },
        stroke: {
            show: true,
            width: 2,
            colors: ['transparent']
        },

        xaxis: {
            categories: ['Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct']
        },
        yaxis: {
          title: {
            text: '$ (thousands)',
          },
        },
        fill: {
            opacity: 1
        },
       
        tooltip: {
            theme: 'dark',
            y: {
              formatter(val:any) {
                return `$ ${val} thousands`;
              },
            },
        },
        grid: {
          show: false,
        },
        legend: {
          show: true,
          position: 'bottom',
          width: '50px',
        },
        responsive: [
            {
                breakpoint: 600,
                options: {
                    yaxis: {
                        show: false
                    }
                }
            }
        ]
    };
});

const columnChart = {
    series: [
        {
            name: 'Desktop',
            data: [44, 55, 57, 56, 61, 58, 63, 60, 66]
        },
        {
            name: 'Mobile',
            data: [76, 85, 101, 98, 87, 105, 91, 114, 94]
        },
        {
            name: 'Other',
            data: [35, 41, 36, 26, 45, 48, 52, 53, 41]
        }
    ]
};
const gredientChart = {
    series: [
        {
            name: 'Likes',
            data: [4, 3, 10, 9, 35, 19, 22, 9, 12, 7, 19, 5, 13, 9, 17, 2, 7, 5]
        }
    ]
};

const chartOptions2 = computed(() => {
    return {
        chart: {
            type: 'line',
            height: 350,
            fontFamily: `inherit`,
            foreColor: '#adb0bb',
            toolbar: {
                show: false
            },
            dropShadow: {
                enabled: true,
                color: 'rgba(0,0,0,0.2)',
                top: 12,
                left: 4,
                blur: 3,
                opacity: 0.4
            }
        },
        stroke: {
            width: 7,
            curve: 'smooth'
        },

        xaxis: {
            type: 'datetime',
            categories: [
                '1/11/2000',
                '2/11/2000',
                '3/11/2000',
                '4/11/2000',
                '5/11/2000',
                '6/11/2000',
                '7/11/2000',
                '8/11/2000',
                '9/11/2000',
                '10/11/2000',
                '11/11/2000',
                '12/11/2000',
                '1/11/2001',
                '2/11/2001',
                '3/11/2001',
                '4/11/2001',
                '5/11/2001',
                '6/11/2001'
            ]
        },  
        fill: {
            type: 'gradient',
            gradient: {
                shade: 'dark',
                gradientToColors: ['#0b70fb'],
                shadeIntensity: 1,
                type: 'horizontal',
                opacityFrom: 1,
                opacityTo: 0.9,
                stops: [0, 100, 100, 100]
            }
        },
        markers: {
            size: 4,
            opacity: 0.9,
            colors: ['#4e79ff'],
            strokeColor: '#fff',
            strokeWidth: 2,

            hover: {
                size: 7
            }
        },
        yaxis: {
            min: 0,
            max: 40
        },
        grid: {
            show: false
        },
        tooltip: {
            theme: 'light'
        }
    };
});
</script>

<template>
     <!-- <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb> -->
    <v-row>
        <v-col cols="12">
            <UiParentCard title="Rutinas">
                <apexchart type="bar" height="300" :options="chartOptions" :series="columnChart.series"> </apexchart>
            </UiParentCard>
        </v-col>
    </v-row>

    <v-row>
        <v-col cols="12">
            <UiParentCard title="Gredient Chart">
                <apexchart type="line" height="350" :options="chartOptions2" :series="gredientChart.series"></apexchart>
            </UiParentCard>
        </v-col>
    </v-row>


    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>
    <v-row>
        <v-col cols="12">
            <v-row>
                <v-col cols="12" lg="6">
                    <!-- ---------------------------------------------------- -->
                    <!-- Donut Chart -->
                    <!-- ---------------------------------------------------- -->
                    <UiChildCard title="Rutinas" class="bg-surface">
                        <apexchart type="donut" height="300" :options="donutchartOptions" :series="donutChart.series"> </apexchart>
                    </UiChildCard>
                </v-col>
                <v-col cols="12" lg="6">
                    <!-- ---------------------------------------------------- -->
                    <!-- Pie Chart -->
                    <!-- ---------------------------------------------------- -->
                    <UiChildCard title="Programas saludables" class="bg-surface">
                        <apexchart type="pie" height="300" :options="piechartOptions" :series="pieChart.series"> </apexchart>
                    </UiChildCard>
                </v-col>
            </v-row>
        </v-col>
    </v-row>
</template>
