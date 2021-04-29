<template>
  <div>
    <header class="header">
      <nav class="navbar navbar-expand-md navbar-light bg-light">
        <div class="container">
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

              <li class="nav-item">
                <router-link class="nav-link" :to="{ name: 'Login'}">
                  <span>LOGIN</span>
                </router-link>
              </li>

              <!-- Dropdown -->
              <!--                <li class="nav-item dropdown">-->
              <!--                  <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false">EN</a>-->
              <!--                  <div class="dropdown-menu slideDownIn">-->
              <!--                    <a class="dropdown-item" href="#">EN - English</a>-->
              <!--                    <a class="dropdown-item" href="#">AR - Arabic</a>-->
              <!--                  </div>-->
              <!--                </li>-->
            </ul>
          </div>
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

  data(){
    return{
      frontPageData : '',
    }
  },

  methods: {
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
  }
}
</script>
<style scoped>
</style>
