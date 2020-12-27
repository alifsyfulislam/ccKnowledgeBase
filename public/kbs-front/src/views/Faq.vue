<template>
  <div v-cloak class="min-height-wrapper">
    <main>
      <section class="inner-search-area py-20">
        <div class="container">
          <div class="search-input-wrapper d-block d-sm-flex justify-content-between">
            <button @click="$router.go(-1)" class="btn d-block d-sm-inline-block mt-10 mb-sm-0 btn-primary btn-common-2 position-relative font-18 overflow-hidden ripple-btn text-left py-3 px-30 text-white order-sm-1"><i class="fa fa-angle-double-left"></i> Back</button>
          </div>
        </div>
      </section>
      <section class="faq-page-area py-50 py-md-60">
        <div class="container text-left">
          <h1 class="mb-3">FAQ</h1>
          <h6 class="heading-thin text-theme-grey font-18 pb-20">Frequently Asked Questions</h6>

          <div style="min-height: 350px">
            <div class="custom-accordion" v-for="a_faq in all_Faqs" :key="a_faq.id">
              <div class="heading">{{a_faq.en_title}}</div>
              <div class="contents" v-html="a_faq.en_body"></div>
            </div>
          </div>
        </div>
      </section>
    </main>
  </div>
</template>

<script>

    import $ from 'jquery'

    $(document).on('click','.custom-accordion .heading', function () {
        $(this).toggleClass("active").next().slideToggle();
        $(".contents").not($(this).next()).slideUp(200);
        $(this).siblings().removeClass("active");
    });
    import axios from 'axios'
    export default {
        name: "Faq",

        data(){
            return{
                all_Faqs:''
            }
        },
        methods:{
            allFaqs(){
                let _that = this;
                axios.get('faqs')
                    .then(function (response) {
                        console.log(response.data.faq_list.data);
                        _that.all_Faqs = response.data.faq_list.data;
                    })
            },
        },
        created() {
            this.allFaqs();
        }
    }
</script>

<style scoped>

</style>
