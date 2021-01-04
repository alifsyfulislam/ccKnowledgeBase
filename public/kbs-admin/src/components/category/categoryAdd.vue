<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isAddCheck">
        <div class="right-sidebar-content-area px-2">
            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Add New Category</h2>

                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="categoryName">Name <span class="required">*</span></label>
                            <input class="form-control" type="text" v-model="categoryData.name" id="categoryName" placeholder="Enter Category Name" required>
                            <small v-if="error_messages.length>0" id="categoryNameError" class="small text-danger category_name" role="alert">
                                {{ error_messages[0] }}
                            </small>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Select A Parent</label>
                            <select class="form-control" v-model="selectedCategory">
                                <option value="">Select A Category</option>
                                <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                                    {{a_category.name}}
                                </option>
                            </select>
                        </div>
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
import axios from 'axios'
import $ from "jquery";

export default {
    name: "categoryAddII.vue",
    props: ['isAddCheck'],
    data() {
        return {
            success_message : '',
            error_messages   : [],
            token           : '',
            categoryList    : '',
            selectedCategory  : '',
            userInfo        : '',
            categoryData        : {
                name  : '',
            },
        }
    },
    methods: {
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
                _that.error_messages[0] = "*The category name is required";
            }
            else if (_that.categoryData.name && (_that.categoryData.name).length >2 && (_that.categoryData.name).length <100){
                _that.categoryAdd();
            }
            else{
                _that.error_messages[0] = "*The name must be between 3 to 100 charecter";
            }
        },
        //category add
        categoryAdd()
        {
            let _that = this;
            axios.post('admin/categories', {

                    name      : this.categoryData.name,
                    parent_id : this.selectedCategory,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                console.log(response)
                if (response.data.status_code == 200)
                {
                    _that.categoryData     = '';
                    _that.selectedCategory = '';
                    _that.error_messages    = '';
                    _that.success_message  = "Category Added Successfully";
                    _that.$emit('category-slide-close', _that.success_message);
                    document.body.classList.remove('open-side-slider');

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
    },
    created() {
        this.getCategoryList();
    }
}
</script>

<style scoped>

</style>
