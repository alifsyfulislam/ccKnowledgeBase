<template>
<!--    <div class="col-md-12 wrapper d-flex align-items-stretch">
        <Menu></Menu>

        &lt;!&ndash; Page Content  &ndash;&gt;
        <div id="content" style="margin-left:50px; ">

            <Header></Header>

          <div v-if="isLoading" class="loader-overlay">
            <div class="loader"></div>
            <span class="text" >Hello Loader</span>
          </div>

&lt;!&ndash;          <div  v-if="isLoading">
            <div class="full-screen overlay">
              <div class="center">
                <img  src="@/assets/image2.png" alt="loading image">
              </div>
            </div>

          </div>&ndash;&gt;

            <div class="col-md-12">
                <div v-if="success_message" class="alert alert-success" role="alert">
                    {{ success_message }}
                </div>
                <div v-if="error_message" class="alert alert-danger" role="alert">
                    {{ error_message }}
                </div>
            </div>

            <div class="row">
                <div class="col-md-9">
                    <div class="nk-block-head nk-block-head-sm">
                        <div class="nk-block-between">
                            <div class="nk-block-head-content">
                                <h3 class="nk-block-title page-title text-left">Add a New Role</h3>
                            </div>
                        </div>
                    </div>
                    <div  class="card card-bordered card-preview">
                        <div class="card-body">
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Role Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="roles" class="form-control" placeholder="Add a unique role">
                                </div>
                            </div>
                            <h3 class="text-center">Add Permission</h3>

                            <div class="row">
                                <div v-for="permission in allPermissions" :key="permission" class="text-left col-md-8 offset-4">
                                    <input type="checkbox" v-model="selectedCheckboxes" :value="permission.id" v-bind:id="permission.id" ><label>{{ permission.name }} </label><br><br>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3" >
                                    <button class="btn btn-info" @click="addRole()">Add</button>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>-->

    <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isAdd===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Add New Role</h2>

                    <div v-if="success_message" class="alert alert-success" role="alert">
                        {{ success_message }}
                    </div>
                    <div v-if="error_message" class="alert alert-danger" role="alert">
                        {{ error_message }}
                    </div>


                    <div class="row">

                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="name">Role Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="roles" id="name" placeholder="Enter Role Name" required>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label> Add Permissions</label>

                                <div v-for="permission in allPermissions" :key="permission" class="text-left col-md-8">
                                    <input type="checkbox" v-model="selectedCheckboxes" :value="permission.id" v-bind:id="permission.id" > <label> {{ permission.name }} </label><br><br>
                                </div>

                            </div>
                        </div>

                    </div>

                    <div class="form-group text-right">
                        <button class="btn common-gradient-btn ripple-btn px-50" @click="addRole()">Add</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
</template>

<script>
   /* import Header from "@/layouts/common/Header";
    import Menu from "@/layouts/common/Menu";*/
    import axios from "axios";

    export default {
        name: "rolesAdd.vue",
        props: ['isAddCheck'],
        components: {
          /*  Header,
            Menu*/
        },

        data() {
            return {

                isAdd     : false,
               /* refCount  : 0,
                isLoading : false,*/

                success_message : '',
                error_message   : '',
                token           : '',
                rolesDetails    : '',
                roles_ID        :  '',
                allRoles        :'',
                allPermissions  :'',
                roles_info      :'',
                roles           :'',
                selectedCheckboxes:[],
                isIndex         :'',

                filter : {
                    isAdmin : 1
                }
            }
        },

        methods: {
            clearAllChecker() {

                this.isAdd = false;
                this.$emit('category-data', this.isAdd);

            },

           /* setLoading(isLoading) {
                if (isLoading) {
                  this.refCount++;
                  this.isLoading = true;
                } else if (this.refCount > 0) {
                  this.refCount--;
                  this.isLoading = (this.refCount > 0);
                }
            },*/

            addRole(){
                let _that = this;

                axios.post('admin/roles',
                    {
                        name: this.roles,
                        permission: this.selectedCheckboxes
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    console.log(response.data);
                    if (response.data.status_code === 200) {
                        _that.success_message = "Add a role with permission!";

                        _that.$emit('role-data', "Add a role with permission!");
                        document.body.classList.remove('open-side-slider')
                    } else {
                        _that.success_message = "";
                        _that.error_message = response.data.error;
                    }

                }).catch(function (error) {
                    console.log(error);
                });
            },

            getAllPermission() {
                let _that = this;
                _that.isLoading = true;
                axios.get('admin/permissions',
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                      _that.isLoading = false;
                        if (response.data.status_code === 200) {
                            _that.allPermissions = response.data.permission_list;
                        } else {
                            _that.success_message = "";
                            _that.error_message = response.data.error;
                        }
                    })
            },

        },

        created() {
            this.isAdd = this.isAddCheck;
          //  console.log(this.isAddCheck)
            this.getAllPermission();
        }
    }
</script>

<style scoped>

</style>
