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
                                <label for="role_name">Role Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="roles" id="role_name" placeholder="Enter Role Name" @keyup="checkAndChangeValidation(roles, '#role_name', '#roleNameError', '*role name')" required>
                                <span id="roleNameError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label> Add Permissions</label>
                                <ul class="list-unstyled permission-list m-0 p-0">
                                    <li v-for="permission in allPermissions" :key="permission" class="text-left pb-2">
                                        <input type="checkbox" v-model="selectedCheckboxes" :value="permission.id" v-bind:id="permission.id" > <label class="pl-2 mb-0"> {{ permission.name }} </label>
                                    </li>
                                </ul>

                            </div>
                        </div>

                    </div>

                    <div class="form-group text-right">
                        <button class="btn common-gradient-btn ripple-btn px-50" @click="validateAndSubmit()">Add</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import $ from "jquery";

export default {
    name: "rolesAdd.vue",
    props: ['isAddCheck'],
    data() {
        return {

            isAdd          : false,

            success_message : '',
            error_message   : '',
            token           : '',
            rolesDetails    : '',
            roles_ID        : '',
            allRoles        : '',
            allPermissions  : '',
            roles_info      : '',
            roles           : '',
            selectedCheckboxes: [],
            isIndex         : '',

            validation_error :{
                isRoleNameStatus : false,
            },

            filter : {
                isAdmin : 1
            }
        }
    },

    methods: {

        clearAllChecker() {

            this.isAdd = false;
            this.$emit('role-data', this.isAdd);

        },

        checkAndChangeValidation(selected_data, selected_id, selected_error_id, selected_name) {

            if (selected_data.length >0) {
                if (selected_data.length <3){
                    $(selected_id).css({
                        'border-color': '#FF7B88',
                    });
                    $(selected_error_id).html( selected_name+" should contain minimum 3 character");

                    if (selected_name === "*role name"){
                        this.validation_error.isRoleNameStatus = false;
                    }

                }else {
                    $(selected_id).css({
                        'border-color': '#ced4da',
                    });
                    $(selected_error_id).html("");

                    if (selected_name === "*role name" ){
                        this.validation_error.isRoleNameStatus = true;
                    }
                }

            } else{
                $(selected_id).css({
                    'border-color': '#FF7B88',
                });
                $(selected_error_id).html(selected_name+" field is required")

                if (selected_name === "*role name" ){
                    this.validation_error.isRoleNameStatus = false;
                }
            }
        },

        validateAndSubmit(){

            if (!this.roles){
                $('#role_name').css({
                    'border-color': '#FF7B88',
                });
                $('#roleNameError').html("role name field is required");
            }

            if (this.validation_error.isRoleNameStatus === true){
                //console.log(this.validation_error)
                this.addRole();
            }
        },

        showServerError(errors){

            $('#nameError').html("");

            $('#name').css({'border-color': '#ced4da'});

            errors.forEach(val=>{
                console.log(val);
                if (val.includes("name")===true){
                    $('#nameError').html(val)
                    $('#name').css({'border-color': '#FF7B88'});
                }

            })
        },

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
                    _that.isAdd = false;
                    _that.$emit('role-data', "Add a role with permission!");
                    document.body.classList.remove('open-side-slider')

                }else if(response.data.status_code === 400){
                    _that.success_message       = "";
                    _that.error_message         = "";
                    _that.showServerError(response.data.errors);

                }else{
                    _that.success_message       = "";
                    _that.error_message         = response.data.message;
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
