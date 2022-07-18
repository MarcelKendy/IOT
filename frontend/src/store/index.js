import Vue from 'vue'
import Vuex from 'vuex'

import state from './state'
import mutations from './mutations'
import actions from './actions'


Vue.use(Vuex)

export default new Vuex.Store({
  state,
  getters: {},
  mutations,
  actions,
  modules: {}
})
/*
state.tasks.push(
          {
            id: new Date().getTime(), 
            title: data.title, 
            subtitle: data.subtitle, 
            done: false
          }
        )   
Object.assign(state.tasks.filter(task => task.id == data.id)[0], data)     
state.tasks = state.tasks.filter(task => task.id !== id)          
*/