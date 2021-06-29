<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isAddCheck">
        <div class="right-sidebar-content-area px-2">
            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Add New Category</h2>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="categoryName">Name <span class="required">*</span></label>
                            <input class="form-control" type="text" v-model="categoryData.name" id="categoryName" @change="checkCategoryNameExist(categoryData.name)" @keyup="checkAndChangeValidation()" placeholder="Enter Category Name" required>
                            <span id="categoryNameError" class="small text-danger category_name" role="alert">
                                {{ error_messages[0] }}
                            </span>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Select A Parent</label>
                            <select class="form-control" v-model="selectedCategory" @change="getParentRolesAccess()">
                                <option disabled value="">Select A Category</option>
                                <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category.id">
                                    {{a_category.name}}
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label  class="d-block">Image</label>
                            <input type="file" id="files" ref="files" @change="onLogoFileChange" accept="image/*">
                        </div>
                    </div>
                    <div class="col-md-12" v-if="logo_url">
                        <div class="form-group" >
                            <img class="preview" style="height:250px; width: auto" :src="logo_url"/>
                        </div>
                    </div>
                    <div class="col-md-12" v-if="categoryHasParent != true">
                        <label>Roles</label>
                        <CustomRoleAdd v-if="user_roles" :userRoles="user_roles" @granted-roles="getPermissionGrantedAccess"/>
                    </div>
                </div>
                <div class="form-group text-right">
                    <button class="btn common-gradient-btn ripple-btn px-50" @click="dataValidate()">Add</button>
                </div>
            </div>

        </div>
    </div>
</template>

<script>
    import CustomRoleAdd from './../custom-role/CustomRoleAdd'
    import axios from 'axios'
    import $ from "jquery";
    export default {

        name        : "categoryAdd.vue",
        props       : ['isAddCheck'],
        components  : {
            CustomRoleAdd
        },
        data() {
            return {
                success_message         : '',
                error_messages          : [],
                token                   : '',
                categoryList            : '',
                selectedCategory        : '',
                userInfo                : '',
                logo_file               : '',
                logo_url                : '',
                user_roles              : '',
                roleAccess              : [],
                parent_role_id          : '',
                categoryHasParent       : false,
                userInformation         : '',
                categoryData            : {
                    name                : '',
                },
            }
        },
        methods: {
            getParentRolesAccess()
            {
                let _that   = this;
                let apiUrl  = "categories/";
                axios.get(apiUrl+_that.selectedCategory,
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if (response.data.status_code === 200) {
                            _that.categoryHasParent = true;
                            console.log(response.data.category_info.role_id);
                            _that.parent_role_id = response.data.category_info.role_id;
                            _that.roleAccess =  _that.parent_role_id.split(',');
                        }
                    })
            },
            getPermissionGrantedAccess(status)
            {
                this.roleAccess = status.split(',');

                // this.getUserRoles();
                console.log(this.roleAccess)
            },
            getUserRoles()
            {
                let _that =this;
                axios.get('roles',
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

                            console.log(response);

                            _that.user_roles = response.data.role_list;

                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },
            onLogoFileChange(e)
            {
                this.logo_file = e.target.files[0];
                this.logo_url = URL.createObjectURL(this.logo_file);
            },
            checkCategoryNameExist(categoryInfo)
            {
                let _that = this;
                let category_info  =  categoryInfo.trim();
                if (category_info == null){
                    $('#categoryNameError').html("*name field is required");
                }
                else if (category_info.length > 2 || category_info.length < 100){
                    axios.post('category/name',
                        {
                            name            : this.categoryData.name,
                        },
                        {
                            headers: {
                                'Authorization': 'Bearer '+localStorage.getItem('authToken')
                            }
                        }).then(function (response) {
                        if(response.data.status_code === 400)
                        {
                            _that.success_message           = "";
                            _that.error_message             = "";
                            $('#categoryNameError').html("*"+response.data.error);

                        }
                    }).catch(function (error) {
                        console.log(error);
                    });
                }
            },
            //keyup validation
            checkAndChangeValidation()
            {

                let _that = this;
                if (!_that.categoryData.name){
                    _that.error_messages[0]     = "*The category name is required";
                }
                else if (_that.categoryData.name && (_that.categoryData.name).length >2 && (_that.categoryData.name).length <100){
                    _that.error_messages[0]     = "";
                }
                else{
                    _that.error_messages[0]     = "*The name must be between 3 to 100 charecter";
                }
            },
            //server validation
            showServerError(errors)
            {

                $('#categoryNameError').html("");
                $('#categoryName').css({'border-color': '#ced4da'});
                errors.forEach(val=>{
                    if (val.includes("name")==true){
                        $('#categoryNameError').html(val)
                        $('#categoryName').css({'border-color': '#FF7B88'});
                    }
                })
            },
            //client side validation
            dataValidate()
            {

                let _that = this;
                if (!_that.categoryData.name){
                    _that.error_messages[0]     = "*The category name is required";
                }
                else if (_that.categoryData.name && (_that.categoryData.name).length >2 && (_that.categoryData.name).length <100){
                    _that.categoryAdd();
                }
                else{
                    _that.error_messages[0]     = "*The name must be between 3 to 100 charecter";
                }
            },
            //category add
            categoryAdd()
            {

                let _that = this;
                let formData = new FormData();

                if (_that.roleAccess.length == 0){
                    _that.roleAccess.push(1);
                }

                console.log(this.logo_file);

                formData.append('logo', this.logo_file);
                formData.append('name', this.categoryData.name);
                formData.append('parent_id', this.selectedCategory);
                formData.append('role_id', this.roleAccess);
                // formData.append('operation_type', 'insert');

                axios.post('categories', formData,
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    console.log(response)
                    if (response.data.status_code === 200){

                        _that.categoryData          = '';
                        _that.selectedCategory      = '';
                        _that.error_messages        = '';
                        _that.success_message       = "Category Added Successfully";

                        _that.$emit('category-slide-close', _that.success_message);
                        // document.body.classList.remove('open-side-slider');
                    }else if(response.data.status_code === 400){

                        _that.success_message       = "";
                        _that.error_message         = "";
                        _that.showServerError(response.data.errors);
                    }else{

                        _that.success_message       = "";
                        _that.error_message         = response.data.message;
                    }
                }).catch(errors => console.log(errors));

            },
            //category list
            getCategoryList()
            {

                let _that =this;

                axios.get('categories',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },
                        params :
                            {
                                isAdmin : 1,
                                without_pagination : 1,
                                isRole : _that.userInformation.roles[0].id
                            },

                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            // console.log(response.data);
                            _that.categoryList = response.data.category_list;
                        }
                        else{
                            _that.success_message = "";
                            _that.error_messages   = response.data.error;
                        }
                    })
            },
        },
        created()
        {
            this.userInformation = JSON.parse(localStorage.getItem("userInformation"));
            if (this.userInformation != ''){
                this.getCategoryList();
                this.getUserRoles();
            }
        }
    }
</script>

<style scoped>

</style>
