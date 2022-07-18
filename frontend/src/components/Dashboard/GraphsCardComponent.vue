<template>
  <div>
    <v-expand-transition>
      <div v-if="show_animation">
        <v-card
          shaped
          style="overflow: hidden"
          :width="width"
          :height="height"
          :dark="dark"
          :loading="loading"
          class="hover-card-dark"
        >
          <template slot="progress">
            <v-progress-linear
              :color="color"
              height="6"
              indeterminate
            ></v-progress-linear>
          </template>
          <v-card-title
            ><strong :style="'color: ' + color">{{ title }}</strong
            ><v-spacer></v-spacer>
            <v-hover v-slot:default="{ hover }">
              <v-chip
                class="ma-2"
                :color="color"
                :outlined="!hover"
                :dark="hover"
              >
                <v-icon left> {{ icon }} </v-icon>
                <strong>Total: </strong
                ><strong class="mx-2">{{ total }}</strong>
              </v-chip>
            </v-hover>
          </v-card-title>
          <v-card-subtitle
            ><strong>{{ subtitle }}</strong></v-card-subtitle
          >
          <v-card-text
            :class="loading ? 'text-center pa-5' : 'd-flex justify-center pa-5'"
          >
            <v-progress-circular
              v-if="loading || reset"
              class="mt-15"
              :size="60"
              color="rgba(18,210,195)"
              indeterminate
            ></v-progress-circular>
            <apex-chart
              v-else-if="
                typeof total == 'string'
                  ? parseFloat(total.replace(',', '.')) > 0
                  : total > 0
              "
              :type="type"
              :width="graph_width"
              :height="graph_height ? graph_height : ''"
              :options="mutable_options"
              :series="series"
            ></apex-chart>
            <div v-else class="mt-14">
              <v-img
                style="margin-left: auto; margin-right: auto; display: block"
                :width="no_data_image_size"
                :src="require('@/assets/images/' + no_data_image)"
              ></v-img>
              <v-alert
                class="mt-10"
                :width="no_data_alert_size"
                :color="no_data_alert_color"
                border="left"
                elevation="10"
                outlined
                dark
                prominent
              >
                <template slot="prepend">
                  <v-img
                    src="@/assets/images/iot/empty-box.png"
                    max-width="64px"
                  ></v-img>
                </template>
                <h3>{{ no_data_text }}</h3>
                <p class="mt-2">{{ new Date().toLocaleString() }}</p>
              </v-alert>
            </div>
          </v-card-text>
        </v-card>
      </div>
    </v-expand-transition>
  </div>
</template>

<script>
export default {
  props: {
    type: {},
    color: {
      required: false,
      type: [String],
      default: 'blue',
    },
    width: {
      required: false,
      type: [String],
    },
    height: {},
    graph_width: {},
    graph_height: {},
    series: {},
    options: {},
    title: {},
    icon: {},
    att_chart: {},
    subtitle: {},
    total: {},
    dark: {},
    delay: {},
    no_data_text: {
      required: false,
      type: [String],
      default: 'Sem dados referentes',
    },
    no_data_image: {
      required: false,
      type: [String],
      default: 'empty-box.png',
    },
    no_data_image_size: {
      required: false,
      type: [String],
      default: '220px',
    },
    no_data_alert_size: {
      required: false,
      type: [String],
      default: '420px',
    },
    no_data_alert_color: {
      required: false,
      type: [String],
      default: 'blue',
    },
    loading: {},
  },
  name: 'GraphsCardComponent',
  data: () => ({
    show_animation: false,
    mutable_options: {},
    reset: false,
  }),
  mounted() {},
  created() {
    let _this = this;
    if (this.assignMutableOptions()) {
      setTimeout(function () {
        _this.show_animation = true;
      }, 500);
    }
  },
  methods: {
    assignMutableOptions() {
      this.mutable_options = this.options;
      if (this.type == 'donut') {
        if (Object.getOwnPropertyDescriptor(this.options, 'plotOptions')) {
          this.mutable_options.plotOptions.pie.donut.labels.total.formatter =
            () => {
              return this.total;
            };
          return true;
        } else {
          return false;
        }
      }
      return true;
    },
  },
  watch: {
    options: function () {
      this.assignMutableOptions();
    },
    att_chart: function () {
      if (this.att_chart) {
        this.reset = true;
        let _this = this;
        setTimeout(function () {
          _this.reset = false;
        }, 1);
      }
    },
  },
};
</script>

<style scoped>
.hover-card-dark {
  background-color: rgba(0, 0, 0, 0.767);
  box-shadow: rgba(18, 61, 0, 0.753) 0px 2px 4px 0px, rgba(8, 71, 0, 0.815) 0px 2px 16px 0px !important;
  
  transition: 0.3s;
}
.hover-card-dark:hover {
  box-shadow: rgba(37, 116, 3, 0.753) 0px 2px 4px 0px, rgba(17, 134, 2, 0.815) 0px 2px 16px 0px !important;
  transition: 0.3s;
}

</style>