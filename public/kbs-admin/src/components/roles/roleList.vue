<template>
<!--    <div class="col-md-12 wrapper d-flex align-items-stretch">
        <Menu></Menu>

        &lt;!&ndash; Page Content  &ndash;&gt;
        <div class="col-md-9" style="margin-left:40px; ">

            <Header></Header>

            <div class="row">
                <div class="col-md-12">
                    <div v-if="success_message" class="alert alert-success" role="alert">
                        {{ success_message }}
                    </div>
                    <div v-if="error_message" class="alert alert-danger" role="alert">
                        {{ error_message }}
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h4 class="card-title ">
                                        Roles List
                                    </h4>
                                </div>

                                <div class="col-sm-9 text-right">
                                    <router-link :to="{ name: 'roleAdd'}" class="btn btn-primary">
                                        + Add New
                                    </router-link>
                                </div>

                            </div>

                            <div class="row mt-4">
                                <div class="col">
                                    <div class="table-responsive text-nowrap">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th>Role Type</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            <tr v-for="a_role in userRoles" :key="a_role">
                                                <td>{{ a_role.name  }}</td>

                                                <td>
                                                    <router-link :to="{ name: 'roleEdit', params: { id: a_role.id }}" class="btn btn-info">
                                                        Edit
                                                    </router-link>

                                                    <a v-if="a_role.name!= 'Super Admin'" href="#" class="btn btn-danger ml-1" data-toggle="modal"  :data-target="'#deleteModal_'+ a_role.id">Delete</a>

                                                    <div class="modal col-md-offset-2 fade" :id="'deleteModal_'+ a_role.id" role="dialog">
                                                        <div class="modal-dialog">

                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h4 class="modal-title">Confirmation for Deleting Category</h4>
                                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="col-md-12">
                                                                        <div class="col-md-10">
                                                                            <h6>Are You Sure to delete?</h6>
                                                                        </div>
                                                                    </div>

                                                                </div>

                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                                                    <button @click="deleteRole(a_role.id)" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </td>

                                            </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>&lt;!&ndash;col&ndash;&gt;
                            </div>&lt;!&ndash;row&ndash;&gt;
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>-->

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
                    <h2 class="content-title text-uppercase m-0">Role List</h2>
                </div>

                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center">
                            <div class="d-flex align-items-center">

                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="isAddCheck=true">
                                    <i class="fas fa-plus"></i>
                                    Add Role
                                </button>

                            </div>

                        </div>

                    </div>
                    <!-- list top area end -->


                    <!-- Content Area -->
                    <div class="data-content-area px-15 py-10">
                        <!-- Table Data -->
                        <div class="table-responsive">
                            <table class="table table-bordered gsl-table">
                                <thead>
                                <tr>
                                    <th class="text-center">Role Type</th>
                                    <th class="text-center">Created Date</th>
                                    <th class="text-center">Action</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr v-for="a_role in userRoles" :key="a_role">

                                    <td class="text-center">{{ a_role.name }}</td>
                                    <td class="text-center">{{ a_role.created_at }}</td>

                                    <td class="text-center">
                                        <button class="btn btn-success ripple-btn right-side-common-form btn-xs mx-1"  @click="role_id=a_role.id, isEditCheck=true"><i class="fas fa-pen"></i></button>
                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs mx-1" @click="role_id=a_role.id, isDelete=true"><i class="fas fa-trash-restore-alt"></i></button>
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
                                        <a @click.prevent="getRolesList(pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">First</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getRolesList(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                                    </li>
                                    <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                                        <a @click.prevent="getRolesList('admin/roles?page='+n)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">{{ n }}</a>
                                    </li>

                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getRolesList(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getRolesList(pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Last</a>
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

        <RoelAdd v-if="isAddCheck" :isAddCheck= "isAddCheck" @role-data="getRoleDataFromAdd"></RoelAdd>

        <RoleEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :roelId="role_id" @role-edit-data="getRoleDataFromEdit"></RoleEdit>

        <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isDelete===true">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
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
                                <p class="text-center"> Confirmation for Deleting Category</p>

                                <div class="form-group d-flex justify-content-center align-items-center">
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteRole"><i class="fas fa-trash"></i> Confirm</button>
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
    import RoelAdd from "@/components/roles/roleAdd";
    import RoleEdit from "@/components/roles/roleEdit";
    import axios from "axios";

    export default {
        name: "rolesList",
        components: {
            Header,
            Menu,
            RoelAdd,
            RoleEdit
        },
        data (){
            return {
                isEditCheck     : false,
                isAddCheck      : false,
                isDelete        : false,
                isSearch        : false,

                role_id   : '',
                userRoles : '',

                pagination :{
                    from           : '',
                    to             : '',
                    first_page_url : '',
                    last_page      : '',
                    last_page_url  : '',
                    next_page_url  :'',
                    prev_page_url  : '',
                    path           : '',
                    per_page       : 10,
                    total          : ''
                },
            }
        },
        methods: {

            removingRightSideWrapper()
            {
                this.isAddCheck = false;
                this.isDelete   = false;
                this.isSearch   = false;
                document.body.classList.remove('open-side-slider');
            },

            clearAllChecker()
            {
                this.isAddCheck = false;
                this.isDelete   = false;
                this.isSearch   = false;
            },

            getRoleDataFromAdd (newData) {
                console.log(newData)
                this.isAddCheck = false;
                this.getRolesList();

            },

            getRoleDataFromEdit (newEditData) {

                console.log(newEditData)
                this.isEditCheck = false;
                this.getRolesList();

            },

            getRolesList(pageUrl){

                let _that =this;
                pageUrl = pageUrl == undefined ? 'admin/roles' : pageUrl;

                axios.get(pageUrl,
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            console.log(response.data);
                            _that.success_message = "";
                            _that.userRoles       = response.data.role_list.data;
                            _that.pagination      = response.data.role_list;
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },

          deleteRole() {
            let _that = this;

            axios.delete('admin/roles/delete',
                {
                  data:
                      {
                        id      : this.role_id
                      },
                  headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                  },
                }).then(function (response) {

              if (response.data.status_code == 200)
              {
                _that.getRolesList();
                _that.error_message   = '';
                _that.success_message = "Role Deleted Successfully";
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
        },
        created() {
            this.getRolesList();
        }
    }
</script>

<style scoped>

</style>
