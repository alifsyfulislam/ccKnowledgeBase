<template>
  <div>
<!--    before data load-->
    <div v-if="isLoading">
      <Loader/>
    </div>

    <div v-cloak v-else class="display min-height-wrapper">
      <main>
        <section class="banner-area d-flex align-items-center py-70 py-md-150" :style="{ backgroundImage: 'url(' + (frontPageData.banner ? frontPageData.banner : static_image['banner']) + ')' }">
          <div class="container d-flex justify-content-center justify-content-md-start">
            <div class="search-wrapper position-relative">
              <h1 class="section-title pb-10 mb-0 text-center">{{ frontPageData ? frontPageData.title : 'n/a' }}</h1>
              <p class="text-center">{{ frontPageData ? frontPageData.description : 'n/a' }}</p>
<!--              display search form-->
              <search-form/>
            </div>
          </div>
        </section>

        <section class="topics-area py-50 py-md-60">
          <div class="container">
            <div class="row justify-content-md-center">
              <div class="col-lg-8">
                <h1 class="section-title bottom-bar text-center mb-10 pb-20">Explore Categories</h1>
                <p class="font-20 text-center pt-10">We did our best to cover all topics related to this product. Each section have number which represent number of topic in each category.</p>
              </div>
            </div>

            <div class="row text-left">
              <div class="col-xl-4 col-lg-4 mb-30" v-for="a_cate_art in categoryHasArticle" :key="a_cate_art.id">
                <div class="featured-item position-relative overflow-hidden bg-white align-items-stretch h-100">
                  <router-link :to="{ name: 'CategoryList', params: { categoryID: a_cate_art.slug }}">
                    <div class="featured-image" >
                      <img class="img-fluid"  :src="(a_cate_art.media).length > 0 ? a_cate_art.media[0].url  :static_image['category']" alt="no image">
                    </div>
                    <div class="featured-content-box p-15 p-md-30">
                      <h4 class="mb-10 mb-lg-0 text-center">{{ a_cate_art.name }}</h4>
                    </div>
                  </router-link>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section class="topics-area py-50 py-md-60">
          <div class="container">
            <div class="row justify-content-md-center">
              <div class="col-lg-8">
                <h1 class="section-title bottom-bar text-center mb-10 pb-20">Featured Articles</h1>
                <p class="font-20 text-center pt-10">We did our best to cover all topics related to this product.</p>
              </div>
            </div>

            <div class="row text-left">
              <div class="col-xl-4 col-lg-4 mb-30" v-for="a_latest_art in allLatestArticles" :key="a_latest_art.id">
                <div class="featured-item position-relative overflow-hidden bg-white align-items-stretch h-100">
                  <router-link class="article-item-box d-block bg-white position-relative align-items-stretch h-100 overflow-hidden" :to="{ name: 'ArticleDetail', params: { articleID: a_latest_art.slug }}">
                    <div class="featured-image">
                      <img :src="((a_latest_art.en_body).match(regexImg) ? (a_latest_art.en_body).match(regexImg)[0]: static_image['article'] )" alt="no image" class="img-fluid">
                    </div>
                    <div class="featured-content-box p-15 p-md-20">
                      <h4 class="mb-15 font-18" v-if="(a_latest_art.en_title).length<35"> {{ a_latest_art.en_title }}</h4>
                      <h4 class="mb-15 font-18" v-else> {{ (a_latest_art.en_title).substring(0,35)+"..." }}</h4>

                      <p class="font-14 mb-0" v-if="(a_latest_art.en_short_summary)== null"> N/A </p>
                      <p class="font-14 mb-0" v-else-if="(a_latest_art.en_short_summary).length < 100"> {{ a_latest_art.en_short_summary }} </p>
                      <p class="font-14 mb-0" v-else> {{ (a_latest_art.en_short_summary).substring(0,100)+"..." }}</p>
                    </div>
                  </router-link>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section class="topics-area py-50 py-md-60">
          <div class="container">
            <div class="row justify-content-md-center">
              <div class="col-lg-8">
                <h1 class="section-title bottom-bar text-center mb-10 pb-20">FAQ</h1>
                <p class="font-20 text-center pt-10">Frequently Asked Questions</p>
              </div>
            </div>

            <div class="row">
              <div class="col-lg-12" style="min-height: 350px ; ">
                <div class="custom-accordion" v-for="a_faq in all_Faqs" :key="a_faq.id">
                  <div class="heading">{{a_faq.en_title}}</div>
                  <div class="contents" v-html="a_faq.en_body"></div>
                </div>
              </div>

            </div>

          </div>
        </section>
      </main>
    </div>

  </div>
</template>

<script>
import Loader from "@/components/Loader";
import SearchForm from "@/components/Search";

import $ from 'jquery'
import axios from "axios";

$(document).on('click','.custom-accordion .heading', function () {
  $(this).toggleClass("active").next().slideToggle();
  $(".contents").not($(this).next()).slideUp(200);
  $(this).siblings().removeClass("active");
});

export default {
  name: 'Home',
  components : {
    Loader,
    SearchForm
  },
  data() {
    return {
      static_image            : [],
      isLoading               : true,
      allCategoryArticle      : '',
      frontPageData           : '',
      categoryHasArticle      : [],
      allLatestArticles       : '',
      // regexImg                : /<img[^>]+src="(http:\/\/[^">]+)"/g,
      regexImg                : /(http:\/\/[^">]+)/img,
      all_Faqs                : '',
    }
  },
  methods:{
    getCategoryArticleList()
    {
      let _that =this;
      axios.get('category-article-list', { cache: false })
        .then(function (response) {
          if(response.data.status_code === 200){
            _that.isLoading = false;
            _that.allCategoryArticle = response.data.category_list;
            _that.allCategoryArticle.forEach(val =>{
              if (val.article.length!=0){
                if (_that.categoryHasArticle.length <6){
                  _that.categoryHasArticle.push(val);
                }
              }
            })
          }
        })
    },
    getLatestArticleList()
    {
      let _that =this;

      axios.get('article-list')
        .then(function (response) {
          if(response.data.status_code === 200){
            _that.allLatestArticles = response.data.article_list;
          }
        })
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
    },

    getStaticMedia()
    {
      this.static_image['category'] = axios.defaults.baseURL.replace('api/','')+'static_media/no-image.png';
      this.static_image['article'] = axios.defaults.baseURL.replace('api/','')+'static_media/no-image.png';
      this.static_image['banner'] = axios.defaults.baseURL.replace('api/','')+'static_media/banner.png';
      this.static_image['newlogo'] = axios.defaults.baseURL.replace('api/','')+'static_media/new-logo.png';
      this.static_image['smalllogo'] = axios.defaults.baseURL.replace('api/','')+'static_media/small-logo.png';
    },

    allFaqs(){
      let _that = this;
      axios.get('faq-list',{
        params : {
          isLatest : 1
        },
      })
        .then(function (response) {
          _that.all_Faqs = response.data.faq_list;
        })
    },
  },
  created()
  {
    this.getStaticMedia()
    this.getPageDecorationData();
    this.getCategoryArticleList();
    this.getLatestArticleList();
    this.allFaqs();
    localStorage.removeItem('category-article-list');
  },
  mounted () {
    document.body.classList.add('home')
  },
  destroyed () {
    document.body.classList.remove('home')
  },
}
</script>

<style scoped>
.banner-area .section-title:first-letter {
  color: #d84a4f;
}
</style>
