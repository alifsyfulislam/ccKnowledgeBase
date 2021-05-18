<template>
  <div v-if="isLoading">
    <Loader></Loader>
  </div>
  <div v-else v-cloak class="min-height-wrapper">
    <main>
      <section class="inner-search-area py-20">
        <div class="container">
          <div class="search-input-wrapper d-block d-sm-flex justify-content-between align-items-center">
            <div class="search-input-box position-relative order-sm-2">
              <div class="input-group" style="max-width: 100%;width: 100%;">
                <input type="text" class="form-control" v-on:keyup.enter="query_string ? searchData() : ''" v-model="query_string"  placeholder="Search Article Here"  v-on:keyup="autoSuggetion" aria-label="Search Here" aria-describedby="searchBtn">
                <div class="input-group-append">
                  <button class="btn btn-outline-secondary" id="searchBtn" type="button" @click="query_string ? searchData() : ''">
                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-search" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd" d="M10.442 10.442a1 1 0 0 1 1.415 0l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1 0-1.415z"/>
                      <path fill-rule="evenodd" d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
                    </svg>
                  </button>
                </div>
              </div>
              <div v-if="suggestedArtiles.length" class="search-suggestion" style="left:0; width: 100%">
                <ul>
                  <li  v-for="a_suggestion in suggestedArtiles" :key="a_suggestion.id"><router-link class="" :to="{ name: 'ArticleDetail', params: { articleID: a_suggestion.id,articleSlug: a_suggestion.slug }}">{{a_suggestion.en_title.length < 50 ? a_suggestion.en_title : (a_suggestion.en_title).substring(0,50)+"..."}}</router-link></li>

                </ul>
              </div>
            </div>

            <!-- <button @click="dynamicBackFunc()" class="btn d-block d-sm-inline-block mt-10 mb-sm-0 btn-primary btn-common-2 position-relative font-18 overflow-hidden ripple-btn text-left py-3 px-30 text-white order-sm-1"><i class="fa fa-angle-double-left"></i> Back</button> -->
            <div class="breadcrumbs mt-10 mt-sm-0">
              <ul class="list-inline list-unstyled mb-0">
                <li class="list-inline-item">
                  <router-link class="nav-item" :to="{ name: 'Home'}">
                    <i class="fa fa-home"></i>
                  </router-link>
                </li>
                <li class="list-inline-item">
                  <router-link :to="{ name: 'CategoryList', params: { categoryID: routePath ? routePath : categoryID }}">
                    categories
                  </router-link>
                </li>
                <li class="list-inline-item">{{ routePath ? routePath : categoryID }}</li>
              </ul>
            </div>
          </div>
        </div>
      </section>
      <section class="category-page-area py-50 py-md-60">
        <div class="container">
          <div class="row">
            <div class="col-lg-4 col-md-5 text-left" v-if="categoryHasArticle">
              <div class="menu-wrapper cat-menu-wrapper bg-white mb-50">
                <h3 class="menu-title mb-20 p-15">Categories</h3>

                <div class="nav nav-pills flex-column d-block px-15" v-for="a_cate_art in categoryHasArticle" :key="a_cate_art.id">
                  <ul class="list-unstyled list-inline mb-0">
                    <tree-view class="item" :item="a_cate_art"></tree-view>
                  </ul>

                </div>
              </div>

              <!-- <div class="menu-wrapper bg-white mt-30">
              <h3 class="menu-title mb-20 p-15">Tags</h3>
              <ul class="list-inline list-unstyled px-15 pb-15 tag-list-wrapper">
              <li class="d-inline-block"><a href="#">Sports</a></li>
              <li class="d-inline-block"><a href="#">Reactjs</a></li>
              <li class="d-inline-block"><a href="#">covid 19</a></li>
              <li class="d-inline-block"><a href="#">Sci-fi</a></li>
              </ul>
              </div>-->
            </div>

            <div class="col-lg-8 col-md-7" v-if="selectedCategory">
              <div class="mb-30 mt-0">
                <h1 class="mb-3">ARTICLE LIST</h1>
                <h6 class="heading-thin text-theme-grey font-18 mb-20">Getting Started</h6>
                <div class="row article-list-items" v-for="(has_article) in selectedCategory" :key="has_article.id">
                  <div class="col-lg-12 mb-15">
                    <router-link class="article-item-list-box d-sm-flex position-relative overflow-hidden" :to="{ name: 'ArticleDetail', params: { articleID: has_article.id,articleSlug: has_article.slug }}">
                      <div class="article-list-image mb-20 mb-sm-0" v-if="has_article.contents == ''">
                        <img :src="static_image['article']" alt="no image" class="img-fluid">
                      </div>

                      <div v-for="a_content in has_article.contents" :key="a_content.id">
                        <div class="article-list-image mb-20 mb-sm-0"  v-if="a_content.en_body.match(regexImg)">
                          <img :src="((a_content.en_body).match(regexImg) ? (a_content.en_body).match(regexImg)[0]: static_image['article'] )" alt="no image" class="img-fluid">
                        </div>
                        <div class="article-list-image mb-20 mb-sm-0" v-else>
                          <img :src="static_image['article']" alt="no image" class="img-fluid">
                        </div>
                      </div>
                      <div class="article-content-list-box pl-0 pl-sm-10">
                        <h3 class="article-list-title mb-0 pb-2 font-20">
                          <span v-if="(has_article.en_title).length<70"> {{ has_article.en_title }}</span>
                          <span v-else> {{ (has_article.en_title).substring(0,70)+"..." }}</span>
                        </h3>
                        <small class="font-8 mb-0 d-block pb-2">Published at: {{has_article.created_at}}</small>
                        <p class="font-14 mb-0" v-if="(has_article.en_short_summary).length<200">{{has_article.en_short_summary}}</p>
                        <p class="font-14 mb-0" v-else>{{(has_article.en_short_summary).substring(0,200)+"..."}}</p>
                      </div>
                    </router-link>
                  </div>

