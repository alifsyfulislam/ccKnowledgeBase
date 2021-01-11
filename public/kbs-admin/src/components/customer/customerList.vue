<template>
    <div class="main-wrapper d-flex">
        <Menu></Menu>
        <div class="main-content-wrapper w-100 position-relative overflow-auto bg-white" >
            <!-- Topbar -->
            <Header></Header>

            <!-- Topbar End -->

            <!-- Content Area -->
            <div class="content-area">
                <div class="content-title-wrapper px-15 py-10">
                    <h2 class="content-title text-uppercase m-0">User List</h2>
                </div>

                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center justify-content-between"  >
                            <div v-if="checkPermission('user-create')">
                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0"
                                        @click="isAddCheck=true">
                                    <i class="fas fa-plus"></i>
                                    Add User
                                </button>

                                <button class="btn common-gradient-btn ripple-btn search-btn right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0 text-white" @click="isSearchCheck=true">
                                    <i class="fas fa-search"></i> <span class="ml-1">Search</span>
                                </button>
                            </div>
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


                                <li><button class="screen-expand-btn user-fullscreen"><i class="fas fa-expand-arrows-alt"></i> <span class="hide-on-responsive">Full Screen</span></button></li>
                            </ul>
                        </div>
                    </div>

                    <!-- list top area end -->

                    <!-- Content Area -->
                    <div class="data-content-area px-15 py-10">
                        <Loading v-if="isLoading===true"></Loading>
                        <!-- Table Data -->
                        <div class="table-responsive" v-if="isLoading===false">
                            <table class="table table-bordered gsl-table" v-if="userList">
                                <thead>
                                <tr>
                                    <th class="text-center">ID</th>
                                    <th class="text-center">Username</th>
                                    <th class="text-center">Roles</th>
                                    <th class="text-center">First Name</th>
                                    <th class="text-center">Last Name</th>
                                    <th class="text-center">Email</th>
                                    <th class="text-center">Enroll Date</th>
                                    <th class="text-center" style="width:120px;">Action</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr v-for="(a_user) in userList" :key="a_user.id">
                                    <td class="text-center">{{ a_user.id }}</td>
                                    <td class="text-center">{{ a_user.username }}</td>
                                    <td class="text-center">{{ ((a_user.roles).length > 0) ? a_user.roles[0].name : '' }}</td>
                                    <td class="text-center">{{ a_user.first_name }}</td>
                                    <td class="text-center">{{ a_user.last_name }}</td>
                                    <td class="text-center">{{ a_user.email }}</td>
                                    <td class="text-center">{{ a_user.created_at }}</td>

                                    <td class="text-center" style="min-width: 120px">

                                        <button  class="btn btn-success ripple-btn right-side-common-form btn-xs m-1"  @click="customer_id = a_user.id, isEditCheck=true" v-if="checkPermission('user-edit') && (a_user.roles).length > 0 && a_user.roles[0].name!='Super Admin'"><i class="fas fa-pen"></i></button>
                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs m-1" @click="customer_id = a_user.id, isDeleteCheck=true"  v-if="checkPermission('user-delete') && (a_user.roles).length > 0 && a_user.roles[0].name!='Super Admin'" ><i class="fas fa-trash-restore-alt"></i></button>
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                        <!-- Table Data End -->
                        <!-- pagination-->
                        <div v-if="pagination.total > pagination.per_page" class="col-md-offset-4">
                            <nav aria-label="Page navigation">
                                <ul class="pagination mb-0">
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getUsersList(pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">First</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getUsersList(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                                    </li>
                                    <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                                        <a @click.prevent="getUsersList('admin/users?page='+n)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">{{ n }}</a>
                                    </li>

                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getUsersList(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getUsersList(pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Last</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <!-- Content Area End -->
                </div>
            </div>
<!--            message alert as per action-->
            <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70">
                <div class="close-bar d-flex align-items-center justify-content-end">
                    <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                        <img src="../../assets/img/cancel.svg" alt="cancel">
                    </button>
                </div>
                <!-- add-->
                <CustomerAdd v-if="isAddCheck" :isAddCheck= "isAddCheck" @user-slide-close="getAddDataFromChild"></CustomerAdd>
<!--                edit-->
                <CustomerEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :customerId="customer_id" @user-slide-close="getEditDataFromChild"></CustomerEdit>
<!--                delete-->
                <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isDeleteCheck">
                    <div class="right-sidebar-content-area px-2">

                        <div class="form-wrapper">
                            <h2 class="section-title text-uppercase mb-20">User Delete</h2>

                            <div class="row mt-50 mt-md-80">
                                <div class="col-md-12">
                                    <figure class="mx-auto text-center">
                                        <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                    </figure>
                                    <p class="text-center"> Confirmation for Deleting User</p>

                                    <div class="form-group d-flex justify-content-center align-items-center">
                                        <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteCustomer()"><i class="fas fa-trash"></i> Confirm</button>
                                        <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper()"><i class="fas fa-times-circle" ></i> Cancel</button>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
<!--                search-->
                <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isSearchCheck">
                    <div class="right-sidebar-content-area px-2">

                        <div class="form-wrapper" >
                            <h2 class="section-title text-uppercase mb-20">Search from User</h2>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group mb-15">
                                        <label for="title">Username</label>
                                        <input class="form-control" type="text" placeholder="Enter username here!" v-model="filter.username"  id="title">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group mb-15">
                                        <label for="closedReasonCode">Email</label>
                                        <input class="form-control" type="email" placeholder="Enter email here!" v-model="filter.email" id="closedReasonCode">
                                    </div>
                                </div>

                            </div>

                            <div class="form-group text-right">
                                <button class="btn common-gradient-btn ripple-btn px-50" @click="getUsersList(), removingRightSideWrapper()"><i class="fas fa-search"></i> <span class="ml-1">Search</span></button>
                            </div>
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
    </div>
</template>

<script>
import Header from "@/layouts/common/Header";
import Menu from "@/layouts/common/Menu";
import CustomerAdd from "@/components/customer/customerAdd";
import CustomerEdit from "@/components/customer/customerEdit";
import Loading from "@/components/loader/loading";
import axios from "axios";
import $ from "jquery";

$(document).on('click','.screen-expand-btn .user-fullscreen',()=>{
    $('.content-wrapper').toggleClass('expandable-content-area');
});

export default {
    name: "customerList.vue",
    components: {
        Header,
        Menu,
        CustomerAdd,
        CustomerEdit,
        Loading
    },

    data() {
        return {
            isLoading       : false,
            isAddCheck      : false,
            isEditCheck     : false,
            isDeleteCheck   : false,
            isSearchCheck   : false,
            isExportCheck   : false,

            success_message : '',
            error_message   : '',
            token           : '',
            categoryList    : '',
            articleList     : '',
            userList        : '',
            userRole        : '',
            customer_id     : '',
            userAllRoles    : '',
            downloadUrl     : '/users/export/',

            user_permissions : '',
            mappedPermission : '',

            filter : {
                isAdmin     : 1,
                username    : '',
                email       : '',
                role        : ''
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
        setTimeoutElements(){

            // setTimeout(() => this.isLoading = false, 3e3);
            setTimeout(() => this.success_message = "", 2e3);
            setTimeout(() => this.error_message = "", 2e3);
        },

        removingRightSideWrapper(){

            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;
            this.isSearchCheck      = false;

            document.body.classList.remove('open-side-slider');
            $('.right-sidebar-wrapper').toggleClass('right-side-common-form-show');
        },

        clearAllChecker()
        {
            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;
            this.isSearchCheck      = false;
        },

        getAddDataFromChild (status)
        {
            this.success_message = status;
            this.getUsersList();
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },

        getEditDataFromChild (status) {
            this.success_message = status;
            this.getUsersList();
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },

        clearFilter()
        {
            this.filter.username    = "";
            this.filter.email       = "";
            this.filter.role        = "";
            this.success_message    = "";
            this.error_message      = "";
            this.getUsersList();
        },

        getUsersList(pageUrl)
        {
            let _that =this;

            pageUrl = pageUrl == undefined ? 'admin/users' : pageUrl;

            axios.get(pageUrl,
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin         : 1,
                            username        : this.filter.username,
                            email           : this.filter.email,
                            // role : this.filter.role
                        },
                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                       // console.log(response.data.user_list.data);
                        _that.pagination        = response.data.user_list;
                        _that.userList          = response.data.user_list.data;
                        _that.isLoading         = false;
                        _that.isExportCheck     = true;
                        _that.setTimeoutElements();
                    }
                    else{
                        _that.error_message     = response.data.error;
                    }
                })
        },

        deleteCustomer()
        {
            let _that = this;

            axios.delete('admin/users/delete',
                {
                    data:
                        {
                            id      : _that.customer_id
                        },
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                }).then(function (response) {

                if (response.data.status_code == 200)
                {
                    _that.getUsersList();
                    _that.removingRightSideWrapper();
                    _that.error_message         = '';
                    _that.success_message       = "User Deleted Successfully";
                    _that.setTimeoutElements();
                }else{
                    _that.success_message = "";
                    _that.error_message   = response.data.error;
                }

            }).catch(function (error) {
                console.log(error);
            });

        },

        getUserRoles()
        {
            let _that =this;

            axios.get('admin/roles',
                {
                    headers: {
                        'Authorization'     : 'Bearer '+localStorage.getItem('authToken')
                    },
                    params : {
                        isAdmin             : 1,
                        without_pagination  : 1
                    },
                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        _that.userAllRoles          = response.data.role_list;
                        // console.log(_that.userRoles);
                    }
                    else{
                        _that.error_message         = response.data.error;
                    }
                })
        },

        deleteUser(userId){

            let _that = this;

            axios.delete('admin/users/delete',
                {
                    data:
                        {
                            id          : userId
                        },
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem('authToken')
                    },
                }).then(function (response) {

                if (response.data.status_code == 200) {
                    _that.getUsersList();
                    _that.error_message         = '';
                    _that.success_message       = "User Deleted Successfully";
                    _that.removingRightSideWrapper();
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

        checkPermission(permissionForCheck){

            if((this.mappedPermission).includes(permissionForCheck) === true) {
                return true;
            } else {
                return false;
            }
        },

    },

    created() {
        this.isLoading  = true;
        this.user_permissions = JSON.parse(localStorage.getItem("userPermissions"));
        this.mappedPermission = (this.user_permissions ).map(x => x.slug);
        this.getUsersList();
        this.getUserRoles();
        this.downloadUrl = axios.defaults.baseURL+this.downloadUrl;


        //console.log(this.downloadUrl)
    }
}
</script>

<style scoped>
.mhv-100 {
    min-height: 50vh;
}
</style>
