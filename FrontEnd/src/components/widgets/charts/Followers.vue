<script setup lang="ts">
import { computed } from 'vue';
import { getSecondary,getPrimary } from '@/utils/UpdateColors';
/* Chart */
const chartOptions = computed(() => {
    return {
        chart: {
            type: 'area',
            fontFamily: `inherit`,
            foreColor: '#adb0bb',
            toolbar: {
                show: false
            },
            sparkline: {
                enabled: true
            },
            group: 'sparklines'
        },
        colors: [getPrimary.value],
        stroke: {
           curve: 'straight',
           width: 2
        },
         tooltip: {
            theme: 'dark',
            x: {
                format: 'dd/MM/yy HH:mm'
            }
        }
    };
});

const Chart = {
    series: [
        {
            name:'',
            data: [0, 150, 110, 240, 200, 200, 300, 200],
        }
    ]
};
</script>
<template>
    <v-card elevation="10" >
        <v-card-item>
            <h4 class="text-h4 mt-1">Nivel de avance</h4>
            <div class="d-flex justify-space-between mt-1">
                <h6 class="text-subtitle-1 text-medium-emphasis">de rutinas</h6>
                <h6 class="text-subtitle-1 text-success">70%</h6>
            </div>
        </v-card-item>
        <apexchart class="mt-4" type="area" height="88" :options="chartOptions" :series="Chart.series"> </apexchart>
    </v-card>
</template>
