<template>

    <div v-cloak class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isEdit===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                <img src="../../assets/img/cancel.svg" alt="cancel">
            </button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Customer Edit</h2>

                    <div class="row" v-if="userDetails">
                        <div class="col-md-12">
                            <div v-if="success_message" class="alert alert-success" role="alert">
                                {{ success_message }}
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="firstName">First Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userDetails.first_name" id="firstName" placeholder="Enter first name here!!" required>
                                <span id="firstNameError" class="text-danger small"> </span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="lastName">Last Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userDetails.last_name" id="lastName" placeholder="Enter last name here!!" required>
                                <span id="lastNameError" class="text-danger small"> </span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="userName">Username <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="userDetails.username" id="userName" placeholder="Enter username here!!" required>
                                <span id="userNameError" class="text-danger small"> </span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email">Email <span class="required">*</span></label>
                                <input class="form-control" type="email" v-model="userDetails.email" id="email" placeholder="Enter last name here!!" required>
                                <span id="emailError" class="text-danger small"> </span>
                            </div>
                        </div>



                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="roles">Roles <span class="required">*</span></label>
                                <select class="form-control" v-model="roles" id="roles">
                                    <option value="" disabled>Select A Role</option>
                                    <option v-for="a_role in userRoles" :key="a_role" :value="a_role.id">{{a_role.name}}</option>
                                </select>
                                <span id="rolesError" class="text-danger small"> </span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="roles">Status<span class="required">*</span></label>
                                <select class="form-control" v-model="userDetails.status">
                                    <option value="" disabled>Select A Status</option>
                                    <option value="0">Inactive</option>
                                    <option value="1">Active</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="form-group text-left">
                                <button class="btn common-gradient-btn ripple-btn px-50" @click="userUpdate()">Update</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</template>

<script>
    import $ from 'jquery'
    import axios from "axios";

    export default {

        name: "customerEdit.vue",
        components: {
        },
        props: ['isEditCheck', 'customerId'],

        data() {
            return {
                isMounted : false,
                isEdit : false,
                success_message : '',
                error_messages   : [],
                token           : '',
                selectedId:'',
                userDetails:'',
                roles:'',
                userRoles:'',
                filter : {
                    isAdmin : 1
                }
            }
        },

        methods: {
            showServerError(errors){
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
            userUpdate() {
                let _that = this;
                let userID = _that.selectedId;

                axios.put('admin/users/update',
                    {
                        id        : userID,
                        username  : _that.userDetails.username,
                        first_name: _that.userDetails.first_name,
                        last_name : _that.userDetails.last_name,
                        email     : _that.userDetails.email,
                        status    : _that.userDetails.status,
                        roles     : _that.roles,
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    if (response.data.status_code == 200)
                    {
                        _that.error_messages    = '';
                        _that.success_message  = " Updated Successfully";
                        _that.$emit('customer-edit-data', _that.userDetails);
                        document.body.classList.remove('open-side-slider');
                    }
                    else
                    {
                        _that.success_message = "";
                        _that.error_messages   = response.data.errors;
                        _that.showServerError(response.data.errors);
                    }

                }).catch(function (error) {
                    console.log(error);
                });

            },

            getUserDetails() {
                let _that = this;
                let userID = this.selectedId;

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
                            _that.error_messages = response.data.error;
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
                        params : {
                            isAdmin : 1,
                            without_pagination : 1
                        },

                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            _that.userRoles = response.data.role_list;
                        }
                        else{
                            _that.success_message = "";
                            _that.error_messages   = response.data.error;
                        }
                    })
            },

            clearAllChecker()
            {
                this.isEdit = false;
                this.$emit('customer-edit-data', this.isEdit);
            },
        },

        created() {
            this.selectedId = this.customerId;
            this.isEdit = this.isEditCheck;
            this.getUserDetails(this.selectedId);
            this.getUserRoles();
        }
    }
</script>

<style scoped>

</style>
