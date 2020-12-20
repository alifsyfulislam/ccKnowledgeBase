<template>
    <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isEdit===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                <img src="../../assets/img/cancel.svg" alt="cancel">
            </button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Role Update</h2>

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
                                <input class="form-control" type="text" v-model="storeName" id="name" placeholder="Enter Role Name" required>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label> Edit Permissions</label>
                                <ul class="list-unstyled permission-list m-0 p-0">
                                    <li  class="text-left pb-2" v-for="permission in allPermissions" :key="permission">
                                        <div v-if="allSelectedPermissionIds.includes(permission.id)" class="d-flex align-items-center">
                                            <input  checked type="checkbox" :value="permission.id"  v-model="selectedCheckboxes" @change="showSelectedItem()"> <label class="mb-0 ml-2"> {{ permission.name }} </label>
                                        </div>
                                        <div v-else class="d-flex align-items-center">
                                            <input type="checkbox" v-model="selectedCheckboxes" :value="permission.id"  @change="showSelectedItem()"> <label class="mb-0 ml-2"> {{ permission.name }} </label>
                                        </div>
                                    </li>
                                </ul>

                            </div>
                        </div>

                    </div>

                    <div class="form-group text-right">
                        <button class="btn common-gradient-btn ripple-btn px-50" @click="updateRole()">Update</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
</template>

<script>
    import axios from "axios";

    export default {
        name: "rolesEdit.vue",
        props: ['isEditCheck', 'roleId'],

        data() {
            return {
                isEdit : false,

                success_message : '',
                error_message   : '',
                token           : '',
                rolesDetails      : '',
                role_id          :  '',
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

            clearAllChecker() {
                this.isEdit = false;
                this.$emit('role-edit-data', this.isEdit);
            },

            showSelectedItem() {
                console.log(this.selectedCheckboxes);
            },

            updateRole() {
                let _that = this;
                let rolesID = this.role_id;

                axios.put('admin/roles/update',
                    {
                        id        : rolesID,
                        name      : this.storeName,
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
                        _that.$emit('role-edit-data', "Role Updated Successfully");
                        document.body.classList.remove('open-side-slider')
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
                let rolesID = this.role_id;

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
            axios.get('admin/permissions',
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
            this.category_id = this.categoryId;
            this.role_id = this.roleId;
           // this.isIndex = this.$route.params.id;
            this.getRolesList();
            this.geRolesDetails();
            this.getAllPermission();
            this.isEdit  = this.isEditCheck;
        }
    }
</script>

<style scoped>

</style>
