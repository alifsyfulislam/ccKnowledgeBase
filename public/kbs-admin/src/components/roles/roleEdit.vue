<template>
    <div class="col-md-12 wrapper d-flex align-items-stretch">
        <Menu></Menu>

        <!-- Page Content  -->
        <div id="content" style="margin-left:50px; ">

            <Header></Header>

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
                                <h3 class="nk-block-title page-title text-left">Update Role</h3>
                            </div>
                        </div>
                    </div>
                    <div  class="card card-bordered card-preview">
                        <div class="card-body">
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Role</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control" v-model="storeName">
                                </div>
                            </div>
                            <h3 class="text-center">Edit Permission</h3>
                              <div class="row">
<!--                                <div v-for="a_access in allAccess" :key="a_access" class="text-left col-md-8 offset-4">
                                  <input checked type="checkbox" :value="a_access.id"  v-model="selectedCheckboxes"> <label>{{ a_access.name }} </label><br><br>
                                </div>-->

                                <div v-for="permission in allPermissions" :key="permission" class="text-left col-md-8 offset-4">
                                  <div v-if="allSelectedPermissionIds.includes(permission.id)">
                                    <input  checked type="checkbox" :value="permission.id"  v-model="selectedCheckboxes" @change="showSelectedItem()"> <label>{{ permission.name }} </label><br><br>
                                  </div>
                                  <div v-else>
                                    <input type="checkbox" v-model="selectedCheckboxes" :value="permission.id"  @change="showSelectedItem()"><label>{{ permission.name }} </label><br><br>
                                  </div>


                                </div>

                              </div>

<!--                            <div class="row">
&lt;!&ndash;                                <span v-for="a_access in allAccess" :key="a_access">{{a_access.id}}</span>&ndash;&gt;
                                <div v-for="permission in allPermissions" :key="permission" :value="permission.id" class="text-left col-md-8 offset-4">
                                    <div v-for="a_access in allAccess" :key="a_access">
                                        <span v-if="permission.id==a_access.id">
                                            <input checked type="checkbox" :value="a_access.id"  v-model="selectedCheckboxes" v-bind:id="a_access.id"> <label>{{ a_access.name }} </label><br><br>
                                        </span>
                                      <span v-else>
                                         <input  type="checkbox" :value="permission.id"  v-model="selectedCheckboxes" v-bind:id="permission.id"> <label>{{ permission.name }} </label><br><br>
                                      </span>

                                    </div>
                                </div>
                            </div>-->
                            <div class="row">
                                <div class="col-md-3" >
                                    <button class="btn btn-info" @click="updateRole()">Update</button>
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
    import Header from "@/layouts/common/Header";
    import Menu from "@/layouts/common/Menu";
    import axios from "axios";

    export default {
        name: "rolesEdit.vue",
        components: {
            Header,
            Menu
        },

        data() {
            return {
                success_message : '',
                error_message   : '',
                token           : '',
                rolesDetails      : '',
                roles_ID          :  '',
                allRoles  :'',
                allPermissions  : [],
                roles_info:'',
                selectedCheckboxes:[],
                allSelectedPermissionIds : [],
                roles:'',
                allAccess : [],
                storeName:'',
                filter : {
                    isAdmin : 1
                }
            }
        },

        methods: {
          showSelectedItem()
          {
            console.log(this.selectedCheckboxes);
          },
            updateRole() {
                let _that = this;
                let rolesID = this.roles_ID;

                axios.put('admin/roles/update',
                    {
                        id        : rolesID,
                        name      : _that.storeName,
                        permission: this.selectedCheckboxes
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    if (response.data.status_code == 200)
                    {
                        _that.error_message    = '';
                        _that.success_message  = "Role Updated Successfully";
                        _that.$router.push('/admin/roleList');
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

            geRolesDetails() {
                let _that = this;
                let rolesID = this.roles_ID;

                axios.get("admin/roles/"+rolesID,
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if (response.data.status_code === 200) {
                            _that.rolesDetails = response.data.role_info;
                            _that.roles = _that.rolesDetails.id;
                            _that.storeName = _that.rolesDetails.name;
                            _that.allAccess = _that.rolesDetails.permissions;


                          _that.allAccess.forEach( anAccessId =>
                          {
                            _that.allSelectedPermissionIds.push(anAccessId.id)
                          });
                          _that.selectedCheckboxes = _that.allSelectedPermissionIds;

                            console.log(response.data.role_info);
                            console.log(_that.allSelectedPermissionIds);

                        } else {
                            _that.success_message = "";
                            _that.error_message = response.data.error;
                        }
                    })
            },

          getAllPermission() {
            let _that = this;
            axios.get('permissions',
                {
                  headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                  },

                })
                .then(function (response) {
                  if (response.data.status_code === 200) {
                    //_that.allPermissions = response.data.permission_list;

                    _that.allPermissions = response.data.permission_list;
                    /*console.log("before splice");
                    console.log( _that.allPermissions);

                    (_that.allPermissions).forEach( aRole => {

                      (_that.allAccess).forEach( anAccess => {
                        if ( anAccess.id == aRole.id)
                        {
                          console.log("in for each loop")
                          _that.allPermissions.splice(_that.allPermissions.indexOf(aRole.id), 1);
                        }
                      });

                    });*/

                    console.log("after splice");
                    console.log( _that.allPermissions);
                  //  _that.allPermissions    = tempRoleData;
                  } else {
                    _that.success_message = "";
                    _that.error_message = response.data.error;
                  }
                })
          },

            getRolesList(){
                let _that =this;
                axios.get('admin/roles',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },

                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            //_that.allRoles = response.data.role_list;
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            }
        },

        created() {
            this.roles_ID = this.$route.params.id;
            this.isIndex = this.$route.params.id;
            this.getRolesList();
            this.geRolesDetails();
            this.getAllPermission();
        }
    }
</script>

<style scoped>

</style>
