<template>
    <div>
      <header class="header">
        <nav class="navbar navbar-expand-md navbar-light bg-light">
          <div class="container">
            <div class="logo">
                <router-link class="nav-item" :to="{ name: 'Display'}">
                    <img :src="frontPageData.logo" style="max-height: 50px; width: auto">
                </router-link>
            </div>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNavigation">
              <ul class="navbar-nav ml-auto align-items-center">

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

                <li class="nav-item"><a class="nav-link nav-button bordered" href="#">LOGIN</a></li>
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
    </div>
</template>

<script>
    import axios from "axios";

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
                            console.log(response.data.page_config_info);
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
