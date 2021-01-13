<template>
    <div v-if="isLoading">
        <Loading></Loading>
    </div>
    <div v-else class="display min-height-wrapper" v-cloak>
        <main>
            <section class="banner-area py-50 py-md-140" :style="{ backgroundImage: 'url(' + frontPageData.banner + ')' }">
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
                        <div class="col-xl-4 col-lg-4" v-for="a_cate_art in categoryHasArticle" :key="a_cate_art.id">
                            <div class="topics-category-holder my-20">
                                <div class="topics-category-title mb10">
                                    <!--                  work-->
                                    <router-link :to="{ name: 'CategoryList', params: { categoryID: a_cate_art.id }}">
                                        <h4 class="mb-3">{{a_cate_art.name}}</h4>
                                    </router-link>
                                </div>
                                <div class="topics-category-items pb-10" style="min-height: 190px">
                                    <ul>
                                        <!--                    work-->
                                        <li v-for="a_article in a_cate_art.article" :key="a_article.id">
                                            <router-link :to="{ name: 'ArticleDetail', params: { articleID: a_article.id }}">
<!--                                                {{a_article.en_title}}-->
                                                <span v-if="(a_article.en_title).length<50"> {{ a_article.en_title }}</span>
                                                <span v-else> {{ (a_article.en_title).substring(0,50)+"..." }}</span>
                                            </router-link>
                                        </li>
                                    </ul>
                                </div>
                                <div class="topics-category-footer mt-20 pb-20">
                                    <router-link class="btn btn-outline-primary btn-block py-3" :to="{ name: 'CategoryList', params: { categoryID: a_cate_art.id }}">
                                        <h4 class="mb-0">Explore All</h4>
                                    </router-link>
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
            return{
                isLoading : true,
                allCategoryArticle:'',
                frontPageData :'',
                categoryHasArticle:[],
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
                                    _that.categoryHasArticle.push(val);
                                }
                            })
                        }
                    })
            },

            getPageDecorationData()
            {
                let _that =this;
                axios.get('front-page-config', { cache: false })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            console.log(response.data.page_config_info);
                            _that.frontPageData = response.data.page_config_info;

                            // if (_that.frontPageData.position === "left")
                            // {
                            //     _that.frontPageData.position = 'text-left';
                            // }
                            // else if (_that.frontPageData.position === "right")
                            // {
                            //     _that.frontPageData.position = 'text-right';
                            // }else{
                            //     _that.frontPageData.position = 'text-center';
                            // }
                        }
                    })
            }
        },
        created()
        {
            this.getPageDecorationData();
            this.getCategoryArticleList();
        }
    }
</script>

<style scoped>

</style>
