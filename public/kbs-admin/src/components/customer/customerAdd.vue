<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isAddCheck">
        <div class="right-sidebar-content-area px-2">
            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Add New User</h2>

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
                            <input class="form-control" type="text" v-model="userData.password" id="password" @keyup="checkAndValidatePassword()" placeholder="Enter password here!!" required>
                            <span id="passwordError" class="text-danger small"> </span>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                            <input class="form-control" type="text" v-on:keyup="checkPasswordMatch()" v-model="userData.confirm_password" id="confirmPassword" placeholder="Enter password again!!" required>
                            <span id="confirmPasswordError" class="small"> </span>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="roles">Roles <span class="required">*</span></label>
                            <select class="form-control" v-model="userData.roles" id="roles" @change="checkAndValidateRoles()" required>
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
</template>

<script>
import axios from 'axios'
import $ from 'jquery'

export default {
    name: "customerAdd.vue",
    props: ['isAddCheck'],
    components: {},
    data() {
        return {
            success_message         : '',
            error_message           : '',
            token                   : '',
            userRoles               : '',

            userData         : {
                username            : '',
                first_name          : '',
                last_name           : '',
                email               : '',
                password            : '',
                confirm_password    : '',
                roles               : '',
                status              : 1,
            },

            validation_error :{
                isFirstNameStatus   : false,
                isLastNameStatus    : false,
                isUserNameStatus    : false,
                isEmailStatus       : false,
                isRoleStatus        : false,
                isPasswordStatus    : false,
                isConfirmationStatus : false,
            },
        }
    },
    methods: {
        checkAndValidateRoles()
        {
            if (!this.userData.roles) {
                $('#roles').css({
                    'border-color': '#FF7B88',
                });
                $('#rolesError').html("*role field is required");
                this.validation_error.isRoleStatus = false;

            } else{
                $('#roles').css({
                    'border-color': '#ced4da',
                });
                $('#rolesError').html("");
                this.validation_error.isRoleStatus = true;
            }
        },

        checkAndValidatePassword()
        {
            if ((this.userData.password).length >0) {
                if (!this.validPassword(this.userData.password)) {
                    $('#password').css({
                        'border-color': '#FF7B88',
                    });
                    $('#passwordError').html("*password should contain at least a Uppercase, lowecase, numeric and special character");
                    this.validation_error.isPasswordStatus = false;

                } else if((this.userData.password).length <8) {
                    $('#password').css({
                        'border-color': '#FF7B88',
                    });
                    $('#passwordError').html("*password must be 8 characters or longer");
                    this.validation_error.isPasswordStatus = false;
                }
                else {
                    $('#password').css({
                        'border-color': '#ced4da',
                    });
                    $('#passwordError').html("");
                    this.validation_error.isPasswordStatus = true;
                }

            } else{
                $('#password').css({
                    'border-color': '#FF7B88',
                });
                $('#passwordError').html("password field is required");
                this.validation_error.isPasswordStatus = false;
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
                    this.validation_error.isEmailStatus = false;

                } else {
                    $('#email').css({
                        'border-color': '#ced4da',
                    });
                    $('#emailError').html("");
                    this.validation_error.isEmailStatus = true;
                }

            } else{
                $('#email').css({
                    'border-color': '#FF7B88',
                });
                $('#emailError').html("*email field is required");
                this.validation_error.isEmailStatus = false;
            }

        },

        checkAndChangeValidation(selected_data, selected_id, selected_error_id, selected_name)
        {
            if (selected_data.length >0) {
                if (selected_data.length <3){
                    $(selected_id).css({
                        'border-color': '#FF7B88',
                    });
                    $(selected_error_id).html( selected_name+" should contain minimum 3 character");

                    if (selected_name === "*first name" ){
                        this.validation_error.isFirstNameStatus = false;
                    }else if (selected_name === "*last name"){
                        this.validation_error.isLastNameStatus = false
                    }else if(selected_name === "*user name"){
                        this.validation_error.isUserNameStatus = false;
                    }

                }else {
                    $(selected_id).css({
                        'border-color': '#ced4da',
                    });
                    $(selected_error_id).html("");

                    if (selected_name === "*first name" ){
                        this.validation_error.isFirstNameStatus = true;
                    }else if (selected_name === "*last name"){
                        this.validation_error.isLastNameStatus = true
                    }else if(selected_name === "*user name"){
                        this.validation_error.isUserNameStatus = true;
                    }
                }

            } else{
                $(selected_id).css({
                    'border-color': '#FF7B88',
                });
                $(selected_error_id).html(selected_name+" field is required")
                if (selected_name === "*first name" ){
                    this.validation_error.isFirstNameStatus = false;
                }else if (selected_name === "*last name"){
                    this.validation_error.isLastNameStatus = false
                }else if(selected_name === "*user name"){
                    this.validation_error.isUserNameStatus = false;
                }
            }
        },

        checkPasswordMatch()
        {
            let _that = this;
            if (_that.userData.password === _that.userData.confirm_password && _that.userData.password.length == _that.userData.confirm_password.length){
                $('#confirmPassword').css({
                    'border-color': '#ced4da',
                });
                $('#confirmPasswordError').css({'color': 'green'});
                $('#confirmPasswordError').html("password matched!!");
                _that.validation_error.isConfirmationStatus = true;
            }else if(!_that.userData.confirm_password){
                $('#confirmPassword').css({
                    'border-color': '#FF7B88',
                });
                $('#confirmPasswordError').html("*confirm password field is required")
                $('#confirmPasswordError').css({'color': '#FF7B88'});
                _that.validation_error.isConfirmationStatus = false;

            }
            else{
                $('#confirmPassword').css({
                    'border-color': '#FF7B88',
                });
                $('#confirmPasswordError').html("*password not matched")
                $('#confirmPasswordError').css({'color': '#FF7B88'});
                _that.validation_error.isConfirmationStatus = false;
            }
        },

        validPassword(password)
        {
            var strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{4,})");
            return strongRegex.test(password);
        },

        validEmail (email)
        {
            var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(email);
        },

        validateAndSubmit()
        {
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
                $('#confirmPasswordError').css({'color': '#FF7B88'});
                $('#confirmPasswordError').html("*confirm password field is required");
            }
            if (!this.userData.roles){

                $('#roles').css({
                    'border-color': '#FF7B88',
                });
                $('#rolesError').html("*roles field is required");
            }
            if (this.validation_error.isFirstNameStatus === true &&
                this.validation_error.isLastNameStatus === true &&
                this.validation_error.isUserNameStatus === true &&
                this.validation_error.isEmailStatus === true &&
                this.validation_error.isRoleStatus === true &&
                this.validation_error.isPasswordStatus === true &&
                this.validation_error.isConfirmationStatus === true){
                console.log(this.validation_error)
                this.userAdd();
            }
        },

        showServerError(errors)
        {
            $('#lastNameError').html("");
            $('#firstNameError').html("");
            $('#userNameError').html("");
            $('#emailError').html("");
            $('#rolesError').html("");

            $('#firstName').css({'border-color': '#ced4da'});
            $('#lastName').css({'border-color': '#ced4da'});
            $('#userName').css({'border-color': '#ced4da'});
            $('#email').css({'border-color': '#ced4da'});
            $('#roles').css({'border-color': '#ced4da'});
            errors.forEach(val=>{
                if (val.includes("first")==true){
                    $('#firstNameError').html(val)
                    $('#firstName').css({'border-color': '#FF7B88'});
                }
                else if (val.includes("last")==true){
                    $('#lastNameError').html(val)
                    $('#lastName').css({'border-color': '#FF7B88'});
                }
                else if (val.includes("username")==true){
                    $('#userNameError').html(val)
                    $('#userName').css({'border-color': '#FF7B88'});
                }
                else if (val.includes("email")==true){
                    $('#emailError').html(val)
                    $('#email').css({'border-color': '#FF7B88'});
                }
                else if (val.includes("email")==true){
                    $('#rolesError').html(val)
                    $('#roles').css({'border-color': '#FF7B88'});
                }
            })
        },

        userAdd()
        {
            let _that = this;
            axios.post('admin/users',
                {
                    username            : this.userData.username,
                    first_name          : this.userData.first_name,
                    last_name           : this.userData.last_name,
                    email               : this.userData.email,
                    password            : this.userData.password,
                    confirm_password    : this.userData.confirm_password,
                    roles               : this.userData.roles,
                    status              : this.userData.status,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                if (response.data.status_code === 201)
                {
                    _that.userData                  = '';
                    _that.error_message             = '';
                    _that.success_message           = "User Added Successfully";

                    _that.$emit('user-slide-close', _that.success_message);
                }
                else if(response.data.status_code === 400)
                {
                    _that.success_message           = "";
                    _that.error_message             = "";
                    _that.showServerError(response.data.errors);

                }else{
                    _that.success_message           = "";
                    _that.error_message             = response.data.message;
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
    created()
    {
        this.getUserRoles();
    }
}
</script>

<style scoped>

</style>
