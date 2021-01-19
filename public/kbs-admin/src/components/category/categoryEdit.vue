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
                                <option value="">Select A Category</option>
                                <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                                    {{a_category.name}}
                                </option>
                            </select>
                            <span  id="categoryParentError" class="small text-danger category_parent_id" role="alert"></span>
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
            category_id             : '',
            category_parent_id      : '',
            category_name           : '',
            categoryDetails         : '',
            tempCategoryList        : '',
            categoryList            : [],
            error_message           : '',
            success_message         : '',
            token                   : '',
        }
    },

    methods: {

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

           /* if (!_that.category_name){
                _that.error_messages[0]     = "*The category name is required";
            }
            else if (_that.category_name && (_that.category_name).length >2 && (_that.category_name).length <100){
                _that.categoryUpdate();
            }
            else{
                _that.error_messages[0]     = "*The name must be between 3 to 100 charecter";
            }*/
        },

        categoryUpdate()
        {
            let _that = this;

            axios.put('admin/categories/update', {
                    id              : this.categoryDetails.id,
                    name            : this.category_name,
                    parent_id       : this.category_parent_id,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                    console.log(response);

                if (response.data.status_code === 200){
                    _that.category_name             = '',
                    _that.category_parent_id        = '',
                    _that.error_message            = '';
                    _that.success_message           = "Category Updated Successfully";
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
            axios.get('admin/categories',
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin : 1,
                            without_pagination : 1
                        },
                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        _that.tempCategoryList   = response.data.category_list;

                        _that.tempCategoryList.forEach(aCategory => {

                            if (aCategory.id!= _that.category_id && aCategory.parent_id!=_that.category_id ){
                                _that.categoryList.push(aCategory);
                            }
                        })
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
                        _that.categoryDetails           = response.data.category_info;
                        _that.category_name             =  _that.categoryDetails.name;

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
