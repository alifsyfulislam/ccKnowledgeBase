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
                                <h3 class="nk-block-title page-title text-left">Update User</h3>
                            </div>
                        </div>
                    </div>
                    <div  class="card card-bordered card-preview">
                        <div class="card-body">

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Username</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control form-control-lg" v-model="userDetails.username" placeholder="">
                                </div>

                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">First Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control form-control-lg" v-model="userDetails.first_name" placeholder="">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Last Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control form-control-lg" v-model="userDetails.last_name" placeholder="">
                                </div>
                            </div>


                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label" >Email</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="email" class="form-control form-control-lg" v-model="userDetails.email" placeholder="">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Select A Role</label>
                                </div>
                                <div class="col-md-8">
                                    <select class="form-control" v-model="roles">
                                        <option value="">Select A Role</option>
                                        <option v-for="a_role in userRoles" :key="a_role" :value="a_role.id">{{ a_role.name }}</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3" >
                                    <button class="btn btn-info" @click="userUpdate()">Update</button>
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
        name: "customerEdit.vue",
        components: {
            Header,
            Menu
        },

        data() {
            return {
                success_message : '',
                error_message   : '',
                token           : '',
                userDetails      : '',
                user_ID          :  '',
                userRoles  :'',
                user_info:'',
                roles:'',

                filter : {
                    isAdmin : 1
                }
            }
        },

        methods: {
            userUpdate() {
                let _that = this;
                let userID = this.user_ID;

                axios.put('admin/users/update',
                    {
                        id        : userID,
                        username  : this.userDetails.username,
                        first_name: this.userDetails.first_name,
                        last_name : this.userDetails.last_name,
                        email     : this.userDetails.email,
                        roles     : this.roles,
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    if (response.data.status_code == 200)
                    {
                        _that.error_message    = '';
                        _that.success_message  = " Updated Successfully";
                        _that.$router.push('/admin/customerList');
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
            getUserDetails() {
                let _that = this;
                let userID = this.user_ID;

                axios.get("admin/users/"+userID,
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if (response.data.status_code === 200) {

                            _that.userDetails = response.data.user_info;
                            if ((response.data.user_info.roles).length > 0)
                              _that.roles = response.data.user_info.roles[0].id;
                        } else {
                            _that.success_message = "";
                            _that.error_message = response.data.error;
                        }
                    })
            },
            getUserRoles(){
                let _that =this;

                axios.get('admin/roles',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },

                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            _that.userRoles = response.data.role_list;
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            }
        },

        created() {

            this.user_ID = this.$route.params.id;
            this.getUserDetails();
            this.getUserRoles();
        }
    }
</script>

<style scoped>

</style>
