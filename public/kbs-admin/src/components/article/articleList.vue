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
                    <h2 class="content-title text-uppercase m-0">Article List</h2>
                </div>
                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center justify-content-between w-100">
                            <div>
                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="isAddCheck=true" v-if="checkPermission('article-create')">
                                    <i class="fas fa-plus"></i>
                                    Add Article
                                </button>
                                <button class="btn common-gradient-btn ripple-btn search-btn right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0 text-white" @click="isSearchCheck=true">
                                    <i class="fas fa-search"></i> <span class="ml-1">Search</span>
                                </button>
                            </div>
                            <div class="reload-download-expand-area">
                                <ul class="list-inline d-inline-flex align-items-center justify-content-end mb-0 w-100">
                                    <li>
                                        <button class="reload-btn" @click="clearFilter()">
                                            <div class="d-flex jsutify-content-center align-items-center">
                                                <i class="fas fa-sync"></i> <span class="hide-on-responsive">Reload</span>
                                            </div>
                                        </button>
                                    </li>
                                    <li>
                                        <a v-if="isExportCheck"
                                           :href=downloadUrl class="download-btn" title="Download CSV">
                                            <i class="fas fa-download"></i> <span class="hide-on-responsive">Download CSV</span>
                                        </a>
                                    </li>

                                    <li><button class="screen-expand-btn"><i class="fas fa-expand-arrows-alt"></i> <span class="hide-on-responsive">Full Screen</span></button></li>
                                </ul>
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
                                    <th class="text-center">ID</th>
                                    <th class="text-left">Title</th>
                                    <th class="text-center">Author</th>
                                    <th class="text-center">Category</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center">Tag</th>
                                    <th class="text-center">Publish Date</th>
                                    <th class="text-center" style="width:120px">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="an_article in articleList" :key="an_article.id">
                                    <td class="text-center">{{ an_article.id }}</td>
                                    <td class="text-left">
                                        <span v-if="(an_article.en_title).length<30"> {{ an_article.en_title }}</span>
                                        <span v-else> {{ (an_article.en_title).substring(0,30)+"...." }}</span>
                                    </td>
                                    <td class="text-center">{{ an_article.user ? (an_article.user.first_name +' '+ an_article.user.last_name) : '' }}</td>
                                    <td class="text-center">{{ an_article.category ? an_article.category.name : ''  }}</td>
                                    <td class="text-center">{{ an_article.status  }}</td>
                                    <td class="text-center">{{ an_article.tag  }}</td>
                                    <td class="text-center">{{ an_article.created_at  }}</td>
                                    <td class="text-center" style="width:120px">
                                        <router-link :to="{ name: 'articleDetails', params: { id: an_article.slug }}" class="btn btn-primary btn-xs m-1">
                                            <i class="fas fa-eye"></i>
                                        </router-link>
                                        <button class="btn btn-success ripple-btn right-side-common-form btn-xs m-1"  @click="article_id=an_article.id, isEditCheck=true" v-if="checkPermission('article-edit')"><i class="fas fa-pen"></i></button>

                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs m-1" @click="article_id=an_article.id, isDeleteCheck=true" v-if="checkPermission('article-delete')"><i class="fas fa-trash-restore-alt"></i></button>
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
                                        <a @click.prevent="getArticleList(pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">First</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getArticleList(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                                    </li>
                                    <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                                        <a @click.prevent="getArticleList('admin/articles?page='+n)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">{{ n }}</a>
                                    </li>

                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getArticleList(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getArticleList(pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Last</a>
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
        <!--alert message-->
        <div class="action-modal-wraper" v-if="success_message">
            <span>{{ success_message }}</span>
        </div>
        <div class="action-modal-wraper-error" v-if="error_message">
            <span>{{ error_message }}</span>
        </div>
        <!--alert message-->
        <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                    <img src="../../assets/img/cancel.svg" alt="cancel">
                </button>
            </div>
            <!--add-->
            <ArticleAdd v-if="isAddCheck" :isAddCheck= "isAddCheck" @article-slide-close="getAddDataFromChild"></ArticleAdd>
            <!--edit-->
            <ArticleEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :articleId="article_id" @article-edit-close="getEditDataFromChild"></ArticleEdit>
            <!--delete-->
            <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isDeleteCheck===true">
                <div class="right-sidebar-content-area px-2">
                    <div class="form-wrapper">
                        <h2 class="section-title text-uppercase mb-20">Delete Article</h2>
                        <div class="row mt-50 mt-md-80">
                            <div class="col-md-12">
                                <figure class="mx-auto text-center">
                                    <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                </figure>
                                <p class="text-center"> Confirmation for Deleting Article</p>

                                <div class="form-group d-flex justify-content-center align-items-center">
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteArticle()"><i class="fas fa-trash"></i> Confirm</button>
                                    <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper()"><i class="fas fa-times-circle" ></i> Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--search-->
            <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isSearchCheck===true">
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
                            <button class="btn common-gradient-btn ripple-btn px-50" @click="getArticleList(), removingRightSideWrapper()"><i class="fas fa-search"></i> <span class="ml-1">Search</span></button>
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
import ArticleAdd from "@/components/article/articleAdd";
import ArticleEdit from "@/components/article/articleEdit";
import Loading from "@/components/loader/loading";
import axios from "axios";
import $ from "jquery";


export default {
    name: "articleList.vue",

    components: {
        Header,
        Menu,
        ArticleEdit,
        ArticleAdd,
        Loading
    },
    data() {
        return {
            isExportCheck       : false,
            isLoading           : false,
            isEditCheck         : false,
            isAddCheck          : false,
            isDeleteCheck       : false,
            isSearchCheck       : false,
            downloadUrl         : 'articles/export/',
            user_permissions : '',
            mappedPermission : '',

            article_id          :'',
            filter      : {
                isAdmin         : 1,
                category_id     : '',
                status          : '',
                en_title        : '',
                tag             : '',
            },
            pagination  :{
                from            : '',
                to              : '',
                first_page_url  : '',
                last_page       : '',
                last_page_url   : '',
                next_page_url   :'',
                prev_page_url   : '',
                path            : '',
                per_page        : 10,
                total           : ''
            },
        }
    },
    methods: {
        // acl permission
        checkPermission(permissionForCheck)
        {
            if((this.mappedPermission).includes(permissionForCheck) === true) {
                return true;
            } else {
                return false;
            }
        },
        // clear serach
        clearFilter()
        {
            this.filter.category_id = "";
            this.filter.status   = "";
            this.filter.en_title = "";
            this.filter.tag      = "";
            this.success_message = "";
            this.error_message   = "";
            this.getArticleList();

        },
        // slider close
        clearAllChecker()
        {
            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;
        },
        // after crud close
        removingRightSideWrapper()
        {
            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;

            document.body.classList.remove('open-side-slider');
            $('.right-sidebar-wrapper').toggleClass('right-side-common-form-show');
        },
        //from child
        getAddDataFromChild (status)
        {
            this.getArticleList();
            this.success_message = status;
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },
        getEditDataFromChild (status)
        {
            this.getArticleList();
            this.success_message = status;
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },
        //category list
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
                            isAdmin     : 1,
                            without_pagination : 1
                        },
                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        //console.log(response.data);
                        _that.categoryList = response.data.category_list;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },
        getArticleList(pageUrl)
        {
            let _that = this;

            pageUrl = pageUrl == undefined ? 'admin/articles' : pageUrl;

            axios.get(pageUrl,
                {
                    headers: {
                        'Authorization'     : 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin         : 1,
                            category_id     : this.filter.category_id,
                            status          : this.filter.status,
                            en_title        : this.filter.en_title,
                            tag             : this.filter.tag,
                        },
                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        _that.articleList       = response.data.article_list.data;
                        _that.pagination        = response.data.article_list;
                        _that.isLoading         = false;
                        _that.isExportCheck     = true;
                        _that.setTimeoutElements();

                    }
                    else{
                        _that.success_message   = "";
                        _that.error_message     = response.data.error;
                    }
                })
        },
        setTimeoutElements()
        {
            // setTimeout(() => this.isLoading = false, 3e3);
            setTimeout(() => this.success_message = "", 2e3);
            setTimeout(() => this.error_message = "", 2e3);
        },
        deleteArticle()
        {
            let _that = this;

            axios.delete('admin/articles/delete',
                {
                    data    : {
                            id              : _that.article_id
                    },
                    headers : {
                        'Authorization'     : 'Bearer ' + localStorage.getItem('authToken')
                    },
                }).then(function (response) {
                if (response.data.status_code == 200)
                {
                    _that.getArticleList();
                    _that.removingRightSideWrapper();
                    _that.error_message         = '';
                    _that.success_message       = "Article Deleted Successfully";
                    _that.setTimeoutElements();

                }
                else
                {
                    _that.success_message       = "";
                    _that.error_message         = response.data.error;
                }

            }).catch(function (error) {
                console.log(error);
            });
        },
    },
    created() {
        this.isLoading = true;
        this.getArticleList();
        this.getCategoryList();
        this.user_permissions = JSON.parse(localStorage.getItem("userPermissions"));
        this.mappedPermission = (this.user_permissions ).map(x => x.slug);
        this.downloadUrl = axios.defaults.baseURL+this.downloadUrl;
    }
}
</script>

<style scoped>
.mhv-100 {
    min-height: 50vh;
}
</style>
