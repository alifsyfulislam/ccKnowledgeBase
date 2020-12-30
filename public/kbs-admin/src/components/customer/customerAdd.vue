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
                    </div>

                    <div class="form-group alert alert-danger" v-if="validation_errors!='' && validation_errors!=undefined">
                        <ul>
                            <li v-for="error in validation_errors" :key="error">{{ error }}</li>
                        </ul>
                    </div>

                    <div class="row">

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="firstName">First Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userData.first_name" id="firstName" @keyup="checkAndChangeValidation(userData.first_name, '#firstName', '#firstNameError', '*first name')" placeholder="Enter first name here!!" required >
                                <span id="firstNameError" class="text-danger small"> </span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="lastName">Last Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userData.last_name" id="lastName"  placeholder="Enter last name here!!" @keyup="checkAndChangeValidation(userData.last_name, '#lastName', '#lastNameError', '*last name')" required>
                                <span id="lastNameError" class="text-danger small"> </span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="userName">Username <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userData.username" id="userName" placeholder="Enter username here!!" @keyup="checkAndChangeValidation(userData.username, '#userName', '#userNameError', '*user name')" required>
                                <span id="userNameError" class="text-danger small"> </span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email">Email <span class="required">*</span></label>
                                <input class="form-control" type="email" v-model="userData.email" id="email" placeholder="Enter valid email here!!" @keyup="checkAndValidateEmail()" required>
                                <span id="emailError" class="text-danger small"> </span>
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="password">Password <span class="required">*</span></label>
                                <input class="form-control" type="password" v-model="userData.password" id="password" @keyup="checkAndValidatePassword()" placeholder="Enter password here!!" required>
                                <span id="passwordError" class="text-danger small"> </span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                                <input class="form-control" type="password" v-on:keyup="checkPasswordMatch()" v-model="userData.confirm_password" id="confirmPassword" placeholder="Enter password again!!" required>
                                <span id="confirmPasswordError" class="small"> </span>
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="roles">Roles <span class="required">*</span></label>
                                <select class="form-control" v-model="userData.roles" id="roles" required>
                                    <option value="" disabled>Select A Role</option>
                                    <option v-for="a_role in userRoles" :key="a_role" :value="a_role.id">{{a_role.name}}</option>
                                </select>
                                <span id="rolesError" class="text-danger small"> </span>
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

                        <div class="col-md-12">
                            <div class="form-group text-right">
                                <button class="btn common-gradient-btn ripple-btn px-50" @click="validateAndSubmit()">Add</button>
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
import $ from 'jquery'

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

                username   : '',
                first_name : '',
                last_name  : '',
                email      : '',
                password   : '',
                confirm_password : '',
                roles   : '',
                status  : '',
            },

            isFrontValidation : false,

        }
    },


    methods: {

        checkAndValidatePassword() {

            if ((this.userData.password).length >0) {
                if (!this.validPassword(this.userData.password)) {
                    $('#password').css({
                        'border-color': '#FF7B88',
                    });

                    $('#passwordError').html("*password should contain at least a Uppercase, lowecase, numeric and special character");

                } else if((this.userData.password).length <8) {
                    $('#password').css({
                        'border-color': '#FF7B88',
                    });

                    $('#passwordError').html("*password must be 8 characters or longer");
                }
                    else {
                    $('#password').css({
                        'border-color': '#ced4da',
                    });
                    $('#passwordError').html("");
                }

            } else{
                $('#password').css({
                    'border-color': '#FF7B88',
                });
                $('#passwordError').html("password field is required");
            }

        },

        checkAndValidateEmail()
        {
            if ((this.userData.email).length >0) {
                if (!this.validEmail(this.userData.email)) {
                    $('#email').css({
                        'border-color': '#FF7B88',
                    });

                    $('#emailError').html("*Valid email required");

                } else {
                    $('#email').css({
                        'border-color': '#ced4da',
                    });
                    $('#emailError').html("");
                }

            } else{
                $('#email').css({
                    'border-color': '#FF7B88',
                });
                $('#emailError').html("*email field is required");
            }

        },

        checkAndChangeValidation(selected_data, selected_id, selected_error_id, selected_name) {

            if (selected_data.length >0) {
                if (selected_data.length <3){
                    $(selected_id).css({
                        'border-color': '#FF7B88',
                    });
                    $(selected_error_id).html( selected_name+" should contain minimum 3 character");
                }else {
                    $(selected_id).css({
                        'border-color': '#ced4da',
                    });
                    $(selected_error_id).html("");
                }

            } else{
                $(selected_id).css({
                    'border-color': '#FF7B88',
                });
                $(selected_error_id).html(selected_name+" field is required")
            }
        },

        clearAllChecker() {

            this.isAdd = false;
            this.$emit('customer-data', this.isAdd);

        },

        checkPasswordMatch(){
            let _that = this;
            if (_that.userData.password === _that.userData.confirm_password && _that.userData.password.length == _that.userData.confirm_password.length){
                $('#confirmPasswordError').css({'color': '#D4EDDA'});
                $('#confirmPasswordError').html("password matched!!")
            }else{
                $('#confirmPasswordError').html("password not matched")
                $('#confirmPasswordError').css({'color': '#FF7B88'});
            }
        },

        validPassword(password) {

            var strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{4,})");
            return strongRegex.test(password);
        },

        validEmail (email) {
            var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(email);
        },

        validateAndSubmit() {

            if (!this.userData.first_name){
                $('#firstName').css({
                    'border-color': '#FF7B88',
                });
                $('#firstNameError').html("*first name field is required");
            }

            if (!this.userData.last_name){

                $('#lastName').css({
                    'border-color': '#FF7B88',
                });
                $('#lastNameError').html("*last name field is required");
            }


            if (!this.userData.username){

                $('#userName').css({
                    'border-color': '#FF7B88',
                });
                $('#userNameError').html("*user name field is required");
            }


            if (!this.userData.email){

                $('#email').css({
                    'border-color': '#FF7B88',
                });
                $('#emailError').html("*email field is required");
            }


            if (!this.userData.password){

                $('#password').css({
                    'border-color': '#FF7B88',
                });
                $('#passwordError').html("*password field is required");
            }

            if (!this.userData.confirm_password){

                $('#confirmPassword').css({
                    'border-color': '#FF7B88',
                });
                $('#confirmPasswordError').html("*confirm password field is required");
            }

            if (!this.userData.roles){

                $('#roles').css({
                    'border-color': '#FF7B88',
                });
                $('#rolesError').html("*roles field is required");
            }

            /*if (!this.userData.username || !this.userData.first_name || !this.userData.last_name || !this.userData.password || !this.userData.confirm_password){

                $('.form-control:required').css({
                    'border-color': '#FF7B88',
                });
                this.isFrontValidation = true;

            }else if ((this.userData.first_name).length <3) {

                this.isFrontValidation = false;
                this.success_message   = "";
                this.error_message     = "First Name should contain minimum 3 character";

                //this.errors.push('Valid email required.');
            }else if ((this.userData.last_name).length <3) {

                this.isFrontValidation = false;
                this.success_message   = "";
                this.error_message     = "Last Name should contain minimum 3 character";
                //this.errors.push('Valid email required.');

            }else if ((this.userData.username).length <4) {

                this.isFrontValidation = false;
                this.success_message   = "";
                this.error_message     = "UserName should contain minimum 4 character";
                //this.errors.push('Valid email required.');

            } else if (!this.validEmail(this.userData.email)) {

                this.isFrontValidation = false;
                this.success_message   = "";
                this.error_message     = "Valid email required";
                //this.errors.push('Valid email required.');

            }
            else {

                this.isFrontValidation = false;
                this.success_message   = "";
                this.error_message     = "";
                this.userAdd();
            }*/

            // $("#firstName").css({ color: "#FF7B88"});

        },

        userAdd() {
            let _that = this;
            //console.log(_that.userData.roles);

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
                //console.log(response.data)

                if (response.data.status_code === 201){
                    _that.userData          = '';
                    _that.error_message    = '';
                    _that.success_message  = "New Customer Added Successfully";
                    _that.$emit('customer-data', _that.userData);
                    document.body.classList.remove('open-side-slider')
                }
                else if(response.data.status_code === 400){
                    _that.success_message   = "";
                    _that.error_message     = "";
                    _that.validation_errors = response.data.error;
                    //  console.log(response.data);
                }
                else{
                    _that.success_message   = "";
                    _that.validation_errors = "";
                    _that.error_message     = response.data.message;
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
        this.getUserRoles();
    }
}
</script>

<style scoped>

</style>
