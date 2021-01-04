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
                    <h2 class="section-title text-uppercase mb-20">Article Edit</h2>
                    <select v-model="selected_language" class="form-control col-md-12 mb-20">
                        <option value="english">English</option>
                        <option value="bangla">Bangla</option>
                    </select>

                    <div class="col-md-12">
                        <div v-if="success_message" class="alert alert-success" role="alert">
                            {{ success_message }}
                        </div>
                        <div v-if="error_message" class="alert alert-danger" role="alert">
                            {{ error_message }}
                        </div>
                    </div>

                    <div class="row">

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="enTitle">Title <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="articleData.en_title" id="enTitle" @keyup="checkAndChangeValidation(articleData.en_title, '#enTitle', '#enTitleError', '*title')" required>
                                <span id="enTitleError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-6" v-if="selected_language==='bangla'">
                            <div class="form-group">
                                <label>Bangla Title </label>
                                <input class="form-control" type="text" v-model="articleData.bn_title" >
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="categoryID">Category <span class="required">*</span></label>

                                <select class="form-control" v-model="articleData.category_id" id="categoryID" @change="checkAndValidateSelectType()">
                                    <option value="" disabled>Select A Category</option>
                                    <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                                        {{a_category.name}}
                                    </option>
                                </select>
                                <span id="categoryIDError" class="text-danger small"></span>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="tag">Tag</label>
                                <input class="form-control" type="text" v-model="articleData.tag" id="tag">
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group mb-15">
                                <label>English Short Summary</label>
                                <textarea  cols="30" rows="4" class="form-control" v-model="articleData.en_short_summary"></textarea>
                            </div>
                        </div>
                        <div class="col-md-12" v-if="selected_language=='bangla'">
                            <div class="form-group mb-15">
                                <label for="bn_short_summary">Bangla Short Summary</label>
                                <textarea cols="30" rows="4" class="form-control " v-model="articleData.bn_short_summary" id="bn_short_summary"></textarea>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group mb-15">
                                <label >English Body</label>
                                <SummernoteEdit v-if="isMounted"   :idFromParent="enBody" :dataFromParent="enBodyData"></SummernoteEdit>

                            </div>
                        </div>

                        <div class="col-md-12" v-if="selected_language=='bangla'">
                            <div class="form-group mb-15">
                                <label >Bangla Body</label>
                                <SummernoteEdit  :idFromParent="bnBody" :dataFromParent="bnBodyData"></SummernoteEdit>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Select A Status</label>
                                <select class="form-control" v-model="articleData.status">
                                    <option value="draft">Draft</option>
                                    <option value="hide">Hide</option>
                                    <option value="private">Private</option>
                                    <option value="public">Public</option>
                                </select>
                            </div>
                        </div>

                    </div>


                    <div class="form-group text-right">
                        <button class="btn common-gradient-btn ripple-btn px-50" @click="articleUpdate()">Update</button>
                    </div>
                </div>

            </div>
        </div>
    </div>

</template>

<script>

import axios from "axios";
import SummernoteEdit from "@/components/summer-note/summernote-edit";
import $ from "jquery";

