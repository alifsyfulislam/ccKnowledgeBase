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
            <div class="content-area" >
                <div class="content-title-wrapper px-15 py-10">
                    <h2 class="content-title text-uppercase m-0">Category List</h2>
                </div>
                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center">
                            <div>
                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0"
                                        @click="isAddCheck=true" v-if="checkPermission('category-create')">
                                    <i class="fas fa-plus"></i>
                                    Add Category
                                </button>
                            </div>
                        </div>
                        <div class="reload-download-expand-area">
                            <ul class="list-inline d-inline-flex align-items-center justify-content-end mb-0 w-100">
                                <li>
                                    <button class="reload-btn">
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
                    <!-- list top area end -->
                    <!-- Content Area -->
                    <div class="data-content-area px-15 py-10">
                        <Loading v-if="isLoading===true"></Loading>
                        <!-- Table Data -->
                        <div class="table-responsive" v-if="isLoading===false">
                          <data-table :posts="categoryList"></data-table>
                            <table class="table table-bordered gsl-table">
                                <thead>
                                <tr>
                                    <th class="text-center">ID</th>
                                    <th class="text-left">Name</th>
                                    <th class="text-left">Parent Name</th>
                                    <th class="text-center">Created Date</th>
                                    <th class="text-center" style="width:120px;">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="(a_category) in categoryList" :key="a_category.id">
                                    <td class="text-center">{{ a_category.id }}</td>
                                    <td class="text-left">{{ a_category.name }}</td>
                                    <td class="text-left">{{ a_category.parent_recursive ? a_category.parent_recursive.name : ''   }}</td>
                                    <td class="text-center">{{ a_category.created_at }}</td>
                                    <td class="text-center">
                                        <button class="btn btn-success ripple-btn right-side-common-form btn-xs mx-1"
                                                @click="category_id=a_category.id, isEditCheck=true" v-if="checkPermission('category-edit')">
                                            <i class="fas fa-pen"></i>
                                        </button>
                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs mx-1"
                                                 @click="category_id=a_category.id, isDeleteCheck=true" v-if="checkPermission('category-delete')">
                                            <i class="fas fa-trash-restore-alt"></i>
                                        </button>
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
                                        <a @click.prevent="getCategoryList(pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-pill"><i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                    </li>
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getCategoryList(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-pill"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
                                    </li>
                                    <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                                        <a @click.prevent="getCategoryList('categories?page='+n)" href="#" class="px-3 bg-primary text-white py-2 rounded-pill">{{ n }}</a>
                                    </li>

                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getCategoryList(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-pill"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
                                    </li>
                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getCategoryList(pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-pill"><i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
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
        <div class="action-modal-wraper" v-if="success_message">
            <span>{{ success_message }}</span>
        </div>

        <div class="action-modal-wraper-error" v-if="error_message">
            <span>{{ error_message }}</span>
        </div>
        <!--        work-->
        <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                    <img src="../../assets/img/cancel.svg" alt="cancel">
                </button>
            </div>
            <!--            add data-->
            <CategoryAdd v-if="isAddCheck" :isAddCheck="isAddCheck" @category-slide-close="getAddDataFromChild"></CategoryAdd>
            <!--            edit data-->
            <CategoryEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :categoryId="category_id" @category-slide-close="getEditDataFromChild"></CategoryEdit>
            <!--            delete data -->
            <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isDeleteCheck">
                <div class="right-sidebar-content-area px-2">

                    <div class="form-wrapper">
                        <h2 class="section-title text-uppercase mb-20">Delete</h2>

                        <div class="text-danger" v-if="error_message">
                            <h5>{{ error_message }}</h5>
                        </div>

                        <div class="row mt-50 mt-md-80">
                            <div class="col-md-12">
                                <figure class="mx-auto text-center">
                                    <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                </figure>
                                <p class="text-center"> Confirmation for Deleting Category</p>
                                <div class="form-group d-flex justify-content-center align-items-center">
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteCategory()"><i class="fas fa-trash"></i> Confirm</button>
                                    <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper(), isDeleteCheck=false"><i class="fas fa-times-circle" ></i> Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import Menu from '@/layouts/common/Menu'
import Header from '@/layouts/common/Header'
import CategoryAdd from "@/components/category/categoryAdd";
import CategoryEdit from "@/components/category/categoryEdit";
import Loading from "@/components/loader/loading";
<<<<<<< HEAD
import dataTable from "../datatable/dataTable";
=======
// import dataTable from "../datatable/dataTable";
>>>>>>> 736ae50711e9a188480c561bfb62d2cf617e40fd
import $ from "jquery";

export default {
    name: "categoryList.vue",
    components: {
        Header,
        Menu,
        CategoryAdd,
        CategoryEdit,
        Loading,
<<<<<<< HEAD
        dataTable
=======
        // dataTable
>>>>>>> 736ae50711e9a188480c561bfb62d2cf617e40fd
    },

    data() {
        return {
            isLoading           : false,
            isEditCheck         : false,
            isAddCheck          : false,
            isDeleteCheck       : false,
            isExportCheck        :false,
            isSearch            : false,
            category_id         : '',
            category_parent_id  : '',
            category_name       : '',
            success_message     : '',
            error_message       : '',
            token               : '',
            categoryList        : '',
            userInfo            : '',
            downloadUrl         : 'categories/export/',
            user_permissions    : '',
            mappedPermission    : '',
            filter      : {
                isAdmin         : 1,
                name            : ''
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
        removingRightSideWrapper()
        {
            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;

            document.body.classList.remove('open-side-slider');
            $('.right-sidebar-wrapper').toggleClass('right-side-common-form-show');
        },

        clearAllChecker()
        {
            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;
        },

        getAddDataFromChild (status){

            this.success_message = status;
            this.getCategoryList();
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },

        getEditDataFromChild (status)
        {
            this.success_message = status;
            this.getCategoryList();
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },

        getCategoryList(pageUrl)
        {
            let _that = this;
            pageUrl = pageUrl == undefined ? 'categories' : pageUrl;

            axios.get(pageUrl,
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin : 1
                        },
                }).then(function (response)
                {
                    if(response.data.status_code === 200)
                    {
                        console.log(response.data);
                        _that.categoryList      = response.data.category_list.data;
                        _that.pagination        = response.data.category_list;
                        _that.isLoading         = false;
                        _that.isExportCheck     = true;
                        // console.log(_that.pagination.total);
                    }
                    else
                    {
                        _that.success_message   = "";
                        _that.error_message     = response.data.error;
                    }
                });

        },

        categoryUpdate(categoryId)
        {
            let _that = this;

            axios.put('categories/update', {
                    id              : categoryId,
                    name            : this.category_name,
                    parent_id       : this.category_parent_id,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                if (response.data.status_code == 200) {
                    _that.getCategoryList();
                    _that.selectedCategory      = '';
                    _that.error_message         = '';
                    _that.success_message       = response.data.messages;

                }
                else {
                    _that.success_message       = "";
                    _that.error_message         = response.data.error;
                }
            }).catch(function (error) {
                console.log(error);
            });

        },

        deleteCategory()
        {
            let _that = this;
            axios.delete('categories/delete',
                {
                    data:
                        {
                            id      : this.category_id
                        },
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                }).then(function (response) {

                if (response.data.status_code == 200) {
                    _that.getCategoryList();
                    _that.removingRightSideWrapper();
                    _that.error_message         = '';
                    _that.success_message       = "Category Deleted Successfully";
                    _that.setTimeoutElements();

                } else {
                    _that.success_message       = "";
                    _that.error_message         = response.data.error;
                    _that.removingRightSideWrapper();
                    _that.setTimeoutElements();

                }
            }).catch(function (error) {
                console.log(error);
            });
        },

        //alert message remove

        setTimeoutElements()
        {
            setTimeout(() => this.success_message = "", 3e3);
            setTimeout(() => this.error_message = "", 3e3);
        },

        checkPermission(permissionForCheck)
        {
            if((this.mappedPermission).includes(permissionForCheck) === true) {
                return true;
            } else {
                return false;
            }
        },

    },
    created()
    {
        this.isLoading = true;
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
