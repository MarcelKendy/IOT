<template>
  <div>
    <v-tooltip right>
      <template v-slot:activator="{ attrs, on }">
        <v-btn
          :loading="loading"
          @click="resetMoisture"
          v-bind="attrs"
          v-on="on"
          color="green"
          small
          class="ma-5"
          dark
          >resetar<v-icon right>mdi-reload</v-icon></v-btn
        >
      </template>
      <span class="green--text">Resetar a umidade atual dos lotes</span>
    </v-tooltip>

    <v-row class="align-center">
      <v-col cols="12">
        <graphs-card-component
          :att_chart="att_chart"
          title="Umidade dos Plantios"
          subtitle="Bar Chart do progresso de umidade ideal para plantio (cm)"
          type="bar"
          icon="mdi-account-group"
          color="rgb(10, 205, 70)"
          height="720"
          graph_width="1000"
          graph_height="490"
          :loading="loading"
          :options="bar_chart_options"
          :series="series_bar_chart"
          :total="total_bar_chart"
          dark
        ></graphs-card-component>
      </v-col>
    </v-row>
    <v-snackbar
      v-model="snackbar_done"
      timeout="3500"
      elevation="24"
      rounded="pill"
      color="green darken-4"
    >
      <v-icon class="pr-3" dark>mdi-sprinkler-variant</v-icon>
      <strong style="padding-left: 35px" class="white--text"
        >Todas as áreas estão irrigadas!</strong
      >
    </v-snackbar>
    <v-snackbar
      v-model="snackbar_starting"
      :timeout="snackbar_reset ? 4500 : 2500"
      elevation="24"
      rounded="pill"
      color="orange"
    >
      <v-icon class="pr-3" dark>mdi-sprinkler</v-icon>
      <strong style="padding-left: 35px" class="white--text"
        >Irrigando solo(s) secos</strong
      >
    </v-snackbar>
    <v-snackbar
      v-model="snackbar_batch_done"
      :timeout="snackbar_reset ? 4500 : 2500"
      elevation="24"
      rounded="pill"
      color="green"
    >
      <v-icon class="pr-3" dark>mdi-sprinkler</v-icon>
      <strong style="padding-left: 35px" class="white--text">{{
        snackbar_batch_done_message
      }}</strong>
    </v-snackbar>
    <v-snackbar
      v-model="snackbar_reset"
      timeout="2500"
      elevation="24"
      rounded="pill"
      color="orange"
    >
      <v-icon class="pr-3" dark>mdi-information</v-icon>
      <strong style="padding-left: 35px" class="white--text">{{
        snackbar_reset_message
      }}</strong>
    </v-snackbar>
  </div>
</template>