export default {

    name: "articleEdit.vue",
    components: {
        SummernoteEdit
    },
    props: ['isEditCheck', 'articleId'],

    data() {
        return {
            isMounted : false,
            isEdit : false,
            enBody : "en_Body",
            bnBody : "bn_Body",
            selected_language  : 'english',
            category_parent_id : '',
            category_name   : '',
            selectedCategory : '',
            categoryList    : '',
            success_message : '',
            error_message   : '',
            token           : '',
            articleDetails  : '',

            enBodyData : '',
            bnBodyData : '',

            articleData     : {

                category_id : '',
                id :  '',
                en_title  : '',
                bn_title  : '',
                tag  : '',
                en_short_summary  : '',
                bn_short_summary  : '',
                en_body  : '',
                bn_body  : '',
                status  : 'draft',

            },

            validation_error :{
                isTitleStatus    : false,
                isCategoryStatus : false,
            } ,

            images: [],
            files: [],
            url : '',

            filter : {
                isAdmin : 1
            }
        }
    },

    methods: {

        clearAllChecker() {
            this.isEdit = false;
            this.$emit('article-edit-data', this.isEdit);
        },

        checkAndValidateSelectType(){

            if (!this.articleData.category_id) {
                $('#categoryID').css({
                    'border-color': '#FF7B88',
                });
                $('#categoryIDError').html("category field is required");
                this.validation_error.isCategoryStatus = false;

            } else{
                $('#categoryID').css({
                    'border-color': '#ced4da',
                });
                $('#categoryIDError').html("");
                this.validation_error.isCategoryStatus = true;
            }
        },

        checkAndChangeValidation(selected_data, selected_id, selected_error_id, selected_name) {

            if (selected_data.length >0) {
                if (selected_data.length <3){
                    $(selected_id).css({
                        'border-color': '#FF7B88',
                    });
                    $(selected_error_id).html( selected_name+" should contain minimum 3 character");

                    if (selected_name === "*title"){
                        this.validation_error.isTitleStatus = false;
                    }

                }else {
                    $(selected_id).css({
                        'border-color': '#ced4da',
                    });
                    $(selected_error_id).html("");

                    if (selected_name === "*title" ){
                        this.validation_error.isTitleStatus = true;
                    }
                }

            } else{
                $(selected_id).css({
                    'border-color': '#FF7B88',
                });
                $(selected_error_id).html(selected_name+" field is required")

                if (selected_name === "title" ){
                    this.validation_error.isTitleStatus = false;
                }
            }
        },

        validateAndSubmit(){

            if (!this.articleData.en_title){
                $('#enTitle').css({
                    'border-color': '#FF7B88',
                });
                $('#enTitleError').html("title field is required");
            }

            if (!this.articleData.category_id){
                $('#categoryID').css({
                    'border-color': '#FF7B88',
                });
                $('#categoryIDError').html("category field is required");
            }

            if (this.validation_error.isTitleStatus    === true &&
                this.validation_error.isCategoryStatus === true ){
                //console.log(this.validation_error)
                this.articleUpdate();
            }
        },

        showServerError(errors){

            $('#enTitleError').html("");
            $('#categoryIDError').html("");

            $('#enTitle').css({'border-color': '#ced4da'});
            $('#categoryID').css({'border-color': '#ced4da'});

            errors.forEach(val=>{
                console.log(val);
                if (val.includes("en title")==true){
                    $('#enTitleError').html(val)
                    $('#enTitle').css({'border-color': '#FF7B88'});
                }
                else if (val.includes("category")==true){
                    $('#categoryIDError').html(val)
                    $('#categoryID').css({'border-color': '#FF7B88'});
                }

            })
        },

        articleUpdate() {

            let _that = this;
            let formData = new FormData();
            let enBody = document.getElementById('en_Body').value;

            if (!(document.getElementById('bn_Body'))) {
                var bnBody = '';
            } else {
                bnBody  = document.getElementById('bn_Body').value;
            }

            formData.append('id', this.articleData.id);
            formData.append('category_id', this.articleData.category_id);
            formData.append('en_title', this.articleData.en_title);
            formData.append('bn_title', this.articleData.bn_title);
            formData.append('tag', this.articleData.tag);
            formData.append('en_short_summary', this.articleData.en_short_summary);
            formData.append('bn_short_summary', this.articleData.bn_short_summary);
            formData.append('en_body', enBody);
            formData.append('bn_body', bnBody);
            formData.append('status', this.articleData.status);

            console.log(formData)

            axios.post('admin/article/update-data', formData,
                {
                    headers: {
                        'Content-Type': 'multipart/form-data',
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {

                if (response.data.status_code == 200){
                    _that.articleData      = '';
                    _that.error_message    = '';
                    _that.success_message  = "Article Updated Successfully";
                    _that.isEdit = false;
                    _that.$emit('article-edit-data', _that.articleData);
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

        getCategoryList() {

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
                        _that.error_message   = response.data.error;
                    }
                })
        },

        getArticleDetails() {

            let _that = this;
            let articleID = this.articleData.id;
            console.log("article Id " + articleID);
            let apiUrl = "admin/articles/";

            axios.get(apiUrl+articleID,
                {
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if (response.data.status_code === 200) {
                        console.log(response.data);
                        _that.articleDetails       = response.data.article_info;

                        _that.articleData.category_id =  _that.articleDetails.category_id;

                        _that.articleData.en_title  =  _that.articleDetails.en_title;
                        _that.articleData.bn_title  =  _that.articleDetails.bn_title;
                        _that.articleData.tag       =  _that.articleDetails.tag;
                        _that.articleData.en_short_summary =  _that.articleDetails.en_short_summary;
                        _that.articleData.bn_short_summary =  _that.articleDetails.bn_short_summary;
                        _that.articleData.en_body   =  _that.articleDetails.en_body;
                        _that.articleData.bn_body   =  _that.articleDetails.bn_body;
                        _that.articleData.status    =  _that.articleDetails.status;

                        _that.enBodyData  = _that.articleData.en_body;
                        _that.bnBodyData  = _that.articleData.bn_body;
                        _that.isMounted   = true;

                        console.log('enBody',  + _that.enBodyData);

                    } else {
                        _that.success_message = "";
                        _that.error_message = response.data.error;
                    }
                })
        },

    },

    created() {
        this.articleData.id = this.articleId;

        console.log("article_id" + this.articleId);
        this.getArticleDetails();
        this.getCategoryList();
        this.isEdit = this.isEditCheck;


        console.log(this.isEditCheck)

    }
}
</script>

<style scoped>

</style>
