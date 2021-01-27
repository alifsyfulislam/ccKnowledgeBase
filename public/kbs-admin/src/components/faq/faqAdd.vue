<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isAddCheck">
        <div class="right-sidebar-content-area px-2">
            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Add New FAQ</h2>

                <div class="row">
                    <div class="col-md-12">
                        <div class="d-inline-block pr-15">
                            <input type="checkbox" id="checkbox1"  v-model="selected_checkbox" checked disabled>
                            <label for="checkbox1" class="ml-2">English</label>
                        </div>

                        <div class="d-inline-block">
                            <input type="checkbox" id="checkbox2" v-model="bangla_checkbox" @change="changeCheckBox()">
                            <label for="checkbox2" class="ml-2">Bangla</label>
                        </div>
                    </div>
                </div>

                <div class="row">

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="enTitle">Title <span class="required">*</span></label>
                            <input class="form-control" type="text" v-model="faqData.en_title" id="enTitle" @keyup="checkAndChangeValidation(faqData.en_title, '#enTitle', '#enTitleError', '*title')" required>
                            <span id="enTitleError" class="text-danger small"></span>
                        </div>
                    </div>

                    <div class="col-md-6" v-if="selected_language==='bangla'">
                        <div class="form-group">
                            <label>Bangla Title </label>
                            <input class="form-control" type="text" v-model="faqData.bn_title" >
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Category <span class="required">*</span></label>

                            <select class="form-control" v-model="selectedCategory" id="categoryID" @change="checkAndValidateSelectType()">
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
                            <label for="tag" class="d-block">Tag</label>
                            <!-- <input class="form-control" type="text" v-model="faqData.tag" id="tag"> -->
                            <tag-input id="tag" class="tag-input-wrapper" @tag-list="collectTagList"/>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group mb-15">
                            <label >English Body</label>
                            <div id="enBodyArea" class="border" v-bind:class="{ 'rounded border-danger': isSummerNoteError }">
                                <Summernote  v-model="faqData.en_body" :idFromParent="enBody"></Summernote>
                            </div>
                            <span id="enBodyError" class="text-danger small"></span>
                        </div>
                    </div>

                    <div class="col-md-12" v-if="selected_language=='bangla'">
                        <div class="form-group mb-15">
                            <label >Bangla Body</label>
                            <Summernote   v-model="faqData.bn_body" :idFromParent="bnBody" ></Summernote>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Select A Status</label>
                            <select class="form-control" v-model="faqData.status">
                                <option value="draft">Draft</option>
                                <option value="hide">Hide</option>
                                <option value="private">Private</option>
                                <option value="public">Public</option>
                                <option value="scheduling">Scheduling</option>
                                <option value="announcement">Announcement</option>
                            </select>
                        </div>
                    </div>

                </div>


                <div class="form-group text-right">
                    <button class="btn common-gradient-btn ripple-btn px-50" @click="faqAdd()">Add</button>
                </div>
            </div>

        </div>
    </div>
</template>

<script>
import axios from 'axios'

import Summernote from "@/components/summer-note/summernote";
import TagInput from "../tag/TagComponent";
import $ from "jquery";
export default {
    name: "faqAdd.vue",

    props: ['isAddCheck'],
    components: {
        Summernote,
        TagInput
    },

    data() {
        return {
            enBody              : "en_Body",
            bnBody              : "bn_Body",
            selected_language   : 'english',

            success_message     : '',
            error_messages      : '',
            token               : '',
            categoryList        : '',
            selectedCategory    : '',
            userInfo            : '',
            isSummerNoteError   : false,

            selected_checkbox    : '',
            bangla_checkbox      : '',

            faqData      : {

                en_title        : '',
                bn_title        : '',
                tag             : '',
                en_body         : '',
                bn_body         : '',
                status          : 'draft'
            },

            validation_error : {
                isTitleStatus    : false,
                isCategoryStatus : false,
            },
        }
    },
    methods: {
        collectTagList(tagList){
            this.faqData.tag = tagList.join();
        },

        changeCheckBox() {
            if (this.bangla_checkbox === true)
                this.selected_language = 'bangla';
            else
                this.selected_language = 'english';
        },

        checkAndValidateSelectType(){

            if (!this.selectedCategory) {
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

        checkAndChangeValidation(selected_data, selected_id, selected_error_id, selected_name){

            if (selected_data.length >0){

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

            if (!this.faqData.en_title){
                $('#enTitle').css({
                    'border-color': '#FF7B88',
                });
                $('#enTitleError').html("title field is required");
            }

            if (!this.selectedCategory){
                $('#categoryID').css({
                    'border-color': '#FF7B88',
                });
                $('#categoryIDError').html("category field is required");
            }

            if (this.validation_error.isTitleStatus    === true &&
                this.validation_error.isCategoryStatus === true ){
                this.faqAdd();
            }
        },

        showServerError(errors){

            $('#enTitleError').html("");
            $('#categoryIDError').html("");
            $('#enBodyError').html("");

            $('#enTitle').css({'border-color': '#ced4da'});
            $('#categoryID').css({'border-color': '#ced4da'});

            this.isSummerNoteError = false;
            errors.forEach(val => {
                if (val.includes("en title")==true){
                    $('#enTitleError').html(val)
                    $('#enTitle').css({'border-color': '#FF7B88'});
                }
                else if (val.includes("category")==true){
                    $('#categoryIDError').html(val)
                    $('#categoryID').css({'border-color': '#FF7B88'});
                }
                else if (val.includes("en body")==true){
                    $('#enBodyError').html(val);
                    this.isSummerNoteError = true;
                }
            })
        },

        faqAdd()
        {
            let _that           = this;
            let enBody          = document.getElementById('en_Body').value;

            if (!(document.getElementById('bn_Body'))) {
                var bnBody      = '';
            } else {
                bnBody          = document.getElementById('bn_Body').value;
            }

            axios.post('admin/faqs', {
                    category_id     : this.selectedCategory,
                    en_title        : this.faqData.en_title,
                    tag             : this.faqData.tag,
                    en_body         : enBody,
                    bn_body         : bnBody,
                    status          : this.faqData.status,
                },
                {
                    headers : {
                        'Authorization'     : 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                if (response.data.status_code == 201) {
                    _that.faqData                   = '';
                    _that.error_message             = '';
                    _that.success_message           = "FAQ Added Successfully";

                    _that.$emit('faq-slide-close', _that.success_message);
                } else {
                    _that.success_message = "";
                    _that.error_messages   = response.data.errors;
                    _that.showServerError(response.data.errors);
                }
            }).catch(function (error) {
                console.log(error);
            });
        },

        getCategoryList(){

            let _that   = this;

            axios.get('admin/categories',
                {
                    headers     : {
                        'Authorization'         : 'Bearer '+localStorage.getItem('authToken')
                    },
                    params      :
                        {
                            isAdmin             : 1,
                            without_pagination  : 1
                        },

                })
                .then(function (response) {
                    if(response.data.status_code === 200) {
                        _that.categoryList          = response.data.category_list;
                    }
                    else{
                        _that.success_message       = "";
                        _that.error_messages        = response.data.errors;
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
