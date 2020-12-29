<template>

    <div class="main-wrapper d-flex">
        <!-- sidebar -->
        <Menu></Menu>
        <!-- sidebar end -->

        <div class="main-content-wrapper w-100 position-relative overflow-auto bg-white" >
            <!-- Topbar -->
            <Header></Header>

            <!-- Topbar End -->

            <!-- Content Area -->
            <div class="content-area">
                <div class="content-title-wrapper px-15 py-10">
                    <h2 class="content-title text-uppercase m-0">FAQ List</h2>
                </div>

                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center justify-content-between w-100">
                            <div>
                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="isAddCheck=true">
                                    <i class="fas fa-plus"></i>
                                    Add FAQ
                                </button>

                                <button class="btn common-gradient-btn ripple-btn search-btn right-side-common-form text-white mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="isSearch=true">
                                    <i class="fas fa-search"></i> <span class="ml-1">Search</span>
                                </button>
                            </div>

                            <div>
                                <button class="btn common-gradient-btn  new-agent-session  mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="clearFilter()">
                                    <i class="fa fa-refresh"></i>
                                    Refresh
                                </button>
                            </div>
                        </div>

                    </div>
                    <!-- list top area end -->


                    <!-- Content Area -->
                    <div class="data-content-area px-15 py-10">
                        <Loading v-if="isLoading===true"></Loading>
                        <!-- Table Data -->
                        <div class="table-responsive" v-if="isLoading===false">
                            <table class="table table-bordered gsl-table">
                                <thead>
                                <tr>
                                    <th class="text-center">Title</th>
                                    <th class="text-center">User</th>
                                    <th class="text-center">Category</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center">Tag</th>
                                    <th class="text-center">Publish Date</th>
                                    <th class="text-center" style="width:120px">Action</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr v-for="an_faq in faqList" :key="an_faq">

                                    <td>{{ an_faq.en_title  }}</td>
                                    <td class="text-center">{{ an_faq.user ? (an_faq.user.first_name +' '+ an_faq.user.last_name) : '' }}</td>
                                    <td class="text-center">{{ an_faq.category ? an_faq.category.name : ''  }}</td>
                                    <td class="text-center">{{ an_faq.status  }}</td>
                                    <td class="text-center">{{ an_faq.tag  }}</td>
                                    <td class="text-center">{{ an_faq.created_at  }}</td>

                                    <td class="text-center" style="width:120px">
                                        <router-link :to="{ name: 'faqDetails', params: { id: an_faq.id }}" class="btn btn-primary btn-xs m-1">
                                            <i class="fas fa-eye"></i>
                                        </router-link>
                                        <button class="btn btn-success ripple-btn right-side-common-form btn-xs m-1"  @click="faq_id=an_faq.id, isEditCheck=true"><i class="fas fa-pen"></i></button>

                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs m-1" @click="faq_id=an_faq.id, isDelete=true"><i class="fas fa-trash-restore-alt"></i></button>

                                    </td>

                                </tr>

                                </tbody>
                            </table>
                        </div>
                        <!-- Table Data End -->

                        <!-- Pagination -->

                        <div v-if="pagination.total > pagination.per_page" class="col-md-offset-4">
                            <nav aria-label="Page navigation">
                                <ul class="pagination mb-0">
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getFaqList(pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">First</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getFaqList(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                                    </li>
                                    <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                                        <a @click.prevent="getFaqList('admin/faqs?page='+n)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">{{ n }}</a>
                                    </li>

                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getFaqList(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getFaqList(pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Last</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                        <!-- Pagination End -->
                    </div>
                    <!-- Content Area End -->
                </div>
            </div>
            <!-- Content Area End -->
        </div>

        <!-- Common Right SideBar -->

        <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isSearch===true">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                    <img src="../../assets/img/cancel.svg" alt="cancel">
                </button>
            </div>

            <div class="right-sidebar-content-wrapper position-relative overflow-hidden">
                <div class="right-sidebar-content-area px-2">

                    <div class="form-wrapper" >
                        <h2 class="section-title text-uppercase mb-20">Search</h2>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-15">
                                    <label for="title">Title</label>
                                    <input class="form-control" type="text" v-model="filter.en_title"  id="title">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-15">
                                    <label for="closedReasonCode">Tag</label>
                                    <input class="form-control" type="text" v-model="filter.tag" id="closedReasonCode">
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="category_id">Select A Category</label>

                                    <select class="form-control" v-model="filter.category_id" id="category_id">
                                        <option value="">Select A Category</option>
                                        <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                                            {{a_category.name}}
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="status">Select A Status</label>

                                    <select class="form-control" v-model="filter.status" id="status">
                                        <option value="">Select A Status</option>
                                        <option value="draft">Draft</option>
                                        <option value="hide">Hide</option>
                                        <option value="private">Private</option>
                                        <option value="public">Public</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <button class="btn common-gradient-btn ripple-btn px-50" @click="getFaqList(), removingRightSideWrapper()"><i class="fas fa-search"></i> <span class="ml-1">Search</span></button>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="action-modal-wraper" v-if="success_message">
            <span>{{ success_message }}</span>
        </div>

        <div class="action-modal-wraper-error" v-if="error_message">
            <span>{{ error_message }}</span>
        </div>

        <FaqAdd v-if="isAddCheck" :isAddCheck= "isAddCheck" @faq-data="getFaqDataFromAdd"></FaqAdd>

        <FaqEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :faqId="faq_id" @faq-edit-data="getFaqDataFromEdit"></FaqEdit>

        <div class="right-sidebar-wrapper right-sidebar-small-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isDelete===true">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                    <img src="../../assets/img/cancel.svg" alt="cancel">
                </button>
            </div>

            <div class="right-sidebar-content-wrapper position-relative overflow-hidden">
                <div class="right-sidebar-content-area px-2">

                    <div class="form-wrapper">
                        <h2 class="section-title text-uppercase mb-20">Delete</h2>

                        <div class="row mt-50 mt-md-80">
                            <div class="col-md-12">
                                <figure class="mx-auto text-center">
                                    <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                </figure>
                                <p class="text-center"> Confirmation for Deleting FAQ</p>

                                <div class="form-group d-flex justify-content-center align-items-center">
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteFaq()"><i class="fas fa-trash"></i> Confirm</button>
                                    <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper()"><i class="fas fa-times-circle" ></i> Cancel</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>

        <!-- Common Right SideBar End -->
    </div>
</template>

<script>
import Header from "@/layouts/common/Header";
import Menu from "@/layouts/common/Menu";
import FaqAdd from "@/components/faq/faqAdd";
import FaqEdit from "@/components/faq/faqEdit";
import Loading from "@/components/loader/loading";
import axios from "axios";

export default {
    name: "faqList.vue",
    components: {
        Header,
        Menu,
        FaqAdd,
        FaqEdit,
        Loading
    },

    data() {
        return {
            isLoading       : false,
            isEditCheck     : false,
            isAddCheck      : false,
            isDelete        : false,
            isSearch        : false,

            success_message : '',
            error_message   : '',
            token           : '',
            categoryList    : '',

            faqList         : '',
            faq_id : '',

            filter : {
                isAdmin     : 1,
                category_id : '',
                status      : '',
                en_title    : '',
                tag         : '',
            },

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
    methods: {

        clearFilter() {

            this.filter.category_id = "";
            this.filter.status   = "";
            this.filter.en_title = "";
            this.filter.tag      = "";
            this.success_message = "";
            this.error_message   = "";
            this.getFaqList();

        },

        removingRightSideWrapper() {

            this.isAddCheck = false;
            this.isDelete   = false;
            this.isSearch   = false;
            document.body.classList.remove('open-side-slider');

        },

        clearAllChecker() {

            this.isAddCheck = false;
            this.isDelete   = false;
            this.isSearch   = false;

        },

        getFaqDataFromAdd (newData) {
            console.log(newData)
            this.isAddCheck = false;
            this.getFaqList();
        },

        getFaqDataFromEdit (newEditData) {
            console.log(newEditData)
            this.isEditCheck = false;
            this.getFaqList();
        },


        getCategoryList() {

            let _that =this;

            axios.get('admin/categories',
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin : 1,
                            without_pagination : 1
                        },

                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        console.log(response.data);
                        _that.categoryList = response.data.category_list;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

        getFaqList(pageUrl) {

            let _that =this;
            pageUrl = pageUrl == undefined ? 'admin/faqs' : pageUrl;

            axios.get(pageUrl,
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin     : 1,
                            category_id : this.filter.category_id,
                            status      : this.filter.status,
                            en_title    : this.filter.en_title,
                            tag         : this.filter.tag,
                        },

                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        _that.faqList    = response.data.faq_list.data;
                        _that.pagination = response.data.faq_list;
                        _that.isLoading  = false;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

        deleteFaq() {

            let _that = this;

            axios.delete('admin/faqs/delete',
                {
                    data:
                        {
                            id   : this.faq_id
                        },
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                }).then(function (response) {

                if (response.data.status_code === 200) {

                    _that.getFaqList();
                    _that.error_message   = '';
                    _that.clearAllChecker();

                    document.body.classList.remove('open-side-slider');
                    _that.success_message = "Successfully deleted the FAQ";
                    _that.setTimeoutElements();

                }
                else
                {
                    _that.success_message = "";
                    _that.error_message   = response.data.error;
                }

            }).catch(function (error) {
                console.log(error);
            });

        },

        setTimeoutElements() {
            //setTimeout(() => this.isLoading = false, 3000);
            setTimeout(() => this.success_message = "", 3000);
            setTimeout(() => this.error_message = "", 3000);
        },

    },
    created() {
        this.isLoading = true;
        this.getFaqList();
        this.getCategoryList();
    }
}
</script>

<style scoped>
.mhv-100 {
    min-height: 50vh;
}
</style>
