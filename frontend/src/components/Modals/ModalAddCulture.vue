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
          <strong>Adicionar Cultura</strong>
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
                  label="Cultura"
                  :rules="requiredRule"
                  v-model="item.name"
                  placeholder="Insira o nome da cultura"
                  prepend-icon="mdi-pencil"
                >
                </v-text-field>
              </v-col>
            </v-row>
            <v-row align="center">
              <v-col cols="12">
                <vuetify-number
                  v-model="item.soil_moisture"
                  v-bind:label="'Quantidade Ideal de Umidade (cm)'"
                  v-bind:outlined="true"
                  v-bind:rules="requiredRule"
                  v-bind:color="color"
                  v-bind:backgroundColor="'#1E1E1E'"
                  v-bind:prependIcon="'mdi-pencil'"
                  v-bind:valueWhenIsEmpty="null"
                  v-bind:options="options"
                />
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
      item: {
        name: '',
        soil_moisture: '',
      },
      options: {
        locale: 'pt-BR',
        prefix: '',
        suffix: '(cm)',
        length: 5,
        precision: 2,
        color: this.color,
      },
      /* RULES */
      requiredRule: [(v) => !!v || 'Essa informação é obrigatória'],
    };
  },
  watch: {
    open: function () {
      this.dialog = this.open;
      if (this.$refs.form) {
        this.$refs.form.resetValidation();
      }
      this.loading = false;
    },
  },
  methods: {
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
        name: '',
        soil_moisture: '',
      };
    },
  },
};
</script>

<style scoped>
</style>