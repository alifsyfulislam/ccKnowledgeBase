<template>
    <div>
      <section class="inner-search-area py-20">
        <div class="container">
          <div class="search-input-wrapper d-block d-sm-flex justify-content-between">
            <button @click="$router.go(-1)" class="btn d-block d-sm-inline-block mt-10 mb-sm-0 btn-primary btn-common-2 position-relative font-18 overflow-hidden ripple-btn text-left py-3 px-30 text-white order-sm-1"><i class="fa fa-angle-double-left"></i> Back</button>
          </div>
        </div>
      </section>

      <section class="category-page-area pt-50 pb-50 pt-md-60 pb-md-100">
        <div class="container pb-0 pb-md-140">
          <h1 class="section-title bottom-bar text-center mb-20 pb-10">404</h1>
          <h6 class="heading-thin text-theme-grey font-18">Page Not Found</h6>
        </div>
      </section>
    </div>
</template>

<script>
    export default {
        name: "NotFound"
    }
</script>

<style scoped>

</style>
