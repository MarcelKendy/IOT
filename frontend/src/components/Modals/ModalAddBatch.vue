<template>
  <div>
    <v-dialog v-model="dialog" persistent max-width="700">
      <v-card :loading="loading" dark>
        <template slot="progress">
          <v-progress-linear
            :color="color"
            height="10"
            indeterminate
          ></v-progress-linear>
        </template>
        <v-card-title class="title-modal" v-if="!loading">
          <strong>Adicionar Área de Plantio</strong>
          <v-spacer></v-spacer>
          <img width="30" src="../../assets/images/iot/ufv.png" />
        </v-card-title>
        <v-card-title class="title-modal" v-else>
          <strong>Salvando</strong>
          <v-spacer></v-spacer>
          <img width="30" src="../../assets/images/iot/ufv.png" />
        </v-card-title>
        <v-divider></v-divider>
        <v-card-text class="mt-7" v-if="loading">
          <v-row align="center" justify="center">
            <v-col cols="12">
              <v-alert
                :color="color"
                border="left"
                elevation="3"
                dark
                icon="mdi-content-save"
              >
                <span>Espera só um pouquinho, carregando...</span>
              </v-alert>
            </v-col>
          </v-row>
        </v-card-text>
        <v-card-text class="mt-4" v-else>
          <v-form ref="form" v-model="valid" lazy-validation>
            <v-row align="center">
              <v-col cols="12">
                <v-text-field
                  outlined
                  :color="color"
                  label="Nome do Lote"
                  :rules="requiredRule"
                  v-model="item.name"
                  placeholder="Insira o nome da área/lote"
                  prepend-icon="mdi-pencil"
                >
                </v-text-field>
              </v-col>
            </v-row>
            <v-row align="center">
              <v-col cols="12">
                <v-text-field
                  outlined
                  :color="color"
                  label="Localização"
                  :rules="requiredRule"
                  v-model="item.location"
                  placeholder="Insira o endereço"
                  prepend-icon="mdi-pencil"
                >
                </v-text-field>
              </v-col>
            </v-row>
            <v-row align="center">
              <v-col cols="12" >
                <v-select
                  :menu-props="{ dark: true, offsetY: true }"
                  solo
                  :loading="loading_cultures"
                  :items="cultures"
                  :rules="requiredRule"
                  :color="color"
                  label="Cultura"
                  item-text="name"
                  item-value="id"
                  v-model="item.culture_id"
                  prepend-icon="mdi-storefront"
                ></v-select>
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>
        <v-divider></v-divider>
        <v-card-actions v-if="!loading">
          <v-spacer></v-spacer>
          <v-btn color="red darken-1" dark text @click="closeModal()">
            Cancelar
          </v-btn>
          <v-btn :color="color" text @click="addData()"> Salvar </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  props: ['open'],
  data() {
    return {
      color: 'rgb(0, 209, 94)',
      valid: true,
      dialog: false,
      loading: false,
      loading_cultures: false,
      cultures: [],
      item: {
        culture_id: '',
        name: '',
        location: '',
      },
    
      /* RULES */
      requiredRule: [(v) => v.length != 0 || 'Essa informação é obrigatória'],
    };
  },
  watch: {
    open: function () {
      this.dialog = this.open;
      if (this.$refs.form) {
        this.$refs.form.resetValidation();
      }
      if (this.dialog) {
        this.getCultures()
      }
      this.loading = false;
    },
  },
  methods: {
    getCultures() {
      this.loading_cultures = true
      this.$http.get('get_cultures').then((response) => {
        this.cultures = response.data
        this.loading_cultures = false
      })
    },
    resetValidation() {
      if (this.$refs.form) {
        this.$refs.form.resetValidation();
      }
    },
    addData() {
      if (this.$refs.form.validate()) {
        this.loading = true;
        this.$emit('addData', this.item);
        this.$refs.form.resetValidation();
        Object.assign(this.item, this.defaultItem);
      }
    },
    closeModal() {
      this.$emit('closeAddModal');
      this.$refs.form.resetValidation();
      Object.assign(this.item, this.defaultItem);
    },
  },
  computed: {
    defaultItem() {
      return {
        culture_id: '',
        name: '',
        location: '',
      };
    },
  },
};
</script>

<style scoped>

</style>