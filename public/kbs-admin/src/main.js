
import App from './App.vue'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import 'bootstrap'

import '@/assets/css/bundle.css'
import '@/assets/css/style.css'
import '@/assets/css/custom.css'
import '@/assets/css/roboto-font.css'



/*import '@/assets/css/responsive.css'*/
import '@/assets/css/vue-pagination.css'
import '@/assets/fontawesome-5/css/all.css'


/*import $ from 'jquery'*/

import {createApp} from "@vue/runtime-dom";

axios.defaults.baseURL  = 'http://localhost/ccKnowledgeBase/public/api';
//axios.defaults.baseURL = 'http://192.168.10.64/kbs/kbs-base/public/api/';

const app2 = createApp(App)

/*window.onbeforeunload = function() {
    localStorage.removeItem('authToken');
    return '';
};*/

app2.use( router, VueAxios, axios).mount('#app')

//app.use(router,VueAxios, axios).mount('#app')

//createApp(App).use(router, axios, VueAxios).mount("#app");




// axios.post('Api/registration', formData).then((res) => {
//                     let resultData = res.data;
//                     if(resultData.result == true){
//                         self.form = {};
//                         formData = {};
//                         localStorage.setItem('wallboardLoginInfo', JSON.stringify({
//                             'token':resultData.token,
//                             'id':resultData.id,
//                             'cornInterval': resultData.cornInterval,
//                             'sliderInterval': resultData.sliderInterval
//                         }));
//                         self.$refs.form.reset();
//                         this.$router.push({ name:'Dashboard'});
//                     }else{
//                         self.invalidMessage = resultData.resp_msg;
//                     }
//                 })
//                 .catch(function (error) {
//                     console.log(error);
//                 });
