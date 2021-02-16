// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import BootstrapVue from 'bootstrap-vue/dist/bootstrap-vue.esm';
import 'bootstrap'
import $ from 'jquery'

//bootstrap
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';
//custom css
import '@/assets/fonts/nunito/font.css'
import '@/assets/css/bundle.css'
import '@/assets/css/style.css'
import '@/assets/css/custom.css'
import '@/assets/fonts/nunito/Nunito-Regular.ttf'

Vue.config.productionTip = false

axios.defaults.baseURL = 'http://localhost/ccKnowledgeBase/kbs2.1/public/api';
// axios.defaults.baseURL = 'http://192.168.10.64/kbs/kbs-base/public/api/'

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  axios,
  VueAxios,
  BootstrapVue,
  $,
  components: { App },
  template: '<App/>'
})
