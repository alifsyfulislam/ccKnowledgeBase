<template>
    <div class="col-md-12 wrapper d-flex align-items-stretch">
        <Menu></Menu>

        <!-- Page Content  -->
        <div id="content" style="margin-left:50px; ">

            <Header></Header>

            <div class="col-md-12">
                <div v-if="success_message_2" class="alert alert-warning" role="alert">
                    {{ success_message_2 }}
                </div>
                <div v-else class="hide" role="alert"></div>
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
                                <h3 class="nk-block-title page-title text-left">Add New User</h3>
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
                                    <input type="text" class="form-control form-control-lg" v-model="userData.username" placeholder="Enter a Unique Username">
                                </div>

                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">First Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control form-control-lg" v-model="userData.first_name" placeholder="Enter First Name">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Last Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" class="form-control form-control-lg" v-model="userData.last_name" placeholder="Enter Last Name">
                                </div>
                            </div>


                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label" >Email</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="email" class="form-control form-control-lg" v-model="userData.email" placeholder="Enter Email Here">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label" >Password</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="password" class="form-control form-control-lg" v-model="userData.password" placeholder="Enter Password Here">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label" >Confirm Password</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="password" class="form-control form-control-lg" v-model="userData.confirm_password" v-on:keyup="checkPass()" placeholder="Enter Password Here">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Select A Role</label>
                                </div>
                                <div class="col-md-8">
                                    <select class="form-control" v-model="userData.roles">
                                        <option value="">Select A Role</option>
                                        <option v-for="a_role in userRoles" :key="a_role" :value="a_role.id">{{a_role.name}}</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3" >
                                    <button class="btn btn-info" @click="userAdd()">Save</button>
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
    import Menu from '@/layouts/common/Menu.vue'
    import Header from '../../layouts/common/Header.vue'
    export default {
        name: "customerAdd.vue",

        components: {
            Header,
            Menu
        },

        data() {
            return {
                success_message : '',
                success_message_2 : '',
                error_message   : '',
                token           : '',
                userRoles       :'',

                userData        : {
                    username  : '',
                    first_name  : '',
                    last_name  : '',
                    email  : '',
                    password  : '',
                    confirm_password  : '',
                    roles : '',
                },

            }
        },
        methods: {

            checkPass(){
                let _that = this;
                if (_that.userData.password === _that.userData.confirm_password && _that.userData.password.length == _that.userData.confirm_password.length){
                    _that.success_message_2  = "matched!!";
                    console.log(_that.userData);
                }else{
                    _that.success_message_2   = "not matched";
                }
            },

            userAdd() {
                let _that = this;
                console.log(_that.userData.roles);

                axios.post('admin/users',
                    {
                        username: this.userData.username,
                        first_name: this.userData.first_name,
                        last_name: this.userData.last_name,
                        email: this.userData.email,
                        password: this.userData.password,
                        confirm_password: this.userData.confirm_password,
                        roles: this.userData.roles,
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    if (response.data.status_code == 201)
                    {
                        _that.userData          = '';
                        _that.error_message    = '';
                        _that.success_message  = "New Customer Added Successfully";
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
                            // console.log(_that.userRoles);
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            }

        },
        created() {
            this.getUserRoles();
        }
    }
</script>

<style scoped>

</style>
