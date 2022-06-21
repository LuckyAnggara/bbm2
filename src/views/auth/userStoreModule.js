import axios from '@axios'

export default {
  namespaced: true,
  state: {
    user: {},
    listUser: [],
  },
  getters: {
    getUserData: state => state.user,
    getListUser: state => state.listUser,
  },
  mutations: {
    SET_USER_DATA(state) {
      state.user = JSON.parse(localStorage.getItem('userData'))
    },
    SET_LIST_USER(state, data) {
      state.listUser = data
    },
  },
  actions: {
    fetchListUser(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}user/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
  },
}
