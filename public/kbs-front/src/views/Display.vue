<template>
    <div v-if="isLoading">
        <Loading></Loading>
    </div>
    <div v-else class="display min-height-wrapper" v-cloak>
        <main>
            <section class="banner-area py-70 py-md-140" :style="{ backgroundImage: 'url(' + frontPageData.banner + ')' }">
                <div class="container">
                    <div class="search-wrapper text-center">
                        <h1 class="section-title bottom-bar text-white mb-10 pb-20">{{ frontPageData.title }}</h1>
                        <p class="text-white">{{ frontPageData.description }}</p>
                        <!--            form-->
                        <searchform></searchform>

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
                            <div class="featured-item position-relative overflow-hidden bg-white">
                                <router-link :to="{ name: 'CategoryList', params: { categoryID: a_cate_art.slug }}">
                                    <div class="featured-image">
                                        <img class="img-fluid" src="../assets/img/no-image.png" alt="no image">
                                    </div>
                                    <div class="featured-content-box p-15 p-md-30">
                                        <h4 class="mb-10 mb-lg-0 text-center">{{a_cate_art.name}}</h4>
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
                            <div class="featured-item position-relative overflow-hidden bg-white align-items-stretch h-100 border-radius-0">
                                <a href="#">

                                    <div class="featured-image">
                                        <img  v-if="articleImageArray.indexOf(a_latest_art.id)" class="img-fluid" :src="articleImageArray[a_latest_art.id] ? articleImageArray[a_latest_art.id] : static_image " alt="no image">
                                    </div>

                                    <div class="featured-content-box p-15 p-md-20">

                                        <h4 class="mb-15 font-18" v-if="(a_latest_art.en_title).length<35"> {{ a_latest_art.en_title }}</h4>
                                        <h4 class="mb-15 font-18" v-else> {{ (a_latest_art.en_title).substring(0,35)+"..." }}</h4>

                                        <p class="font-14 mb-0" v-if="(a_latest_art.en_short_summary)== null"> N/A </p>
                                        <p class="font-14 mb-0" v-else-if="(a_latest_art.en_short_summary).length < 100"> {{ a_latest_art.en_short_summary }} </p>
                                        <p class="font-14 mb-0" v-else> {{ (a_latest_art.en_short_summary).substring(0,100)+"..." }}</p>

                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="topics-area py-50 py-md-60">
                <div class="container">
                    <div class="row justify-content-md-center">
                        <div class="col-lg-8">
                            <h1 class="section-title bottom-bar text-center mb-10 pb-20">Faq</h1>
                            <p class="font-20 text-center pt-10">Frequently Asked Questions</p>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
</template>

<script>
    import searchform from "@/components/Search";
    import Loading from "@/components/Loading";
    import axios from 'axios'
    export default {
        name: "Display",
        components:{
            searchform,
            Loading
        },
        data() {
            return {
                static_image : 'http://localhost/ccKnowledgeBase/public/kbs-front/src/assets/img/no-image.png',
                isLoading : true,
                allCategoryArticle:'',
                frontPageData :'',
                categoryHasArticle:[],
                allLatestArticles : '',
                regexImg           : /<img[^>]+src="(http:\/\/[^">]+)"/g,
                articleImageArray : []
            }
        },
        methods:{
            getCategoryArticleList()
            {
                let _that =this;
                axios.get('category-article-list', { cache: false })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            // console.log(response.data.category_list);
                            _that.isLoading = false;
                            _that.allCategoryArticle = response.data.category_list;
                            _that.allCategoryArticle.forEach(val =>{
                                if (val.article.length!=0){
                                    if (_that.categoryHasArticle.length <12){
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

                            response.data.article_list.forEach(val => {
                                if ( val.en_body.includes('<img '))
                                {
                                    _that.articleImageArray[val.id]  = _that.regexImg.exec(val.en_body)[1];
                                }

                            })

                            console.log(_that.articleImageArray);
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
            }
        },
        created()
        {
            this.getPageDecorationData();
            this.getCategoryArticleList();
            this.getLatestArticleList();
        }
    }
</script>

<style scoped>

</style>
