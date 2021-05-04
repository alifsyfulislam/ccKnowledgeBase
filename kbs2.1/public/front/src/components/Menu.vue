<template>
  <div>
    <header class="header">
      <nav class="navbar navbar-expand-md navbar-light bg-light">
        <div class="container position-relative">
          <div class="logo">
            <router-link class="nav-item" :to="{ name: 'Home'}">
              <img :src="frontPageData.logo">
            </router-link>
          </div>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="mainNavigation">
            <ul class="navbar-nav ml-auto align-items-center">
              <li class="nav-item">
                <router-link class="nav-link px-0 py-0"  :to="{ name: 'CategoryList', params: { categoryID: 'election' }}">
                  <span>CATEGORIES</span>
                </router-link>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" :to="{ name: 'Quiz'}">
                  <span>QUIZ</span>
                </router-link>
              </li>
              <li class="nav-item">
                <router-link class="nav-link" :to="{ name: 'Faq'}">
                  <span>FAQ</span>
                </router-link>
              </li>

<!--              <li class="nav-item">-->
<!--                <router-link class="nav-link" :to="{ name: 'Sitemap'}">-->
<!--                  <span>SITEMAP</span>-->
<!--                </router-link>-->
<!--              </li>-->



              <li class="nav-item dropdown" v-if="isAuthinticate">
                <a class="nav-link text-dark dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false"> <i class="fa fa-user"></i></a>
                <div class="dropdown-menu slideDownIn">
                  <a class="dropdown-item" href="#">Profile</a>
                  <a class="dropdown-item" href="#" @click.prevent="userLogOff">Logout</a>
                </div>
              </li>

              <li class="nav-item" v-else>
                <!-- <router-link class="nav-link" :to="{ name: 'Login'}">
                  <span>LOGIN</span>
                </router-link> -->
                <span  @click="isHidden = !isHidden" class="nav-link">
                  <span>LOGIN</span>
                </span>
              </li>
            </ul>
          </div>
          <Login v-if="isHidden" :isHidden="isHidden" @authorised="getDataFromLogin"/>
        </div>
      </nav>
    </header>
    <div class="totop">
      <i class="fa fa-angle-up" aria-hidden="true"></i>
    </div>
  </div>
</template>
<script>
import $ from 'jquery'
import axios from "axios";
import Login from "@/components/Login";

// window scroll
$(window).scroll(function() {
  let scroll = $(window).scrollTop();
  // Scroll to top
  if (scroll) {
    $('.header').addClass('fixed-header');
  } else {
    $('.header').removeClass('fixed-header');
  }

  if (scroll > 500) {
    $('.totop').css('bottom', '60px');
  } else {
    $('.totop').css('bottom', '-50px');
  }
});

$(document).on('click', '.totop', function(){
  $('html,body').animate({
    scrollTop: 0
  }, 1000);
});

// Responsive menu
$(document).on('click', '#mainNavigation .nav-link', () => {
  if($(window).width() < 767){
    $('.navbar-toggler').trigger('click');
  }
});

export default {
  name: "Menu",
  components : {
      Login
  },
  data(){
    return{
      frontPageData : '',
      userInformation : '',
      isAuthinticate : false,
      isHidden: false,
    }
  },

  methods: {
    userLogOff(){
      let _that = this;
      let formData = new FormData();
      formData.append('id',  sessionStorage.getItem('visitorID'));
      formData.append('tokenId',  sessionStorage.getItem('visitorToken'));

      axios.post('logout',formData,
              {
                headers: {
                  'Authorization': 'Bearer '+localStorage.getItem('authToken')
                }
              }
      ).then(function (response) {

        if (response.data.status_code === 200){
            _that.isAuthinticate = false;
            localStorage.removeItem("userInformation");
            localStorage.removeItem("authToken");
            sessionStorage.removeItem('visitorID')
            sessionStorage.removeItem('visitorToken')
          // window.location.reload()
          _that.$router.push({name : 'Home'})
        }else{
          _that.success_message           = "";
          _that.error_message             = response.data.message;
        }
      });
    },
    getDataFromLogin(status){
      console.log(status);
      this.isHidden = false;
      this.isAuthinticate = true;
    },
    getPageDecorationData()
    {
      let _that =this;
      axios.get('front-page-config', { cache: false })
        .then(function (response) {
          if(response.data.status_code === 200){
            _that.frontPageData = response.data.page_config_info;
          }
        })
    }
  },
  created() {
    this.getPageDecorationData();
    if (sessionStorage.visitorID){
      console.log(sessionStorage.visitorID);
      this.isAuthinticate = true;
    }
    console.log(this.isAuthinticate);
  }
}
</script>
<style scoped>
  .nav-link {
      cursor: pointer;
      transition: all 0.4s;
  }
</style>
