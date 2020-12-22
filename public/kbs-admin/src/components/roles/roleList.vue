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
                                    <th class="text-center" style="width: 120px">Action</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr v-for="a_role in userRoles" :key="a_role">

                                    <td class="text-center">{{ a_role.name }}</td>
                                    <td class="text-center">{{ a_role.created_at }}</td>

                                    <td class="text-center">
                                        <button v-if="a_role.name!='Super Admin' " class="btn btn-success ripple-btn right-side-common-form btn-xs mx-1"  @click="role_id=a_role.id, isEditCheck=true"><i class="fas fa-pen"></i></button>
                                        <button  v-if="a_role.name!='Super Admin' " class="btn btn-danger ripple-btn right-side-common-form btn-xs mx-1" @click="role_id=a_role.id, isDelete=true"><i class="fas fa-trash-restore-alt"></i></button>
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

        <RoleEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :roleId="role_id" @role-edit-data="getRoleDataFromEdit"></RoleEdit>

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
                                <p class="text-center"> Confirmation for Deleting Role</p>

                                <div class="form-group d-flex justify-content-center align-items-center">
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteRole()"><i class="fas fa-trash"></i> Confirm</button>
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

                success_message : '',
                error_message   : '',

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

              if (response.data.status_code == 200){

                  _that.getRolesList();
                  _that.error_message   = '';
                  _that.success_message = "Successfully deleted the Role";
                  _that.removingRightSideWrapper();
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
            setTimeout(() => this.success_message = "", 3000);
            setTimeout(() => this.error_message = "", 3000);
        },

        },
        created() {
            this.getRolesList();
        }
    }
</script>

<style scoped>

</style>
