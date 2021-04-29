<template>
    <div class="login-page-wrapper py-30 py-md-80">
        <div class="container">
            <div class="row justify-content-center">
              <div class="col-md-8">
                  <div class="login-box card px-20 px-md-30 py-30 py-md-60">
                      <div class="row">
                        <div class="col-md-6 welcome-content-box">
                            <h2 class="login-welcome-title text-white mb-20 pb-10">Welcome to KBS</h2>
                            <p class="text-white mb-20 mb-md-0">Lorem ipsum dolor sit, Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Proin eget tortor risus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi.</p>
                        </div>
                        <div class="col-md-6">
                            <h2 class="signin-title text-center mb-20 pb-10">Log In Here!</h2>

                            <form action="" method="post">
                                  <div class="form-group mb-20">
                                      <input type="text" class="form-control" placeholder="Enter Username">
                                  </div>
                                  <div class="form-group mb-20">
                                      <input type="password" class="form-control" placeholder="Enter Password">
                                  </div>
                                  <div class="form-group text-center mb-0">
                                      <button class="btn btn-primary rounded-pill px-35 text-white" type="submit">Login</button>
                                  </div>
                            </form>
                        </div>
                      </div>
                  </div>
              </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Login"
    }
</script>

<style scoped>
    .login-box.card {
        position: relative;
        border-radius: 12px;
        overflow: hidden;
        border: 0;
        box-shadow: 0 10px 20px rgba(0,0,0,0.2);
    }

    .login-welcome-title {
        position: relative;
        font-size: 24px;
        font-weight: 700;
    }

    .signin-title {
        position: relative;
        font-size: 24px;
        font-weight: 700;
    }

    .signin-title:before {
        position: absolute;
        left: 50%;
        bottom: 0;
        transform: translate(-50%,0);
        content: "";
        height: 2px;
        width: 35px;
        background: #3fc6d4;
    }

    .login-welcome-title:before {
        position: absolute;
        left: 0;
        bottom: 0;
        content: "";
        height: 2px;
        width: 60px;
        background: #fff;
    }

    .login-box:before {
        position: absolute;
        content: "";
        left: 0;
        top: 0;
        height: 100%;
        width: 50%;
        background: #3fc6d4;
    }

    .login-box .form-control {
        border: 0;
        border-bottom: 1px solid #eee;
        border-radius: 0;
    }

    .login-box .form-control:focus {
        box-shadow: inherit;
        border-color: #3fc6d4;
    }

    @media (max-width: 767px) {
        .login-box:before {
          display: none;
        }

        .login-box .text-white {
          color: #42484d !important;
        }

        .login-box .btn.text-white {
          color: #fff !important;
        }

        .welcome-content-box {
          text-align: center;
        }

        .login-welcome-title:before {
            left: 50%;
            bottom: 0;
            transform: translate(-50%,0);
            background: #3fc6d4;
        }
    }
</style>
