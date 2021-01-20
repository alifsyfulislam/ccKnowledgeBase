<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isEditCheck">
        <div class="right-sidebar-content-area px-2">




            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Edit Category</h2>

                <div class="alert-success" v-if="success_message">
                    <span>{{ success_message }}</span>
                </div>

                <div  v-if="error_message">
                    <span class="text-danger">{{ error_message }}</span>
                </div>

                <div class="row">

                    <div class="col-md-12" v-if="categoryId ? category_id=categoryId : ''">

                        <div class="form-group">
                            <label for="categoryName">Name <span class="required">*</span></label>
                            <input class="form-control" type="text" v-model="category_name" id="categoryName" @keyup="checkAndChangeValidation()" @change="checkCategoryNameExist(category_name)" required>
                            <span  id="categoryNameError" class="small text-danger category_name" role="alert"></span>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Select A Parent</label>
                            <select class="form-control" v-model="category_parent_id" id="categoryParent">
                                <option value="0">Select A Category</option>
                                <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                                    {{a_category.name}}
                                </option>
                            </select>
                            <span  id="categoryParentError" class="small text-danger category_parent_id" role="alert"></span>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label  class="d-block">Image</label>
                            <input type="file" id="files" class="form-control" ref="files" @change="onLogoFileChange" >
                        </div>
                    </div>

                    <div class="col-md-12" v-if="logo_url">
                        <div class="form-group" >
                            <img class="preview" style="height:250px; width: auto" :src="logo_url"/>
                        </div>
                    </div>

                </div>

                <div class="form-group text-right">
                    <button class="btn common-gradient-btn ripple-btn px-50" @click="dataValidate()">Update</button>
                </div>
            </div>

        </div>
    </div>
</template>

<script>

import axios from "axios";
import $ from "jquery";

export default {

    name: "categoryEdit.vue",
    props: ['isEditCheck', 'categoryId'],

    data() {
        return {
            category_id          : '',
            category_parent_id   : '',
            category_name        : '',
            categoryDetails      : '',
            tempCategoryList     : '',
            categoryList         : [],
            error_message        : '',
            success_message      : '',
            token                : '',

            logo_file        : '',
            logo_url         : '',
        }
    },

    methods: {

        onLogoFileChange(e) {
            this.logo_file = e.target.files[0];
            this.logo_url = URL.createObjectURL(this.logo_file);
        },

        checkCategoryNameExist(categoryInfo){

            let _that = this;
            let category_info  =  categoryInfo.trim();
            if (category_info == null){
                $('#categoryNameError').html("*name field is required");
            }
            else if (category_info.length > 2 || category_info.length < 100){
                axios.post('admin/category/name',
                    {
                        id              : this.categoryDetails.id,
                        name            : this.category_name,
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
            if (!_that.category_name){

                $('#categoryName').css({
                    'border-color': '#FF7B88',
                });
                $('#categoryNameError').html("*The category name is required");
            }
            else if (_that.category_name && (_that.category_name).length >2 && (_that.category_name).length <100){
                $('#categoryName').css({
                    'border-color': '#ced4da',
                });
                $('#categoryNameError').html("");
            }
            else{
                $('#categoryName').css({
                    'border-color': '#FF7B88',
                });

                $('#categoryNameError').html("*The name must be between 3 to 100 charecter");

            }
        },

        showServerError(errors)
        {
            $('#categoryNameError').html("");
            $('#categoryName').css({'border-color': '#ced4da'});
            errors.forEach(val => {
                if (val.includes("name")==true){
                    $('#categoryNameError').html(val)
                    $('#categoryName').css({'border-color': '#FF7B88'});
                }
            })
        },

        dataValidate()
        {
            let _that = this;

            if (!_that.category_name){

                $('#categoryName').css({
                    'border-color': '#FF7B88',
                });
                $('#categoryNameError').html("*The category name is required");
            }
            else if (_that.category_name && (_that.category_name).length >2 && (_that.category_name).length <100){
                $('#categoryName').css({
                    'border-color': '#ced4da',
                });
                $('#categoryNameError').html("");
                _that.categoryUpdate();
            }
            else{
                $('#categoryName').css({
                    'border-color': '#FF7B88',
                });

                $('#categoryNameError').html("*The name must be between 3 to 100 charecter");

            }
        },

        categoryUpdate()
        {
            let _that = this;
            let formData = new FormData();

            formData.append('id', _that.category_id);
            formData.append('logo', _that.logo_file);
            formData.append('name', _that.category_name);
            formData.append('parent_id', _that.category_parent_id);

            axios.post('admin/category/update-data', formData,
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                    console.log(response);

                if (response.data.status_code === 200){
                    _that.category_name           = '',
                    _that.category_parent_id      = '',
                    _that.error_message           = '';
                    _that.success_message         = "Category Updated Successfully";
                    _that.$emit('category-slide-close',_that.success_message);
                }
                else if(response.data.status_code === 400)
                {
                    _that.success_message           = "";
                    _that.error_message             = "";
                    _that.showServerError(response.data.errors);

                }else{
                    _that.success_message = "";
                    _that.error_message   = "";

                    if ((response.data.error).includes("Parent")){
                        $('#categoryParentError').html(  response.data.error );
                        $('#categoryParent').css({'border-color': '#FF7B88'});
                    }else {
                        _that.error_message   = response.data.error;
                    }

                }

            }).catch(function (error) {
                console.log(error);
            });

        },

        getCategoryList()
        {
            let _that = this;
            axios.post('admin/category-list-for-update',
                {
                    id : _that.category_id
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        console.log(response.data.category_list);
                        _that.categoryList   = response.data.category_list;

                    }
                    else{
                        _that.success_message   = "";
                        _that.error_message    = response.data.error;
                    }
                })
        },

        getCategoryDetails()
        {
            let _that   = this;
            let apiUrl  = "admin/categories/";
            axios.get(apiUrl+_that.category_id,
                {
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if (response.data.status_code === 200) {
                        console.log(response.data);
                        _that.categoryDetails         = response.data.category_info;
                        _that.category_name           =  _that.categoryDetails.name;
                        _that.category_parent_id      =  _that.categoryDetails.parent_id;
                        _that.logo_url                =  (_that.categoryDetails.media).length > 0 ? _that.categoryDetails.media[0].url : '';

                    } else {
                        _that.success_message           = "";
                        _that.error_message            = response.data.errors;
                    }
                })
        },

    },

    created(){
        this.category_id = this.categoryId;
        this.getCategoryList();
        this.getCategoryDetails(this.category_id);
    }
}
</script>

<style scoped>

</style>
