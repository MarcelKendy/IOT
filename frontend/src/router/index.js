import Vue from 'vue'
import VueRouter from 'vue-router'

import HomeView from '../views/HomeView.vue'
import CulturesView from '../views/CulturesView.vue'
import BatchesView from '../views/BatchesView.vue'
import ParametersView from '../views/ParametersView.vue'
import AboutView from '../views/AboutView.vue'

Vue.use(VueRouter)

const routes = [
  
  {
    path: '/',
    name: 'Home',
    component: HomeView
  },
  {
    path: '/cultures',
    name: 'Culturas',
    component: CulturesView
  },
  {
    path: '/batches',
    name: 'Áreas',
    component: BatchesView
  },
  {
    path: '/parameters',
    name: 'Parâmetros',
    component: ParametersView
  },
  {
    path: '/about',
    name: 'Sobre',
    component: AboutView
  },
  
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  scrollBehavior() {
    // always scroll to top
    return { x: 0, y: 0 }
  },
  routes
})

export default router
