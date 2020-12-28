<template>
    <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isAdd===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                <img src="../../assets/img/cancel.svg" alt="cancel">
            </button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Add New User</h2>

                    <div class="row">
                        <div class="col-md-12">
                            <div v-if="success_message" class="alert alert-success" role="alert">
                                {{ success_message }}
                            </div>
                            <div v-if="error_message" class="alert alert-danger" role="alert">
                                {{ error_message }}
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="firstName">First Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userData.first_name" id="firstName" placeholder="Enter first name here!!" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="lastName">Last Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userData.last_name" id="lastName" placeholder="Enter last name here!!" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="userName">Username <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userData.username" id="userName" placeholder="Enter username here!!" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email">Email <span class="required">*</span></label>
                                <input class="form-control" type="email" v-model="userData.email" id="email" placeholder="Enter last name here!!" required>
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="password">Password <span class="required">*</span></label>
                                <input class="form-control" type="password" v-model="userData.password" id="password" placeholder="Enter password here!!" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                                <input class="form-control" type="password" v-on:keyup="checkPass()" v-model="userData.confirm_password" id="confirmPassword" placeholder="Enter password again!!" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="roles">Roles <span class="required">*</span></label>
                                <select class="form-control" v-model="userData.roles" id="roles">
                                    <option value="" disabled>Select A Role</option>
                                    <option v-for="a_role in userRoles" :key="a_role" :value="a_role.id">{{a_role.name}}</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="roles">Status<span class="required">*</span></label>
                                <select class="form-control" v-model="userData.status">
                                    <option value="" disabled>Select A Status</option>
                                    <option value="0">Inactive</option>
                                    <option value="1">Active</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="form-group text-left">
                                <button class="btn common-gradient-btn ripple-btn px-50" @click="userAdd()">Add</button>
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

    export default {
        name: "customerAdd.vue",
        props: ['isAddCheck'],
        components: {

        },

        data() {
            return {
                isAdd : false,
                isSearch        : false,

                success_message : '',
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
                    status : '',
                },

            }
        },


        methods: {

            clearAllChecker() {

                this.isAdd = false;
                this.$emit('customer-data', this.isAdd);

            },

            checkPass(){
                let _that = this;
                if (_that.userData.password === _that.userData.confirm_password && _that.userData.password.length == _that.userData.confirm_password.length){
                    _that.success_message  = "password matched!!";
                    _that.error_message   = "";
                    console.log(_that.userData);
                }else{
                    _that.error_message   = "password not matched";
                    _that.success_message  = "";
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
                        status: this.userData.status,
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
                        _that.$emit('customer-data', _that.userData);
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

            getUserRoles(){
                let _that =this;

                axios.get('admin/roles',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },
                        params : {
                            isAdmin : 1,
                            without_pagination : 1
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
            this.isAdd = this.isAddCheck;
            console.log(this.isAddCheck)
            this.getUserRoles();
        }
    }
</script>

<style scoped>

</style>
