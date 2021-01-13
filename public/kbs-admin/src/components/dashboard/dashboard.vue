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
                        <!--                        <div class="gredient-card-wrapper mb-40">-->
                        <!--                            <div class="gredient-card-header p-10" style="background:#f8f9fa;color:#323232;">-->
                        <!--                                <h2 class="card-title my-0 font-16">Daily Snap Shot</h2>-->
                        <!--                            </div>-->
                        <!--                            <div class="gredient-card-body p-20 p-md-30" style="background: #20c94c36;">-->
                        <!--                                <div class="row">-->
                        <!--                                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6">-->
                        <!--                                        <div class="box-with-left-icon position-relative bg-white p-20 my-30">-->
                        <!--                                            <div class="it-wrapper d-flex align-items-center pb-20">-->
                        <!--                                                <div class="icon d-inline-flex justify-content-center align-items-center bg-green text-white mr-10"><i class="fas fa-tachometer-alt"></i></div>-->
                        <!--                                                <h3 class="my-0 font-16">Service Level</h3>-->
                        <!--                                            </div>-->
                        <!--                                            <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit.</p>-->
                        <!--                                            <div class="progress bg-green">-->
                        <!--                                                <div class="progress-bar bg-green m-0" role="progressbar" style="width: 90%;" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"><span class="progress-text">90%</span></div>-->
                        <!--                                            </div>-->
                        <!--                                        </div>-->
                        <!--                                    </div>-->
                        <!--                                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6">-->
                        <!--                                        <div class="box-with-left-icon position-relative bg-white p-20 my-30">-->
                        <!--                                            <div class="it-wrapper d-flex align-items-center pb-20">-->
                        <!--                                                <div class="icon d-inline-flex justify-content-center align-items-center bg-red text-white mr-10"><i class="fas fa-tachometer-alt"></i></div>-->
                        <!--                                                <h3 class="my-0 font-16">Answer Level</h3>-->
                        <!--                                            </div>-->
                        <!--                                            <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit.</p>-->
                        <!--                                            <div class="progress bg-red">-->
                        <!--                                                <div class="progress-bar bg-red m-0" role="progressbar" style="width: 70%;" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100"><span class="progress-text">70%</span></div>-->
                        <!--                                            </div>-->
                        <!--                                        </div>-->
                        <!--                                    </div>-->
                        <!--                                    <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6">-->
                        <!--                                        <div class="box-with-left-icon position-relative bg-white p-20 my-30">-->
                        <!--                                            <div class="it-wrapper d-flex align-items-center pb-20">-->
                        <!--                                                <div class="icon d-inline-flex justify-content-center align-items-center bg-yellow text-white mr-10"><i class="fas fa-tachometer-alt"></i></div>-->
                        <!--                                                <h3 class="my-0 font-16">AHT</h3>-->
                        <!--                                            </div>-->
                        <!--                                            <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit.</p>-->
                        <!--                                            <div class="progress bg-yellow">-->
                        <!--                                                <div class="progress-bar bg-yellow m-0" role="progressbar" style="width: 92%;" aria-valuenow="92" aria-valuemin="0" aria-valuemax="92"><span class="progress-text">92%</span></div>-->
                        <!--                                            </div>-->
                        <!--                                        </div>-->
                        <!--                                    </div>-->
                        <!--                                </div>-->
                        <!--                            </div>-->
                        <!--                        </div>-->
                        <div class="gredient-card-wrapper mb-40">
                            <div class="gredient-card-header p-10" style="background:#f8f9fa;color:#323232;">
                                <h2 class="card-title my-0 font-16">Wallboard 777</h2>
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


                        <div class="gredient-card-wrapper mb-30">
                            <div class="gredient-card-header p-10" style="background:#f8f9fa;color:#323232;">
                                <h2 class="card-title my-0 font-16">Area Chart</h2>
                            </div>

                            <div class="gredient-card-body p-20 p-md-30 with-bottom-shape" style="background: #ff7b8836;">
                                <div class="row">
                                    <div class="col-md-6">
                                        <AreaChart/>
                                    </div>
                                    <div class="col-md-6">
                                        <PieChart/>
                                    </div>
                                    <div class="col-md-6">
                                        <BarChart/>
                                    </div>
                                    <div class="col-md-6">
                                        <LineChart/>
                                    </div>
                                    <div class="col-md-6">
                                        <RadarChart/>
                                    </div>
                                </div>
                            </div>
                        </div>
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
import PieChart from "../chart/PieChart.vue";
import BarChart from "../chart/BarChart.vue";
import LineChart from "../chart/LineChart.vue";
import RadarChart from "../chart/RadarChart.vue";

import axios from "axios";

export default {
    name: "dashboard.vue",
    components: {
        BarChart,
        PieChart,
        Header,
        Menu,
        AreaChart,
        LineChart,
        RadarChart
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
                        console.log(response.data);
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

            axios.get('admin/articles',
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin : 1,
                            category_id : this.filter.category_id,
                            status : this.filter.status,
                            en_title : this.filter.en_title,
                            tag : this.filter.tag,
                        },

                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        console.log(response.data);
                        _that.isArticleList = true;
                        _that.articleList = response.data.article_list.data;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

    },
    created() {
        //this.getArticleList();
        this.getCategoryList();
        //console.log(this.$route.params);
        //   this.success_message = this.$route.params.current_status;
        // this.setTimeoutElements();
    }
}
</script>

<style scoped>

</style>
