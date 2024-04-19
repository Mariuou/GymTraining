<script setup lang="ts">
import { ref } from 'vue';
import BaseBreadcrumb from '@/components/shared/BaseBreadcrumb.vue';
import UiParentCard from '@/components/shared/UiParentCard.vue';
import { BasicDatatables, UppercaseFilter,Filtrable } from '@/_mockApis/components/datatable/dataTable';
const page = ref({ title: 'Programas Saludables' });
const breadcrumbs = ref([
    {
        text: 'Training',
        disabled: false,
        href: '#'
    },
    {
        text: '',
        disabled: false,
        href: '#'
    }
]);

/*Header Data*/
const search = ref();
const customsearch = ref();
const headers : any = ref([
    { title: 'Nombre', align: 'start', key: 'name' },
    { title: 'Fecha de creacion', align: 'start', key: 'project' },
    { title: 'Duracion', align: 'start', key: 'post' },
    { title: 'Estatus', align: 'start', key: 'status' },
    { title: 'Porcentaje de avance', align: 'end', key: 'budget' },
])

const filtrable = ref('')

function filterOnlyCapsText(value: { toString: () => string; } | null, query: string | null, item: any) {
    return value != null &&
        query != null &&
        typeof value === 'string' &&
        value.toString().toLocaleUpperCase().indexOf(query) !== -1
}
</script>
<template>
    <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb>
    <v-row>
        <v-col cols="12">
            <UiParentCard title="Registro">
                <v-text-field v-model="search" append-inner-icon="mdi-magnify" label="Buscar" single-line hide-details
                    class="mb-5" />
                <v-data-table items-per-page="5" :headers="headers"  :items="BasicDatatables" :search="search"
                    class="border rounded-md">
                </v-data-table>
            </UiParentCard>

            <!-- <UiParentCard title="Registro" class="mt-6">
                <v-text-field v-model="customsearch" append-inner-icon="mdi-magnify" label="Buscar"
                    single-line hide-details class="mb-5" />
                <v-data-table items-per-page="5" :headers="headers" :items="UppercaseFilter" :search="customsearch"
                    :custom-filter="filterOnlyCapsText" class="border rounded-md">
                </v-data-table>
            </UiParentCard> -->

            <!-- <UiParentCard title="Programas Saludables" class="mt-6">

                <v-card flat>
                    <v-card-title class="d-flex align-center pe-2">
                        
                        thfg

                        <v-spacer></v-spacer>

                        <v-text-field v-model="filtrable" prepend-inner-icon="mdi-magnify" density="compact" label="Buscar"
                            single-line flat hide-details variant="solo-filled"></v-text-field>
                    </v-card-title>

                    <v-divider></v-divider>
                    <v-data-table v-model:search="filtrable" :items="Filtrable">
                        <template v-slot:header.stock>
                            <div class="text-end">Estatus</div>
                        </template>

                        <template v-slot:item.image="{ item }">
                            <v-card class="my-2" elevation="2" rounded>
                                <v-img :src="`${item.image}`"
                                    height="64" cover></v-img>
                            </v-card>
                        </template>

                        <template v-slot:item.rating="{ item }">
                            <v-rating :model-value="item.rating" color="warning" density="compact" size="small"
                                readonly></v-rating>
                        </template>

                        <template v-slot:item.stock="{ item }">
                            <div class="text-end">
                                <v-chip :color="item.stock ? 'success' : 'error'"
                                    :text="item.stock ? 'In stock' : 'Out of stock'" class="text-uppercase" label
                                    size="small"></v-chip>
                            </div>
                        </template>
                    </v-data-table>
                </v-card>

            </UiParentCard> -->


        </v-col>
    </v-row>
</template>

