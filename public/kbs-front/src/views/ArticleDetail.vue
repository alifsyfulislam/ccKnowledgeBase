<template>
    <div v-if="isLoading">
        <Loading></Loading>
    </div>
    <div v-else v-cloak class="min-height-wrapper">
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
                                <small class="font-16"><strong>Category: </strong>{{aArticle.category ? aArticle.category.name : 'N/A'}}</small>
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
                                <div v-html="aArticle.en_body"></div>
                            </div>

                        </div>
                        <div class="col-lg-3 col-md-4">
                            <div class="article-sidebar">
                                <div class="menu-wrapper bg-white mb-30">
                                    <h3 class="menu-title mb-0 p-15">Recent Articles</h3>
                                    <ul class="nav nav-pills flex-column pb-10">
                                        <li class="nav-item" v-for="a_art in allArticle" :key="a_art.id">
                                            <a class="nav-link px-0 py-0"  href="#" @click.prevent="articleSearch(a_art.slug)">
                                                <div class="recent-article-item-wrapper d-flex">
                                                    <div class="ra-item-image">
                                                        <img  v-if="articleImageArray.indexOf(a_art.id)" class="img-fluid" :src="articleImageArray[a_art.id] ? articleImageArray[a_art.id] : static_image['article'] " alt="no image">
                                                    </div>
                                                    <div class="ra-item-content">
                                                        <span v-if="(a_art.en_title).length<40"> {{ a_art.en_title }}</span>
                                                        <span v-else> {{ (a_art.en_title).substring(0,40)+"..." }}</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="menu-wrapper bg-white mb-30">
                                    <h3 class="menu-title mb-20 p-15">Categories</h3>
                                    <ul class="nav nav-pills flex-column px-15 pb-15">
                                        <li class="nav-item" v-for="a_cate_art in categoryHasArticle" :key="a_cate_art.id">
                                            <router-link :to="{ name: 'CategoryList', params: { categoryID: a_cate_art.slug }}">
                                                {{a_cate_art.name}}
                                            </router-link>
                                        </li>
                                    </ul>
                                </div>

                                <!-- <div class="sidebar-content">
                                  <ul class="recent-articles list-unstyled">
                                    <li v-for="a_art in allArticle" :key="a_art.id">
                                      <a class="recent-article-title" href="#" @click.prevent="articleSearch(a_art.slug)">
                                          <span v-if="(a_art.en_title).length<30"> {{ a_art.en_title }}</span>
                                          <span v-else> {{ (a_art.en_title).substring(0,30)+"..." }}</span>
                                      </a>
                                    </li>
                                  </ul>
                                </div> -->
                                <!-- <div class="sidebar-title">
                                  <h3>Categories</h3>
                                </div>
                                <div class="sidebar-content">
                                  <ul class="recent-articles list-unstyled">
                                    <li v-for="a_cate_art in categoryHasArticle" :key="a_cate_art.id">
                                      <router-link :to="{ name: 'CategoryList', params: { categoryID: a_cate_art.id }}">
                                        <h6 class="m-0 p-1">{{a_cate_art.name}}</h6>
                                      </router-link>
                                    </li>
                                  </ul>
                                </div> -->
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
</template>

<script>
import Loading from "@/components/Loading";
import axios from 'axios'
export default {
    name: "ArticleDetail",
    components:{
        Loading,
    },
    data(){
        return{
            isLoading : true,
            articleID:'',
            aArticle:'',
            articleIDArr:[],
            articleCounter:0,
            allCategoryArticle:'',
            categoryHasArticle:[],
            allArticle:'',
            query_string:'',


            static_image            : [],
            regexImg                : /(http:\/\/[^">]+)/g,
            articleImageArray       : []
        }
    },
    methods:{
        articleSearch(v){
            let _that = this;
            _that.articleID = v;
            _that.articleCounter++;
            _that.articleIDArr.push(_that.articleID);
            axios.get('article-details/'+_that.articleID)
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

                    response.data.article_list.forEach(val => {
                        if ( val.en_body.includes('<img '))
                        {
                            // _that.articleImageArray[val.id]  = _that.regexImg.exec(val.en_body)[1];
                            _that.articleImageArray[val.id]  = val.en_body.match( _that.regexImg)? val.en_body.match( _that.regexImg)[0] : _that.static_image['article'];
                        }

                    })
                })
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
        dynamicBackFunc() {
            let _that =this;
            _that.articleIDArr = _that.articleIDArr.slice(0,_that.articleIDArr.length-1);
            _that.articleID = _that.articleIDArr[_that.articleIDArr.length-1];
            if (_that.articleID){
                axios.get('article-details/'+_that.articleID)
                    .then(function (response) {
                        _that.aArticle = response.data.article_info;
                        _that.$router.push('/article-detail/'+_that.articleID)
                    })
            }
            else{
                _that.$router.push('/');
            }
        },

        getStaticMedia()
        {
            this.static_image['category'] = axios.defaults.baseURL.replace('api','')+'media/no-image.png';
            this.static_image['article'] = axios.defaults.baseURL.replace('api','')+'media/no-image.png';
            this.static_image['banner'] = axios.defaults.baseURL.replace('api','')+'media/banner.jpg';
        }
    },
    created() {
        this.articleID = this.$route.params.articleID;
        this.articleSearch(this.articleID);
        this.getCategoryArticleList();
        this.getStaticMedia();
        this.getRecentArticleList();
        localStorage.clear();
    }
}
</script>

<style scoped>

</style>
