import db from '../services/localbase'
export default {
    getTasks (state) {
        db.collection('tasks').get().then(tasks => {
          state.tasks = tasks
        })  
    },
    getUser (state) {
      db.collection('user').get().then(user => {
        state.user = {}
        Object.assign(state.user, user[0])
      })  
  },    
}