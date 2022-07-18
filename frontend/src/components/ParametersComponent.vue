<template>
  <div>
    <v-card class="hover-card" elevation="7" outlined shaped dark>
      <v-card-title>
        <span class="bold title-card">Parametrização da irrigação</span>
        <v-img
          class="mx-2"
          style="display: inline-block"
          src="@/assets/images/iot/ufv.png"
          max-width="20"
        ></v-img>
      </v-card-title>
      <v-card-subtitle>
        <span class="bold subtitle-card-dark"
          >Coordena o funcionamento do pivô</span
        >
      </v-card-subtitle>
      <v-card-text>
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-row align="center">
            <v-col cols="12" md="2">
              <strong>Tempo em segundos:</strong>
              <v-tooltip id="tooltip" top color="grey darken-3">
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    dense
                    small
                    @click.stop
                    :rules="requiredTimeRule"
                    @change="changeParameters(1)"
                    v-model="item.time_in_seconds"
                    @keypress="numberMask"
                    :loading="changing_time_in_seconds"
                    :disabled="changing_time_in_seconds"
                    class="shrink"
                    append-icon="mdi-pencil"
                    v-bind="attrs"
                    v-on="on"
                  >
                  </v-text-field>
                </template>
                <span>Edição Automática</span>
              </v-tooltip>
            </v-col>
            <v-col cols="12" md="3">
              <strong>Umidade adquirida em centímetros:</strong>
              <v-tooltip id="tooltip" top color="grey darken-3">
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    dense
                    small
                    :rules="requiredIncreaseRule"
                    @click.stop
                    @change="changeParameters(2)"
                    v-model="item.moisture_increase"
                    @keypress="numberMask"
                    :loading="changing_moisture_increase"
                    :disabled="changing_moisture_increase"
                    class="shrink"
                    append-icon="mdi-pencil"
                    v-bind="attrs"
                    v-on="on"
                  >
                  </v-text-field>
                </template>
                <span>Edição Automática</span>
              </v-tooltip>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
export default {
  name: 'ParametersComponent',

  data: () => ({
    valid: true,
    changing_time_in_seconds: false,
    changing_moisture_increase: false,
    item: {
      time_in_seconds: '',
      moisture_increase: '',
    },
    requiredTimeRule: [
      (v) => !!v || 'Essa informação é obrigatória',
      (v) => parseFloat(v) < 10000 || 'Deve ser menor que 10.000 segundos',
      (v) => parseFloat(v) > 2 || 'Deve ser maior que 2 segundos',
    ],
    requiredIncreaseRule: [
      (v) => !!v || 'Essa informação é obrigatória',
      (v) => parseFloat(v) < 100 || 'Deve ser menor que 100 centímetros',
    ],
  }),
  created() {
    this.getParameters();
  },
  methods: {
    getParameters() {
      this.changing_time_in_seconds = this.changing_moisture_increase = true
      this.$http.get('get_parameters').then((response) => {
        this.item = response.data;
        this.changing_time_in_seconds = this.changing_moisture_increase = false
      });
    },
    changeParameters(parameter) {
      if (this.$refs.form.validate()) {
        if (parameter == 1) {
          this.changing_time_in_seconds = true;
        } else {
          this.changing_moisture_increase = true;
        }
        this.$http.put(`edit_parameter/1`, this.item).then((response) => {
          this.item = response.data;
          if (parameter == 1) {
            this.changing_time_in_seconds = false;
          } else {
            this.changing_moisture_increase = false;
          }
        });
      }
    },
    numberMask($event) {
      let keyCode = $event.keyCode ? $event.keyCode : $event.which;
      if ((keyCode < 48 || keyCode > 57) && keyCode !== 46) {
        // numbers are between 48 and 57
        $event.preventDefault();
      }
    },
  },
};
</script>
