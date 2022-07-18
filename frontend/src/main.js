import Vue from 'vue'
import App from './App.vue'
import './plugins/axios'
import './registerServiceWorker'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'
import db from '../src/services/localbase'
import VueApexCharts from 'vue-apexcharts'
import JsonExcel from "vue-json-excel";
import VueYouTubeEmbed from 'vue-youtube-embed'
import VueParticles from 'vue-particles'
import "./plugins/vuetify-mask.js"
import "./plugins/vuetify-number.js"

Vue.component('apexChart', VueApexCharts)
Vue.component("downloadExcel", JsonExcel)
Vue.use(VueParticles)
Vue.use(VueApexCharts)

//import VueSpinners from 'vue-spinners'
//Vue.use(VueSpinners)

Vue.config.productionTip = false
Vue.use(VueYouTubeEmbed)
new Vue({
  router,
  store,
  vuetify,
  db,
  render: h => h(App)
}).$mount('#app')