<!--                  <div v-else>-->
<!--                    <h3>No article found!!</h3>-->
<!--                  </div>-->
                </div>

                <div class="item-list text-left">
                  <div v-if="selectedCategory">
                    <div v-for="(has_article, index) in selectedCategory" :key="has_article.id">
                      <div v-if="index === 0">
                        <div v-if="pagination.total > pagination.per_page" class="col-md-offset-4">
                          <ul class="pagination">
                            <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                              <a @click.prevent="changeCategoryArticlePage(has_article.category.slug,pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                            </li>
                            <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                              <a @click.prevent="changeCategoryArticlePage(has_article.category.slug,pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
                            </li>
                            <li v-for="n in pagination.last_page" class="page-item mx-1" :key="n">
                              <a @click.prevent="changeCategoryArticlePage(has_article.category.slug,'article/category/'+has_article.category.slug+'?page='+n)" class="px-3 bg-primary text-white py-2 rounded-sm" href="#">{{ n }}</a>
                            </li>

                            <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                              <a @click.prevent="changeCategoryArticlePage(has_article.category.slug,pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                            </li>
                            <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                              <a @click.prevent="changeCategoryArticlePage(has_article.category.slug,pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>


          </div>
        </div>
      </section>
    </main>
  </div>
</template>

<script>
import Loader from "../components/Loader";
import TreeView from "@/components/TreeView";
import axios from 'axios'
// import searchform from "@/components/Search";
export default {
  name: "CategoryList",
  components:{
    Loader,
    TreeView
// searchform
  },
  watch: {
    '$route.params': 'functionToRunWhenParamsChange',
  },
  data(){
    return{
      categoryArticleList : '',
      routePath : '',
      isLoading: true,
      allCategoryArticle:'',
      categoryHasArticle:[],
      categoryID:'',
      suggestedArtiles:[],
      categoryIDArr:[],
      selectedCategory:'',
      selectedCategoryArr : [],
      query_string:'',
      regexImg : /(http:\/\/[^">]+)/img,
      static_image : [],
      pagination:{
        from: '',
        to: '',
        first_page_url: '',
        last_page: '',
        last_page_url: '',
        next_page_url:'',
        prev_page_url: '',
        path: '',
        per_page: 5,
        total: ''
      },

    }
  },
  methods:{
    functionToRunWhenParamsChange(){
      if ((this.$route.fullPath).includes('/category-list')){
        this.categoryArticleList = JSON.parse(localStorage.getItem('category-article-list'));
        this.changeCategoryArticlePage(this.categoryArticleList.slug);
        this.categoryID = this.categoryArticleList.slug;
      }

    },
    getStaticMedia()
    {
      this.static_image['category'] = axios.defaults.baseURL.replace('api/','')+'static_media/no-image.png';
      this.static_image['article'] = axios.defaults.baseURL.replace('api/','')+'static_media/no-image.png';
      this.static_image['banner'] = axios.defaults.baseURL.replace('api/','')+'static_media/banner.jpg';
    },

    searchData(){
      let _that = this;
      if (localStorage.query_string){
        localStorage.setItem('query_string','');
        localStorage.setItem('query_string',this.query_string);
      }else{
        localStorage.setItem('query_string',this.query_string);
      }
      _that.$router.push({ name: 'Search'});
    },
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
                _that.categoryHasArticle.push(val);
              }
            })
          }
        })
    },

    categorySearch(v) {
      let _that = this;
      _that.categoryID = v;
      let pageUrl;
      pageUrl = pageUrl == undefined ? 'article/category/'+_that.categoryID+'?page=1' : pageUrl;
      axios.get(pageUrl)
        .then(function (response) {
          console.log(response.data.article_list.data);
          _that.selectedCategory = response.data.article_list.data;
          console.log(_that.selectedCategory);
          _that.pagination = response.data.article_list;
          _that.$router.push('/category-list/'+_that.categoryID)
        })
    },

    autoSuggetion(e) {
      let _that = this;
      _that.suggestedArtiles = [];
      if(e.target.value.length>3){
          setTimeout(()=>{
            axios.get('article/search/'+e.target.value)
                    .then(function (res) {
                      _that.suggestedArtiles = res.data.article_list.data;
                      console.log(_that.suggestedArtiles);
                    })
          },500);
      }
      
    },

    changeCategoryArticlePage(categoryID,pageUrl){
      window.scrollTo(0, 0);
      let _that = this;
      pageUrl = pageUrl == undefined ? 'article/category/'+categoryID+'?page=1' : pageUrl;
// console.log(pageUrl);

      axios.get(pageUrl)
        .then(function (response) {
          _that.selectedCategory = response.data.article_list.data;
          _that.pagination = response.data.article_list;
          _that.$router.push('/category-list/'+_that.categoryID)
        })
    },

// dynamicBackFunc(){
// let _that = this;
//
// that.selectedCategoryArr = that.selectedCategoryArr.slice(0,_that.selectedCategoryArr.length-1);
//
// that.categoryID = that.selectedCategoryArr[_that.selectedCategoryArr.length-1]
//
// let pageUrl;
// pageUrl = pageUrl == undefined ? 'article/category/'+_that.categoryID+'?page=1' : pageUrl;
//
// if (_that.categoryID){
// axios.get(pageUrl)
// .then(function (response) {
// _that.selectedCategory = response.data.article_list.data;
// _that.pagination = response.data.article_list;
// })
// }else{
// _that.$router.push('/');
// }
// }
  },
  created() {
    this.categoryID = this.$route.params.categoryID;
    this.getCategoryArticleList();
    this.categorySearch(this.categoryID);
    this.getStaticMedia();
  }
}
</script>
