<script setup lang="ts">
import { ref, onMounted } from 'vue';
import axios from 'axios';
const page = ref({ title: 'Programas saludables' });
const search = ref('');
const headers = ref([
  { title: 'Nombre', align: 'start', key: 'name' },
  { title: 'Fecha de creacion', align: 'start', key: 'project' },
  { title: 'Duracion', align: 'start', key: 'post' },
  { title: 'Estatus', align: 'start', key: 'status' },
  { title: 'Porcentaje de avance', align: 'end', key: 'budget' }
]);
const programasSaludables = ref([]);

async function fetchProgramasSaludables() {
  try {
    const response = await axios.get('http://127.0.0.1:8000/gimnasio/api/v1programas_saludables/');
    return response.data;
  } catch (error) {
    console.error('Error al obtener datos de la API:', error);
    return []; // Devuelve una matriz vacía en caso de error
  }
}

onMounted(async () => {
  programasSaludables.value = await fetchProgramasSaludables();
});
</script>

<template>
  <!-- <BaseBreadcrumb :title="page.title" :breadcrumbs="breadcrumbs"></BaseBreadcrumb> -->
  <v-row>
    <v-col cols="12">
      <UiParentCard title="Registro">
        <v-text-field v-model="search" append-inner-icon="mdi-magnify" label="Buscar" single-line hide-details class="mb-5" />
        <v-data-table items-per-page="5"  :items="programasSaludables" :search="search" class="border rounded-md">
        </v-data-table>
      </UiParentCard>
    </v-col>
  </v-row>
</template>
