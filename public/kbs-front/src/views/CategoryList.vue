<template>
<div v-cloak>
  <main>
    <section class="inner-search-area py-20">
      <div class="container">
        <div class="search-input-wrapper d-block d-sm-flex justify-content-between">
          <div class="input-group order-sm-2">
            <input type="text" class="form-control" v-on:keyup.enter="searchData()" v-model="query_string" placeholder="Search Here" aria-label="Search Here" aria-describedby="searchBtn">
            <div class="input-group-append">
              <button class="btn btn-outline-secondary" id="searchBtn" type="button" @click="searchData">
                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-search" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                  <path fill-rule="evenodd" d="M10.442 10.442a1 1 0 0 1 1.415 0l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1 0-1.415z"/>
                  <path fill-rule="evenodd" d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
                </svg>
              </button>
            </div>
          </div>
          <button @click="$router.go(-1)" class="btn d-block d-sm-inline-block mt-10 mb-sm-0 btn-primary btn-common-2 position-relative font-18 overflow-hidden ripple-btn text-left py-3 px-30 text-white order-sm-1"><i class="fa fa-angle-double-left"></i> Back</button>
        </div>
      </div>
    </section>
    <section class="category-page-area py-50 py-md-60">
      <div class="container">
        <div class="row">
          <div class="col-lg-4 col-md-5 text-left" v-if="categoryHasArticle">
            <h4 class="mt-20">Categories</h4>
            <div class="topics-category-categories my-20">
              <ul class="nav nav-pills flex-column">
                <li class="nav-item" v-for="(a_cat_art) in categoryHasArticle" :key="a_cat_art.id">
                  <a class="nav-link active" href="#" @click.prevent="categorySearch(a_cat_art.id)">
                    <h6>{{a_cat_art.name}}</h6>
                  </a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-lg-8 col-md-7" v-if="selectedCategory">
            <div class="mb-30 mt-20">
              <h1 class="mb-3">ARTICLE LIST</h1>
              <h6 class="heading-thin text-theme-grey font-18">Getting Started</h6>

              <div class="item-list text-left">
                <div class="topics-category-holder my-20">
                  <div class="topics-category-items pb-10">

                    <div>
                      <ul>
                        <li v-for="has_article in selectedCategory" :key="has_article.id">
                          <router-link :to="{ name: 'ArticleDetail', params: { articleID: has_article.id }}">
                            {{has_article.en_title}}
                          </router-link>
                          <div v-for="(a_cat_art) in categoryHasArticle" :key="a_cat_art.id">
                            <small v-if="a_cat_art.id == has_article.category_id">Category: {{a_cat_art.name}}</small>
                          </div>
                          <div>
                            <small>Post on: {{has_article.created_at}}</small>
                          </div>
                        </li>
                      </ul>
                    </div>
                  </div>
                </div>
                <div v-if="selectedCategory">
                  <div v-for="(has_article,index) in selectedCategory" :key="has_article.id">
                    <div v-if="index===0">
                      <div v-if="pagination.total > pagination.per_page" class="col-md-offset-4">
                        <ul class="pagination">
                          <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                            <a @click.prevent="changeCategoryArticlePage(has_article.category_id,pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">First</a>
                          </li>
                          <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                            <a @click.prevent="changeCategoryArticlePage(has_article.category_id,pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                          </li>
                          <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                            <a @click.prevent="changeCategoryArticlePage(has_article.category_id,'article/category/'+has_article.category_id+'?page='+n)" class="px-3 bg-primary text-white py-2 rounded-sm" href="#">{{ n }}</a>
                          </li>

                          <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                            <a @click.prevent="changeCategoryArticlePage(has_article.category_id,pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                          </li>
                          <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                            <a @click.prevent="changeCategoryArticlePage(has_article.category_id,pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Last</a>
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
    import axios from 'axios'
    export default {
        name: "CategoryList",
        data(){
            return{
                allCategoryArticle:'',
                categoryHasArticle:[],
                categoryID:'',
                selectedCategory:'',
                query_string:'',
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
            searchData(){
                let _that = this;
                _that.$router.push({ name: 'Search', params: { query_string: _that.query_string } });
            },
            getCategoryArticleList()
            {
                let _that =this;
                axios.get('category-article-list', { cache: false })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            _that.allCategoryArticle = response.data.category_list;
                            _that.allCategoryArticle.forEach(val =>{
                                if (val.article.length!=0){
                                    _that.categoryHasArticle.push(val);
                                }
                            })
                            console.log(_that.categoryHasArticle);
                        }
                    })
            },
            categorySearch(v) {
                let _that = this;
                let category_ID = v;
                let pageUrl;
                pageUrl = pageUrl == undefined ? 'article/category/'+category_ID+'?page=1' : pageUrl;
                console.log(pageUrl);
                axios.get(pageUrl)
                    .then(function (response) {
                        _that.selectedCategory = response.data.article_list.data;
                        _that.pagination  = response.data.article_list;
                    })
            },
            changeCategoryArticlePage(categoryID,pageUrl){
                console.log(categoryID,pageUrl);
                let _that =this;
                pageUrl = pageUrl == undefined ? 'admin/articles'+categoryID : pageUrl;
                axios.get(pageUrl)
                    .then(function (response) {
                        _that.selectedCategory = response.data.article_list.data;
                        _that.pagination  = response.data.article_list;
                    })
            },
        },
        created() {
            this.categoryID = this.$route.params.categoryID;
            this.getCategoryArticleList();
            this.categorySearch(this.categoryID);
        }
    }
</script>

<style scoped>

</style>
