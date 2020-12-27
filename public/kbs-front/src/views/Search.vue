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
                        <button @click="dynamicBackFunc()" class="btn d-block d-sm-inline-block mt-10 mb-sm-0 btn-primary btn-common-2 position-relative font-18 overflow-hidden ripple-btn text-left py-3 px-30 text-white order-sm-1"><i class="fa fa-angle-double-left"></i> Back</button>
                    </div>
                </div>
            </section>


            <section class="category-page-area py-50 py-md-60 text-left">
                <div class="container">
                    <div class="mb-30 mt-20">
                        <h1 class="mb-2">Search Result</h1>
                        <h6 class="heading-thin text-theme-grey font-18">List of Article in give keyword : {{query_string}} </h6>
                    </div>
                    <div class="item-list">
                        <div id="searchList" data-keyword="What is Knowledge Base System?">
                            <div class="topics-category-holder my-20">
                                <div class="topics-category-items">
                                    <ul>
                                        <li v-for="a_article in allArticles" :key="a_article.id">
                                            <!--                      <a href="#" style="font-size: 18px; color: #2bb3c1">{{a_article.en_title}}</a>-->
                                            <router-link :to="{ name: 'ArticleDetail', params: { articleID: a_article.id }}">
                                                {{a_article.en_title}}
                                            </router-link>
                                            <div>
                                                <small style="font-size: 12px;">Post on: {{a_article.created_at}}</small>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-if="allArticles">
                        <div v-for="(a_article,index) in allArticles" :key="a_article.id">
                            <div v-if="index===0">
                                <div v-if="pagination.total > pagination.per_page" class="col-md-offset-4">
                                    <ul class="pagination">
                                        <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                            <a @click.prevent="searchData(pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">First</a>
                                        </li>
                                        <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                            <a @click.prevent="searchData(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                                        </li>
                                        <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                                            <a @click.prevent="searchData('article/search/'+query_string+'?page='+n)" class="px-3 bg-primary text-white py-2 rounded-sm" href="#">{{ n }}</a>
                                        </li>

                                        <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                            <a @click.prevent="searchData(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                                        </li>
                                        <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                            <a @click.prevent="searchData(pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Last</a>
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

import $ from 'jquery'

$(document).on('focus','.search-input-wrapper input', function(){
    $(this).parent().addClass('focused');
});

$(document).on('blur','.search-input-wrapper input', function () {
    let inputValue = $(this).val();
    if ( inputValue == "" ) {
        $(this).removeClass('filled');
        $(this).parents().removeClass('focused');
    } else {
        $(this).addClass('filled');
    }
});
import axios from 'axios'
import Loading from "@/components/Loading"
export default {
    name: "Search",
    data(){
        return{
            isLoading: true,
            query_string:'',
            allArticles:'',
            allSearchQuery:[],
            pagination:{
                from: '',
                to: '',
                first_page_url: '',
                last_page: '',
                last_page_url: '',
                next_page_url:'',
                prev_page_url: '',
                path: '',
                per_page: 10,
                total: ''
            },
        }
    },
    components:{
        Loading,
    },
    methods:{
        searchData(pageUrl){
            let _that = this;
            let query_string = _that.query_string;
            _that.allSearchQuery.push(_that.query_string);
            console.log(_that.allSearchQuery);
            localStorage.setItem("query_string",_that.query_string);
            pageUrl = pageUrl == undefined ? 'article/search/'+query_string+'?page=1' : pageUrl;
            axios.get(pageUrl).then((response)=>{
                _that.isLoading= false;
                _that.allArticles = response.data.article_list.data;
                _that.pagination  = response.data.article_list;
            })
        },
        dynamicBackFunc(){
            let _that = this;
            _that.allSearchQuery = _that.allSearchQuery.slice(0,_that.allSearchQuery.length-1);
            _that.query_string = _that.allSearchQuery[_that.allSearchQuery.length-1]
            let pageUrl;
            pageUrl = pageUrl == undefined ? 'article/search/'+_that.query_string+'?page=1' : pageUrl;
            if (_that.query_string){
                axios.get(pageUrl)
                    .then(function (response) {
                        _that.isLoading= false;
                        _that.allArticles = response.data.article_list.data;
                        _that.pagination  = response.data.article_list;
                    })
            }else{
                _that.$router.push('/');
            }
        }
    },
    created()
    {
        this.query_string = localStorage.getItem("query_string")
        this.searchData();
    },
}
</script>

<style scoped>

</style>
