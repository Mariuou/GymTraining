<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useContactStore } from '@/stores/apps/contact';

import contact from '@/_mockApis/apps/contact';

const store = useContactStore();

onMounted(() => {
    store.fetchContacts();
});
const getContacts: any = computed(() => {
    return store.contacts;
});

const valid = ref(true);
const dialog = ref(false);
const search = ref('');
const resultadossbg = ref(['primary', 'secondary', 'error', 'success', 'warning']);
const desserts = ref(contact);
const editedIndex = ref(-1);
const editedItem = ref({
    id: '',
    avatar: '1.jpg',
    fecha_a: '',
    usermail: '',
    phone: '',
    estatus: '',
    resultados: '',
    resultadosstatus: ''
});
const defaultItem = ref({
    id: '',
    avatar: '1.jpg',
    fecha_a: '',
    usermail: '',
    phone: '',
    estatus: '',
    resultados: '',
    resultadosstatus: ''
});

//Methods
const filteredList = computed(() => {
    return desserts.value.filter((user: any) => {
        return user.fecha_a.toLowerCase().includes(search.value.toLowerCase());
    });
});

function editItem(item: any) {
    editedIndex.value = desserts.value.indexOf(item);
    editedItem.value = Object.assign({}, item);
    dialog.value = true;
}
function deleteItem(item: any) {
    const index = desserts.value.indexOf(item);
    confirm('Are you sure you want to delete this item?') && desserts.value.splice(index, 1);
}

function close() {
    dialog.value = false;
    setTimeout(() => {
        editedItem.value = Object.assign({}, defaultItem.value);
        editedIndex.value = -1;
    }, 300);
}
function save() {
    if (editedIndex.value > -1) {
        Object.assign(desserts.value[editedIndex.value], editedItem.value);
    } else {
        desserts.value.push(editedItem.value);
    }
    close();
}

//Computed Property
const formTitle = computed(() => {
    return editedIndex.value === -1 ? 'Agregar Rutina' : 'Editar Rutina';
});
</script>
<template>
    <v-row>
        <v-col cols="12" lg="4" md="6">
            <v-text-field density="compact" v-model="search" label="Buscar Rutinas" hide-details variant="outlined"></v-text-field>
        </v-col>
        <v-col cols="12" lg="8" md="6" class="text-right">
            <v-dialog v-model="dialog" max-width="500">
                <template v-slot:activator="{ props }">
                    <v-btn color="primary" v-bind="props" flat class="ml-auto">
                        <v-icon class="mr-2">mdi-account-multiple-plus</v-icon>Agregar Rutinas
                    </v-btn>
                </template>
                <v-card>
                    <v-card-title class="pa-4 bg-secondary">
                        <span class="title text-white">{{ formTitle }}</span>
                    </v-card-title>

                    <v-card-text>
                        <v-form ref="form" v-model="valid" lazy-validation>
                            <v-row>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="editedItem.id" label="Id"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field
                                        variant="outlined"
                                        hide-details
                                        v-model="editedItem.fecha_a"
                                        label="Fecha de asignacion"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field
                                        variant="outlined"
                                        hide-details
                                        v-model="editedItem.usermail"
                                        label="Nobre de Rutina"
                                        type="email"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field
                                        variant="outlined"
                                        hide-details
                                        v-model="editedItem.phone"
                                        label="Fecha de Termino"
                                        type="phone"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field
                                        variant="outlined"
                                        hide-details
                                        v-model="editedItem.estatus"
                                        label="estatus"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                    <v-text-field variant="outlined" hide-details v-model="editedItem.resultados" label="resultados"></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="12">
                                    <v-select
                                        variant="outlined"
                                        hide-details
                                        :items="resultadossbg"
                                        v-model="editedItem.resultadosstatus"
                                        label="Tipo de seguimiento de rutina"
                                    ></v-select>
                                </v-col>
                            </v-row>
                        </v-form>
                    </v-card-text>

                    <v-card-actions class="pa-4">
                        <v-spacer></v-spacer>
                        <v-btn color="error" @click="close">Cancel</v-btn>
                        <v-btn
                            color="secondary"
                            :disabled="editedItem.fecha_a == '' || editedItem.usermail == ''"
                            variant="flat"
                            @click="save"
                            >Save</v-btn
                        >
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </v-col>
    </v-row>
    <v-table class="mt-5">
        <thead>

            <tr>
                <th class="text-subtitle-1 font-weight-semibold">Id</th>
                <th class="text-subtitle-1 font-weight-semibold">Fecha asignacion</th>
                <th class="text-subtitle-1 font-weight-semibold">Fecha Termino</th>
                <th class="text-subtitle-1 font-weight-semibold">Estatus</th>
                <th class="text-subtitle-1 font-weight-semibold">Resultados esperados</th>
                <th class="text-subtitle-1 font-weight-semibold">actions</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="item in filteredList" :key="item.id">
                <td class="text-subtitle-1">{{ item.id }}</td>
                <td>
                    <div class="d-flex align-center py-4">
                        <div>
                            <v-img :src="item.avatar" width="45px" class="rounded-circle img-fluid"></v-img>
                        </div>

                        <div class="ml-5">
                            <h4 class="text-h6">{{ item.fecha_a }}</h4>
                            <span class="text-subtitle-1 d-block mt-1 textSecondary">{{ item.usermail }}</span>
                        </div>
                    </div>
                </td>
                <td class="text-subtitle-1">{{ item.phone }}</td>
                <td class="text-subtitle-1">{{ item.estatus }}</td>
                <td>
                    <v-chip :color="item.resultadosstatus" size="small" label>{{ item.resultados }}</v-chip>
                </td>
                <td>
                    <div class="d-flex align-center">
                        <v-tooltip text="Edit">
                            <template v-slot:activator="{ props }">
                                <v-btn icon flat @click="editItem(item)" v-bind="props"
                                    ><PencilIcon stroke-width="1.5" size="20" class="text-primary"
                                /></v-btn>
                            </template>
                        </v-tooltip>
                        <v-tooltip text="Delete">
                            <template v-slot:activator="{ props }">
                                <v-btn icon flat @click="deleteItem(item)" v-bind="props"
                                    ><TrashIcon stroke-width="1.5" size="20" class="text-error"
                                /></v-btn>
                            </template>
                        </v-tooltip>
                    </div>
                </td>
            </tr>
        </tbody>
    </v-table>
</template>
