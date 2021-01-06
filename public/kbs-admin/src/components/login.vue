<template>
  <div>
    <div class="login-wrapper login-wrapper-with-centered-items positon-relaive h-100vh d-block d-sm-flex justify-content-center align-items-center">
      <div class="centered-login-area position-relative overflow-hidden">
        <div class="row">
          <div class="col-sm-6">
            <div class="login-form-wrapper d-flex flex-wrap flex-column py-20 py-sm-40 pl-20 pl-sm-40 pr-20">
              <div class="gplex-logo text-center">
                <img src="../assets/img/gplex-logo.png" alt="gplex" class="img-fluid">
              </div>

              <div class="login-middle-wrapper py-40">
                <div class="account-type-status text-center py-10">
                  <span class="acc-type text-uppercase">Knowledge Based System</span>
                </div>

                <div class="login-form pt-20">
                  <div class="form-group floating-input with-icon user-icon mb-30 mb-md-50">
                    <input class="form-control" type="text" v-model="formData.username" id="userName">
                    <label for="userName">User name</label>
                    <span class="progress-border"></span>
                  </div>
                  <div class="form-group floating-input with-icon password-icon mb-30 mb-md-50">
                    <input class="form-control" type="password" v-model="formData.password" id="userPassword" v-on:keyup.enter="customerLogin()">
                    <label for="userPassword">Password</label>
                    <span class="password-show-hide"></span>
                    <span class="progress-border"></span>
                  </div>

                  <div class="form-group text-center">
                    <button class="btn btn-primary btn-common-2 position-relative overflow-hidden ripple-btn btn-with-rightside-icon text-left text-uppercase py-15 px-45" @click="customerLogin()"><span>Sign In</span></button>
                  </div>
                </div>
              </div>

              <div class="powered-by text-center mt-auto">
<!--                <div class="client-logo d-block d-sm-none mb-10 mb-sm-0">
                  <img class="img-fluid" src="../assets/img/airtel-logo.png" alt="airtel">
                </div>-->
                <div class="client-info text-center d-block d-sm-none mb-2 mb-sm-0"></div>
                Powered by gPlex
              </div>
            </div>
          </div>
          <div class="col-sm-6 centered-login-bg d-none d-sm-block" :style="{ backgroundImage: 'url(' + require('../assets/img/call-center.png') + ')' }">
            <div class="information-wrapper d-flex align-items-end flex-column h-100 p-40">
              <div class="client-logo">
                  <img class="img-fluid " src="../assets/img/logo-demo1.png" alt="demo">
              </div>
              <div class="client-info mt-auto"><a href="https://www.genuitysystems.com/">Genuity System Ltd.</a></div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import $ from 'jquery'

// Login Form
$(document).on('focus','.form-group input',function(){
  $(this).parent().addClass('focused');
});

$(document).on('blur','.form-group input',function(){
  let inputValue = $(this).val();
  if ( inputValue == "" ) {
    $(this).removeClass('filled');
    $(this).parents('.form-group').removeClass('focused');
  } else {
    $(this).addClass('filled');
  }
});



// Password show hide
$(document).on('click','.password-show-hide',function(){
  $(this).toggleClass("show");
  let x = document.getElementById("userPassword");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
});

import axios from 'axios'

export default {
  name: "login.vue",
  data() {
    return {
      notFound        : false,
      success_message : '',
      error_message   : '',
      token           : '',
      formData        : {
        username : 'admin',
        password : '123456',

      },
      userInfo        : '',
    }
  },
  methods:
      {

        customerLogin() {
          let _that = this;

          axios.post('login', {
            username          : this.formData.username,
            password          : this.formData.password,
          }).then(function (response) {

            if (response.data.status_code == 200)
            {
              _that.userInfo        = response.data.user_info;
              _that.token           = response.data.token;
              _that.error_message   = '';
              _that.success_message = response.data.messages;
              localStorage.setItem('authToken', _that.token);
              localStorage.setItem('userInformation', JSON.stringify(response.data.user_info));
              _that.$router.push('/admin/dashboard');
            }
            else
            {
              _that.success_message = "";
              _that.error_message   = response.data.error;
            }
          }).catch(function (error) {
            console.log(error);
          });

        },
      }
}
</script>

<style scoped>

</style>
