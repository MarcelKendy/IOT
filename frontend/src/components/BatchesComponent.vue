<template>
  <div>
    <v-tooltip id="tooltip" left color="black">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          small
          fixed
          right
          color="rgb(0, 209, 94)"
          dark
          fab
          v-bind="attrs"
          v-on="on"
          @click="addModal()"
        >
          <v-icon> mdi-plus </v-icon>
        </v-btn>
      </template>
      <span>Adicionar</span>
    </v-tooltip>
    <v-card dark class="hover-card" elevation="7" outlined shaped>
      <v-card-title class="title-card-dark">
        <span class="pb-10"
          >Áreas de Plantio<v-img
            class="mx-2"
            style="display: inline-block"
            src="@/assets/images/iot/ufv.png"
            max-width="20"
          ></v-img
        ></span>
        <v-spacer></v-spacer>
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          label="Pesquisar"
          dark
          single-line
          color="rgba(18,210,175)"
        ></v-text-field>
      </v-card-title>
      <v-card-subtitle>
        <span style="position: absolute; top: 60px" class="subtitle-card-dark"
          >Cadastre seus terrenos e respectivos plantios</span
        >
      </v-card-subtitle>
      <v-card-text>
        <v-data-table
          ref="vDataTable"
          style="font-weight: bold"
          dark
          class="data-table-dark"
          :loading="loading"
          item-key="id"
          :headers="headers"
          :items="items"
          :search="search"
          :sort-by="['date_indicator', 'value']"
          multi-sort
          :footerProps="{
            itemsPerPageText: 'Itens por página:',
            itemsPerPageOptions: [10, 30, 50, 100],
          }"
          no-data-text="Nenhum dado inserido"
          :headerProps="{ sortByText: 'Ordenar Por:' }"
          no-results-text="Não há nenhum registro acerca da pesquisa informada"
          loading-text="Carregando..."
        >
          <template v-slot:[`footer.page-text`]="items">
            {{ items.pageStart }} até {{ items.pageStop }} - Total:
            <strong>{{ items.itemsLength }}</strong>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-speed-dial
              :id="item.id"
              direction="left"
              open-on-hover
              transition="slide-x-reverse-transition"
            >
              <template v-slot:activator>
                <v-btn
                  :id="item.id"
                  color="rgba(18,210,175)"
                  dark
                  small
                  fab
                  icon
                >
                  <v-icon> mdi-dots-vertical </v-icon>
                </v-btn>
              </template>
              <v-btn
                fab
                dark
                small
                color="yellow darken-2"
                @click="editModal(item)"
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
              <v-btn fab dark small color="red" @click="deleteModal(item)">
                <v-icon>mdi-delete</v-icon>
              </v-btn>
            </v-speed-dial>
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>

    <modal-add
      :open="add_modal"
      @closeAddModal="addModal"
      @addData="addData"
    ></modal-add>
    <modal-edit
      :open="edit_modal"
      :data="edited_item"
      @closeEditModal="editModal"
      @editData="editData"
    ></modal-edit>
    <modal-delete
      :open="delete_modal"
      :data="deleted_item"
      @closeDeleteModal="deleteModal"
      @deleteData="deleteData"
    ></modal-delete>
    <v-snackbar
      v-model="snackbar_add"
      timeout="2500"
      elevation="24"
      rounded="pill"
      color="success"
    >
      <v-icon class="pr-3" dark>mdi-check-circle</v-icon>
      <strong style="padding-left: 35px" class="white--text"
        >Dado salvo com sucesso</strong
      >
    </v-snackbar>
    <v-snackbar
      v-model="snackbar_edit"
      timeout="2500"
      elevation="24"
      rounded="pill"
      color="orange"
    >
      <v-icon class="pr-3" dark>mdi-check-circle</v-icon>
      <strong style="padding-left: 35px" class="white--text"
        >Dado editado com sucesso</strong
      >
    </v-snackbar>
    <v-snackbar
      v-model="snackbar_delete"
      timeout="2500"
      elevation="24"
      rounded="pill"
      color="red"
    >
      <v-icon class="pr-3" dark>mdi-alert-circle-check</v-icon>
      <strong style="padding-left: 35px" class="white--text"
        >Dado removido com sucesso</strong
      >
    </v-snackbar>
  </div>
</template>

<script>
import ModalAdd from './Modals/ModalAddBatch.vue';
import ModalEdit from './Modals/ModalEditBatch.vue';
import ModalDelete from './Modals/ModalDeleteBatch.vue';
export default {
  name: 'BatchesComponent',
  components: { ModalAdd, ModalEdit, ModalDelete },
  data: () => ({
    search: '',
    loading: false,
    items: [],
    headers: [
      { text: 'Nome', value: 'name', align: 'start' },
      { text: 'Local', value: 'location', align: 'start' },
      { text: 'Cultura', value: 'culture.name', align: 'start' },
      { text: 'Ações', value: 'actions', sortable: false },
    ],
    edited_item: {},
    deleted_item: {},
    add_modal: false,
    edit_modal: false,
    delete_modal: false,
    snackbar_add: false,
    snackbar_edit: false,
    snackbar_delete: false,
  }),
  created() {
    this.getData();
  },
  methods: {
    addData(item) {
      this.$http.post('add_batch', item).then((response) => {
        this.items.push(response.data);
        this.addModal();
        this.snackbar_add = true;
      });
    },
    editData(item) {
      this.$http.put(`edit_batch/${item.id}`, item).then((response) => {
        this.items = this.items.map((data) =>
          data.id !== item.id ? data : response.data
        );
        this.editModal();
        this.snackbar_edit = true;
      });
    },
    deleteData(id) {
      this.$http.delete(`delete_batch/${id}`).then(() => {
        this.items = this.items.filter((data) => {
          return data.id !== id;
        });
        this.deleteModal();
        this.snackbar_delete = true;
      });
    },
    addModal() {
      this.add_modal = !this.add_modal;
    },
    editModal(item = {}) {
      this.edited_item = {};
      Object.assign(this.edited_item, item);
      this.edit_modal = !this.edit_modal;
    },
    deleteModal(item = {}) {
      this.deleted_item = {};
      Object.assign(this.deleted_item, item);
      this.delete_modal = !this.delete_modal;
    },
    getData() {
      this.loading = true;
      this.$http.get('get_batches').then((response) => {
        this.items = response.data;
        this.loading = false;
      });
    },
  },
};
</script>
