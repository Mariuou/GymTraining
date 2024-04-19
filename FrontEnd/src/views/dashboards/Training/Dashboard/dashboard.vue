<script setup lang="ts">
import { ref } from 'vue';
/* Breadcrumb component */
import BaseBreadcrumb from '@/components/shared/BaseBreadcrumb.vue';

/*Call Components*/
import Followers from '@/components/widgets/charts/Followers.vue';
import Views from '@/components/widgets/charts/Views.vue';
import Earned from '@/components/widgets/charts/Earned.vue';
import TotalEarning from '@/components/widgets/charts/TotalEarning.vue';
import CurrentValue from '@/components/widgets/charts/CurrentValue.vue';
import MostVisited from '@/components/widgets/charts/MostVisited.vue';
import PageImpression from '@/components/widgets/charts/PageImpression.vue';
import YearlyBreakup from '@/components/widgets/charts/YearlyBreakup.vue';
import MonthlyEarnings from '@/components/widgets/charts/MonthlyEarnings.vue';
import YearlySales from '@/components/widgets/charts/YearlySales.vue';
import RevenueUpdates from '@/components/widgets/charts/RevenueUpdates.vue';
import SalesOverview from '@/components/widgets/charts/SalesOverview.vue';
import Customers from "@/components/widgets/charts/Customers.vue";
import Projects from "@/components/widgets/charts/Projects.vue";

// theme breadcrumb
const page = ref({ title: 'Dashboard de seguimiento' });
const breadcrumbs = ref([
    {
        text: 'programas saludables',
        disabled: false,
        href: '#'
    },
    {
        text: 'training',
        disabled: true,
        href: '#'
    }
]);
</script>
<template>
    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>        
    <v-row>
        <!-- Followers Chart -->
        
        <!-- Views Chart -->
        <!-- <v-col cols="12" sm="3">
            <Views />
        </v-col> -->
        <!-- Earned Chart -->
        <!-- <v-col cols="12" sm="3">
            <Earned />
        </v-col> -->
        <!-- TotalEarning Chart -->
        <!-- <v-col cols="12" sm="3">
            <TotalEarning />
        </v-col> -->
        <!-- Current Value -->
        <v-col cols="12">
            <!-- <CurrentValue /> -->
                <YearlyBreakup />
            <MonthlyEarnings />
                    <SalesOverview />
        </v-col>
        <v-col cols="12" sm="3">
            <Followers />
        </v-col>
        <v-col cols="12" md="4">
            <!-- Yearly Breakup -->
            <!-- Monthly Earnings -->
           
            <!-- Most Visited -->
            <!-- <MostVisited /> -->
        </v-col>
        <v-col cols="12" md="4">
            <!-- Yearly Sales -->
            <!-- <YearlySales /> -->
            <!-- Page Impression -->
            <!-- <PageImpression /> -->
            <v-row class="mt-3">
                <v-col cols="12" sm="6">
                    <!-- <Customers /> -->
                </v-col>
                <v-col cols="12" sm="6">
                    <!-- <Projects /> -->
                </v-col>
            </v-row>
        </v-col>
        <v-col cols="12" md="4">
            <v-row>
                <!-- Revenue Updates -->
                <v-col cols="12">
                </v-col>
                <RevenueUpdates />
                <!-- Sales Overview -->
                <v-col cols="12">
                </v-col>
            </v-row>
        </v-col>
    </v-row>
</template>
