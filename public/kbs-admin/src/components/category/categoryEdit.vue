<template>

    <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isEdit===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                <img src="../../assets/img/cancel.svg" alt="cancel">
            </button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Edit Category</h2>

                    <div class="col-md-12">
                        <div v-if="success_message" class="alert alert-success" role="alert">
                            {{ success_message }}
                        </div>
                    </div>

                    <div class="row">

                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="categoryName">Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="category_name" id="categoryName" required>
                                <small v-if="error_messages.length>0" id="categoryNameError" class="small text-danger category_name" role="alert">
                                    {{ error_messages[0] }}
                                </small>
                            </div>
                        </div>
                    </div>

                    <div class="form-group text-right">
                        <button class="btn common-gradient-btn ripple-btn px-50" @click="dataValidate()">Update</button>
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

    name: "categoryEdit.vue",
    props: ['isEditCheck', 'categoryId'],

    data() {
        return {
            isEdit : false,

            category_id : '',
            category_parent_id : '',

            category_name   : '',
            categoryDetails : '',
            categoryList    : '',
            success_message : '',
            error_messages   : [],
            token           : '',
        }
    },

    methods: {

        clearAllChecker()
        {
            this.isEdit = false;
            this.$emit('category-edit-data', this.isEdit);
        },
        showServerError(errors){
            $('#categoryNameError').html("");
            $('#categoryName').css({'border-color': '#ced4da'});
            errors.forEach(val=>{
                if (val.includes("name")==true){
                    $('#categoryNameError').html(val)
                    $('#categoryName').css({'border-color': '#FF7B88'});
                }
            })
        },

        dataValidate(){
            let _that = this;
            // _that.categoryUpdate();
            if (!_that.category_name){
                _that.error_messages[0] = "*The category name is required";
            }
            else if (_that.category_name && (_that.category_name).length >2 && (_that.category_name).length <100){
                _that.categoryUpdate();
            }
            else{
                _that.error_messages[0] = "*The name must be between 3 to 100 charecter";
            }
        },

        categoryUpdate() {

            let _that = this;

            axios.put('admin/categories/update', {
                    id        : this.category_id,
                    name      : this.category_name,
                    parent_id : this.category_parent_id,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                console.log(response)
                if (response.data.status_code == 200) {

                    _that.error_messages    = '';
                    _that.success_message  = response.data.messages;
                    _that.isEdit = false;
                    _that.$emit('category-edit-data',"category updated successfully");
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

        getCategoryList()
        {
            let _that =this;

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
                        console.log(response.data);
                        _that.categoryList = response.data.category_list;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_messages   = response.data.error;
                    }
                })
        },

        getCategoryDetails() {

            let _that = this;
            let categoryID = this.category_id;
            console.log("article Id " + categoryID);
            let apiUrl = "admin/categories/";

            axios.get(apiUrl+categoryID,
                {
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if (response.data.status_code === 200) {
                        console.log(response.data);
                        _that.categoryDetails       = response.data.category_info;

                        _that.category_name =  _that.categoryDetails.name;
                        _that.category_parent_id =  _that.categoryDetails.parent_id;

                    } else {
                        _that.success_message = "";
                        _that.error_messages = response.data.errors;
                    }
                })
        },

    },

    created() {

        this.category_id = this.categoryId;
        console.log("category_id" + this.category_id);
        this.getCategoryDetails();
        this.getCategoryList();
        this.isEdit = this.isEditCheck;
        console.log(this.isEditCheck)

    }
}
</script>

<style scoped>

</style>
