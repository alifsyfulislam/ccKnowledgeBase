import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import $ from 'jquery'
import 'bootstrap'

// import
import '@/assets/fonts/nunito/font.css'

import '@/assets/css/bundle.css'
import '@/assets/css/style.css'
import '@/assets/css/custom.css'
import '@/assets/fonts/nunito/Nunito-Regular.ttf'


//axios.defaults.baseURL = 'http://localhost/ccKnowledgeBase/public/api';
axios.defaults.baseURL = 'http://192.168.10.64/kbs/kbs-base/public/api/'

createApp(App).use(router, VueAxios, axios, $).mount('#app')
