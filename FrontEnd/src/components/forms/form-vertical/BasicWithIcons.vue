<script setup lang="ts">
import { ref } from 'vue';
// icons
import { UserIcon, BuildingArchIcon, MailIcon, phoneIcon, Message2Icon } from 'vue-tabler-icons';
</script>
<template>
    <v-row>
        <v-col cols="12">
            <v-label class="font-weight-medium mb-2">Name</v-label>
            <v-text-field color="primary" variant="outlined" type="text" placeholder="John Deo" hide-details>
                <template v-slot:prepend-inner>
                    <UserIcon stroke-width="1.5" size="22" class="text-medium-emphasis mr-3" />
                </template>
            </v-text-field>
        </v-col>
        <v-col cols="12">
            <v-label class="font-weight-medium mb-2">Company</v-label>
            <v-text-field color="primary" variant="outlined" type="text" placeholder="ACME Inc." hide-details>
                <template v-slot:prepend-inner>
                    <BuildingArchIcon stroke-width="1.5" size="22" class="text-medium-emphasis mr-3" />
                </template>
            </v-text-field>
        </v-col>
        <v-col cols="12">
            <v-label class="font-weight-medium mb-2">Email</v-label>
            <v-text-field color="primary" variant="outlined" type="email" placeholder="john.deo" hide-details>
                <template v-slot:prepend-inner>
                    <MailIcon stroke-width="1.5" size="22" class="text-medium-emphasis mr-3" />
                </template>
            </v-text-field>
        </v-col>
        <v-col cols="12">
            <v-label class="font-weight-medium mb-2">phone No</v-label>
            <v-text-field color="primary" variant="outlined" type="text" placeholder="412 2150 451" hide-details>
                <template v-slot:prepend-inner>
                    <phoneIcon stroke-width="1.5" size="22" class="text-medium-emphasis mr-3" />
                </template>
            </v-text-field>
        </v-col>
        <v-col cols="12">
            <v-label class="font-weight-medium mb-2">Message</v-label>
            <v-textarea
                auto-grow
                variant="outlined"
                placeholder="Hi, Do you  have a moment to talk Jeo ?"
                rows="2"
                color="primary"
                row-height="25"
                shaped
                hide-details
            >
                <template v-slot:prepend-inner>
                    <Message2Icon stroke-width="1.5" size="22" class="text-medium-emphasis mr-3" />
                </template>
            </v-textarea>
        </v-col>
        <v-col cols="12">
            <v-btn color="primary" flat>Send</v-btn>
        </v-col>
    </v-row>
</template>
