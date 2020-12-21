<template>
    <div v-cloak>
      <main>
        <section class="inner-search-area py-20">
          <div class="container">
            <div class="search-input-wrapper d-block d-sm-flex justify-content-between">
              <div class="input-group order-sm-2">
                <input type="text" v-on:keyup.enter="searchData()" v-model="query_string" class="form-control" placeholder="Search Here" aria-label="Search Here" aria-describedby="searchBtn">
                <div class="input-group-append">
                  <button class="btn btn-outline-secondary" id="searchBtn" type="button" @click="searchData">
                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-search" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd" d="M10.442 10.442a1 1 0 0 1 1.415 0l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1 0-1.415z"/>
                      <path fill-rule="evenodd" d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
                    </svg>
                  </button>
                </div>
              </div>
              <button @click="dynamicBackFunc()" class="btn d-block d-sm-inline-block mt-10 mb-sm-0 btn-primary btn-common-2 position-relative font-18 overflow-hidden ripple-btn text-left py-3 px-30 text-white order-sm-1"><i class="fa fa-angle-double-left"></i> Back</button>
            </div>
          </div>
        </section>

        <section class="category-details-area py-50 py-md-60 text-left" v-if="aArticle">
          <div class="container">
            <div class="row pb-20">
              <div class="col-lg-9 col-md-8">
                <h1 class="mb-0 font-weight-bold">Articles Details Page</h1>
                <div>
                  <small class="font-16"><strong>Category: </strong>{{aArticle.category.name}}</small>
                </div>
                <p class="font-16"><strong>Tags: </strong>{{aArticle.tag}}</p>
                <div class="ta-wrapper d-flex align-items-center py-10 my-40">
                  <div class="avatar mr-10">
                    <img class="img-fluid" src="../assets/img/avatar.png" style="height: 50px; width: 50px" alt="avatar">
                  </div>
                  <div class="tc-wrapper">
                    <h5 v-cloak class="my-0 pb-1">{{aArticle.user.first_name}} {{aArticle.user.last_name}}</h5>
                    <p class="mb-0">Post on: {{aArticle.created_at}}</p>
                  </div>
                </div>

                <div class="ta-content-wrapper">
                  <h3 class="">{{aArticle.en_title}}</h3>
                </div>
                  <div class="ta-content-wrapper">
                      <p class="text-justify" v-html="aArticle.en_body"></p>
                  </div>

              </div>
              <div class="col-lg-3 col-md-4 text-right">
                <div class="article-sidebar">
                  <div class="sidebar-title">
                    <h3>Recent Articles</h3>
                  </div>
                  <div class="sidebar-content">
                    <ul class="recent-articles list-unstyled">
<!--                      work here-->
                      <li v-for="a_art in allArticle" :key="a_art.id">
                        <a class="recent-article-title" href="#" @click.prevent="articleSearch(a_art.id)">{{a_art.en_title}}</a>
                      </li>
                    </ul>
                  </div>
                  <div class="sidebar-title">
                    <h3>Categories</h3>
                  </div>
                  <div class="sidebar-content">
                    <ul class="recent-articles list-unstyled">
<!--                      work here-->
                      <li v-for="a_cate_art in categoryHasArticle" :key="a_cate_art.id">
                        <router-link :to="{ name: 'CategoryList', params: { categoryID: a_cate_art.id }}">
                          <h6 class="m-0 p-0">{{a_cate_art.name}}</h6>
                        </router-link>
                      </li>
                    </ul>
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
        name: "ArticleDetail",
        data(){
            return{
                articleID:'',
                aArticle:'',
                articleIDArr:[],
                articleCounter:0,
                allCategoryArticle:'',
                categoryHasArticle:[],
                allArticle:'',
                query_string:''
            }
        },
        methods:{
            articleSearch(v){
                let _that = this;
                _that.articleID = v;
                _that.articleCounter++;
                _that.articleIDArr.push(_that.articleID);
                axios.get('article/'+_that.articleID)
                    .then(function (response) {
                        _that.aArticle = response.data.article_info;
                        _that.$router.push('/article-detail/'+_that.articleID)
                    })
            },
            searchData(){
                let _that = this;
                _that.$router.push({ name: 'Search', params: { query_string: _that.query_string } });
            },
            getRecentArticleList(){
                let _that = this;
                axios.get('article-list')
                    .then(function (response) {
                        _that.allArticle = response.data.article_list;
                    })
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
                        }
                    })
            },
            dynamicBackFunc() {
                let _that =this;

                _that.articleIDArr = _that.articleIDArr.slice(0,_that.articleIDArr.length-1);
                _that.articleID = _that.articleIDArr[_that.articleIDArr.length-1];
                if (_that.articleID){
                    axios.get('article/'+_that.articleID)
                        .then(function (response) {
                            _that.aArticle = response.data.article_info;
                            _that.$router.push('/article-detail/'+_that.articleID)
                        })
                }
                else{
                    _that.$router.push('/');
                }
            }
        },
        created() {
            this.articleID = this.$route.params.articleID;
            this.articleSearch(this.articleID);
            this.getCategoryArticleList();
            this.getRecentArticleList();
        }
    }
</script>

<style scoped>

</style>
