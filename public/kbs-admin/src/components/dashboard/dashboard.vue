<template>
    <div class="main-wrapper d-flex">
        <!-- sidebar -->
        <Menu></Menu>
        <!-- sidebar end -->

        <div class="main-content-wrapper w-100 position-relative overflow-auto">
            <!-- Topbar -->
            <Header></Header>
            <!-- Topbar End -->

            <!-- Content Area -->
            <div class="content-area">
                <div class="content-title-wrapper px-15 py-15">
                    <h2 class="content-title text-uppercase m-0">Dashboard</h2>
                </div>

                <div class="content-wrapper">
                    <!-- Content Area -->
                    <div class="data-content-area pr-15 pb-10">
                        <div class="gredient-card-wrapper mb-40">
                            <div class="gredient-card-header p-10" style="background:#f8f9fa;color:#323232;">
                                <h2 class="card-title my-0 font-16">Wallboard</h2>
                            </div>
                            <div class="gredient-card-body p-20 p-md-30" style="background: #ff7b8836;">
                                <div class="row">
                                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6">
                                        <div class="box-with-centered-icon position-relative text-center bg-white p-20 my-30">
                                            <div class="icon d-inline-flex justify-content-center align-items-center bg-primary text-white"><i class="fas fa-user-tie"></i></div>
                                            <h3 class="my-0 font-16 pt-40 pb-20">Agents Logged In</h3>
                                            <div class="counting-number text-primary">0</div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6">
                                        <div class="box-with-centered-icon position-relative text-center bg-white p-20 my-30">
                                            <div class="icon d-inline-flex justify-content-center align-items-center bg-red text-white"><i class="fas fa-user-times"></i></div>
                                            <h3 class="my-0 font-16 pt-40 pb-20">Not Ready Agents</h3>
                                            <div class="counting-number text-red">0</div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6">
                                        <div class="box-with-centered-icon position-relative text-center bg-white p-20 my-30">
                                            <div class="icon d-inline-flex justify-content-center align-items-center bg-yellow text-white"><i class="fas fa-hourglass-half"></i></div>
                                            <h3 class="my-0 font-16 pt-40 pb-20">Avg. Handling Time</h3>
                                            <div class="counting-number text-yellow">0</div>
                                        </div>
                                    </div>
                                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6">
                                        <div class="box-with-centered-icon position-relative text-center bg-white p-20 my-30">
                                            <div class="icon d-inline-flex justify-content-center align-items-center bg-light-blue text-white"><i class="fas fa-headphones-alt"></i></div>
                                            <h3 class="my-0 font-16 pt-40 pb-20">Calls in Waiting</h3>
                                            <div class="counting-number text-light-blue">0</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- charts start -->
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="gredient-card-wrapper mb-30">
                                    <div class="gredient-card-header p-10" style="background:#f8f9fa;color:#323232;">
                                        <h2 class="card-title my-0 font-16">Area Chart</h2>
                                    </div>

                                    <div class="gredient-card-body p-20 p-md-30 with-bottom-shape" style="background: #fff;">
                                        <AreaChart style="height:250px;"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="gredient-card-wrapper mb-30">
                                    <div class="gredient-card-header p-10" style="background:#f8f9fa;color:#323232;">
                                        <h2 class="card-title my-0 font-16">Bar Chart</h2>
                                    </div>

                                    <div class="gredient-card-body p-20 p-md-30 with-bottom-shape" style="background: #fff;">
                                        <BarChart style="height:250px;"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- charts end -->

                        <!-- most recent posts -->
                        <div class="gredient-card-wrapper mb-40">
                            <div class="gredient-card-header p-10" style="background:#f8f9fa;color:#323232;">
                                <h2 class="card-title my-0 font-16">Recent Articles</h2>
                            </div>
                            <div class="gredient-card-body pt-20 pb-20 px-10" style="background: #fff;">
                                <div class="table-responsive">
                                    <table class="table table-bordered gsl-table">
                                        <thead>
                                        <tr>
                                            <th class="text-left">Title</th>
                                            <th class="text-center">Author</th>
                                            <th class="text-center">Category</th>
                                            <th class="text-center">Status</th>
                                            <th class="text-center">Tag</th>
                                            <th class="text-center">Publish Date</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="an_article in articleList" :key="an_article.id">
                                            <td class="text-left">
                                                <span v-if="(an_article.en_title).length<30"> {{ an_article.en_title }}</span>
                                                <span v-else> {{ (an_article.en_title).substring(0,30)+"...." }}</span>
                                            </td>
                                            <td class="text-center">{{ an_article.user ? (an_article.user.first_name +' '+ an_article.user.last_name) : '' }}</td>
                                            <td class="text-center">{{ an_article.category ? an_article.category.name : ''  }}</td>
                                            <td class="text-center">{{ an_article.status  }}</td>
                                            <td class="text-center">{{ an_article.tag  }}</td>
                                            <td class="text-center">{{ an_article.created_at  }}</td>


                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- most recent posts end -->

                    </div>
                    <!-- Content Area End -->
                </div>
            </div>
            <!-- Content Area End -->
        </div>
        <div class="action-modal-wraper" v-if="success_message">
            <span>{{ success_message }}</span>
        </div>

        <div class="action-modal-wraper-error" v-if="error_message">
            <span>{{ error_message }}</span>
        </div>
    </div>
</template>

<script>
import Header from "@/layouts/common/Header";
import Menu from "@/layouts/common/Menu";

import AreaChart from "../chart/AreaChart";
import BarChart from "../chart/BarChart.vue";
// import PieChart from "../chart/PieChart.vue";
// import LineChart from "../chart/LineChart.vue";
// import RadarChart from "../chart/RadarChart.vue";

import axios from "axios";

export default {
    name: "dashboard.vue",
    components: {
        Header,
        Menu,
        AreaChart,
        BarChart,
        // PieChart,
        // LineChart,
        // RadarChart
    },

    data() {
        return {
            isArticleList : false,
            category_parent_id : '',
            category_name   : '',
            success_message : '',
            error_message   : '',
            token           : '',
            categoryList    : '',
            articleList     : '',
            userInfo        : '',
            recentArticles   : '',
            filter : {
                isAdmin : 1,
                category_id : '',
                status : '',
                en_title : '',
                tag : '',
            },
            chartData: {
                Books: 24,
                Magazine: 30,
                Newspapers: 10
            }
        }
    },
    methods: {
        setTimeoutElements()
        {
            // setTimeout(() => this.isLoading = false, 3e3);
            setTimeout(() => this.success_message = "", 2e3);
            setTimeout(() => this.error_message = "", 2e3);
        },
        clearFilter()
        {
            this.isArticleList     = false;
            this.filter.category_id = "";
            this.filter.status   = "";
            this.filter.en_title = "";
            this.filter.tag      = "";
            this.success_message = "";
            this.error_message   = "";
        },

        getCategoryList()
        {
            let _that =this;

            axios.get('admin/categories',
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin : 1
                        },

                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        _that.categoryList = response.data.category_list.data;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

        getArticleList()
        {
            let _that =this;

            axios.get('admin/latest-article-list',
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin         : 1,
                        },

                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        _that.isArticleList = true;
                        console.log(response.data.article_list)
                        _that.articleList = response.data.article_list;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

    },
    created() {
        this.getArticleList();
        this.getCategoryList();
        //console.log(this.$route.params);
        //   this.success_message = this.$route.params.current_status;
        // this.setTimeoutElements();
    }
}
</script>

<style scoped>

</style>
