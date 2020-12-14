<template>
    <div>
      <header class="header">
        <nav class="navbar navbar-expand-md navbar-light bg-light">
          <div class="container">
            <div class="logo">
              <a href="/" class="text-uppercase">
                <!-- <img src="assets/img/logo.png" alt="kbs"> -->
                kbs
              </a>
            </div>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNavigation">
              <ul class="navbar-nav ml-auto align-items-center">
<!--                <li class="nav-item"><a class="nav-link" href="/category-list">CATEGORY</a></li>-->
                <li class="nav-item"><a class="nav-link" href="/faq">FAQ</a></li>
                <li class="nav-item"><a class="nav-link nav-button bordered" href="#">LOGIN</a></li>
                <!-- Dropdown -->
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbardroplanguage" data-toggle="dropdown" aria-expanded="false">EN</a>
                  <div class="dropdown-menu slideDownIn">
                    <a class="dropdown-item" href="#">EN - English</a>
                    <a class="dropdown-item" href="#">AR - Arabic</a>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </nav>
      </header>
    </div>
</template>

<script>
    export default {
        name: "Menu"
    }
</script>

<style scoped>

</style>