<script>
import GraphsCardComponent from './Dashboard/GraphsCardComponent.vue';
export default {
  name: 'HomeComponent',
  components: {
    GraphsCardComponent,
  },
  data: () => ({
    moisture_increase_cm: 0,
    time_increase_seconds: 0,
    dry_soils: [],
    att_chart: false,
    editing_moisture: false,
    snackbar_done: false,
    snackbar_starting: false,
    snackbar_batch_done: false,
    snackbar_reset: false,
    snackbar_reset_message: '',
    snackbar_batch_done_message: '',
    loading: false,
    done_message_time_out: null,
    total_bar_chart: 0,
    series_bar_chart: [
      {
        name: 'Atual',
        data: [],
      },
    ],
    bar_chart_options: {
      chart: {
        height: 350,
        type: 'bar',
      },
      plotOptions: {
        bar: {
          horizontal: true,
        },
      },
      colors: ['#00E396', '#775DD0'],
      tooltip: {
        theme: 'dark',
      },
      dataLabels: {},
      xaxis: {
        labels: {
          style: {
            colors: ['#00E396'],
            fontSize: '12px',
            fontFamily: 'Helvetica, Arial, sans-serif',
            fontWeight: 400,
          },
        },
      },
      yaxis: {
        labels: {
          style: {
            colors: ['#775DD0'],
            fontSize: '16px',
            fontFamily: 'Quicksand, sans-serif',
            fontWeight: 900,
          },
        },
      },
      legend: {
        labels: {
          useSeriesColors: true,
        },
        show: true,
        showForSingleSeries: true,
        customLegendItems: ['Atual', 'Ideal'],
        markers: {
          fillColors: ['#00E396', '#775DD0'],
        },
      },
    },
  }),
  computed: {},
  created() {
    this.getParameters();
  },
  methods: {
    checkMoisture() {
      if (this.dry_soils.length > 0) {
        this.startIrrigation();
      } else {
        this.snackbar_done = true;
      }
    },
    startIrrigation() {
      this.snackbar_starting = true;
      let interval_irrigation = setInterval(() => {
        let att = false;
        this.dry_soils.map((batch) => {
          if (
            parseFloat(batch.current_soil_moisture) < parseFloat(batch.ideal)
          ) {
            batch.current_soil_moisture =
              parseFloat(batch.current_soil_moisture) +
              this.moisture_increase_cm;
            att = true;
            this.editMoisture(batch);
          } else {
            this.done_message_time_out = setTimeout(
              () => {
                this.snackbar_batch_done_message = '';
                this.snackbar_batch_done = false;
                this.snackbar_batch_done_message =
                  'Irrigação de ' + batch.name + ' concluída';
                this.snackbar_batch_done = true;
              },
              this.done_message_time_out != null ? 1700 : 1
            );

            this.dry_soils = this.dry_soils.filter((filter_batch) => {
              return filter_batch.id != batch.id;
            });
          }
          return batch;
        });
        att ? this.attChart() : '';
        if (this.dry_soils.length <= 0) {
          this.attChart();
          clearInterval(interval_irrigation);
          let _this = this;
          setTimeout(
            () => {
              _this.snackbar_done = true;
            },
            this.done_message_time_out ? 3000 : 2500
          );

          return false;
        }
      }, this.time_increase_seconds * 1000);
    },
    attChart() {
      this.att_chart = true;
      let _this = this;
      setTimeout(function () {
        _this.att_chart = false;
      }, 1);
    },
    editMoisture(batch) {
      this.editing_moisture = true;
      let new_batch = {
        x: batch.name,
        y: batch.current_soil_moisture,
        goals: [
          {
            name: 'Ideal',
            value: batch.ideal,
            strokeWidth: 8,
            strokeDashArray: 2,
            strokeColor: '#775DD0',
          },
        ],
      };
      this.$http.put(`edit_moisture/${batch.id}`, batch).then(() => {
        this.series_bar_chart[0].data = this.series_bar_chart[0].data.map(
          (batch_map) => {
            return batch_map.x == batch.name ? new_batch : batch_map;
          }
        );
        this.editing_moisture = false;
      });
    },
    getParameters() {
      this.loading = true;
      this.$http.get('get_parameters').then((response) => {
        this.moisture_increase_cm = parseFloat(response.data.moisture_increase);
        this.time_increase_seconds = parseFloat(response.data.time_in_seconds);
        this.getBarChart();
      });
    },
    getBarChart() {
      this.loading = true;
      this.$http.get('get_bar_chart').then((response) => {
        this.total_bar_chart = response.data.length;
        response.data.forEach((batch) => {
          if (
            parseFloat(batch.current_soil_moisture) <
            parseFloat(batch.culture.soil_moisture)
          ) {
            this.dry_soils.push({
              id: batch.id,
              name: batch.name,
              current_soil_moisture: batch.current_soil_moisture,
              ideal: batch.culture.soil_moisture,
            });
          }
          this.series_bar_chart[0].data.push({
            x: batch.name,
            y: batch.current_soil_moisture,
            goals: [
              {
                name: 'Ideal',
                value: batch.culture.soil_moisture,
                strokeWidth: 8,
                strokeDashArray: 2,
                strokeColor: '#775DD0',
              },
            ],
          });
        });
        this.loading = false;
        this.checkMoisture();
      });
    },
    resetMoisture() {
      this.$http.post('reset_moisture').then((response) => {
        if (response.data) {
          this.dry_soils = [];
          this.series_bar_chart = [
            {
              name: 'Atual',
              data: [],
            },
          ];
          clearTimeout(this.done_message_time_out);
          this.getBarChart();
          this.snackbar_reset_message = 'Umidade dos Lotes resetada';
        } else {
          this.snackbar_reset_message = 'Falha ao resetar umidades';
        }
        this.snackbar_reset = true;
      });
    },
  },
};
</script>
