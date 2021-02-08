<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isEditCheck">
        <div class="right-sidebar-content-area px-2">
            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">FAQ Update</h2>

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
                            <tag-input-edit class="tag-input-wrapper" v-if="faqData.tag" id="tag" :faqInfo="faqData" @tag-list="collectTagList"/>
                            <tag-input-edit class="tag-input-wrapper" v-else  :faqInfo="faqData" @tag-list="collectTagList"/>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group mb-15">
                            <label >English Body</label>
                            <div id="enBodyArea" v-bind:class="{ 'rounded border border-danger': isSummerNoteError }">
                                <SummernoteEdit v-if="isMounted"   :idFromParent="enBody" :dataFromParent="enBodyData"></SummernoteEdit>
                            </div>
                            <span id="enBodyError" class="text-danger small"></span>
                        </div>
                    </div>

                    <div class="col-md-12" v-if="selected_language==='bangla'">
                        <div class="form-group mb-15">
                            <label >Bangla Body</label>
                            <SummernoteEdit  :idFromParent="bnBody" :dataFromParent="bnBodyData"></SummernoteEdit>
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
<!--                                <option value="scheduling">Scheduling</option>-->
<!--                                <option value="announcement">Announcement</option>-->
                            </select>
                        </div>
                    </div>

                </div>


                <div class="form-group text-right">
                    <button class="btn common-gradient-btn ripple-btn px-50" @click="faqUpdate()">Update</button>
                </div>
            </div>

        </div>
    </div>
</template>

<script>
import axios from "axios";
import SummernoteEdit from "@/components/summer-note/summernote-edit";
import TagInputEdit from "../tag/TagEditComponent";
import $ from "jquery";

export default {
    name: "faqEdit.vue",
    components: {
        SummernoteEdit,
        TagInputEdit
    },

    props: ['isEditCheck', 'faqId'],

    data() {
        return {
            isMounted           : false,
            enBody              : "en_Body",
            bnBody              : "bn_Body",
            selected_language   : 'english',
            enBodyData          : '',
            bnBodyData          : '',
            success_message     : '',
            error_message       : '',
            token               : '',
            faqDetails          : '',
            faq_id              :  '',
            categoryList        :  '',
            isSummerNoteError   : false,
            selectedCategory    : '',

            selected_checkbox    : '',
            bangla_checkbox      : '',

            faqData      : {
                en_title        : '',
                bn_title        : '',
                tag             : '',
                en_body         : '',
                bn_body         : '',
                status          : '',
            },

            filter      : {
                isAdmin         : 1
            },

            validation_error : {
                isTitleStatus    : true,
                isCategoryStatus : true,
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
                this.faqUpdate();
            }
        },

        showServerError(errors){
            $('#enTitleError').html("");
            $('#categoryIDError').html("");
            $('#enBodyError').html("");
            this.isSummerNoteError = false;

            $('#enTitle').css({'border-color': '#ced4da'});
            $('#categoryID').css({'border-color': '#ced4da'});
            // $('#enBodyArea').css({'border-color': '#ced4da'});

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
                else if (val.includes("en body")==true){
                    $('#enBodyError').html(val)
                    this.isSummerNoteError = true;
                    // $('#enBody').css({'border-color': '#FF7B88'});
                }
            })
        },

        faqUpdate() {
            let _that           = this;
            let faqID           = this.faq_id;
            let enBody          = document.getElementById('en_Body').value;

            if (!(document.getElementById('bn_Body'))) {
                var bnBody      = '';
            } else {
                bnBody          = document.getElementById('bn_Body').value;
            }

            axios.put('faqs/update',
                {
                    id              : faqID,
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

                if (response.data.status_code == 200) {
                    _that.faqData               = '';
                    _that.selectedCategory      = '';
                    _that.error_message         = '';
                    _that.success_message       = "Faq Updated Successfully";

                    _that.$emit('faq-slide-close', _that.success_message);
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

        getFaqDetails(faq_id) {
            let _that = this;

            let apiUrl = "faqs/";

            axios.get(apiUrl+faq_id,
                {
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if (response.data.status_code === 200) {
                        //console.log(response.data);

                        _that.faqDetails            = response.data.faq_info;
                        _that.selectedCategory      = _that.faqDetails.category_id;
                        _that.faqData.en_title      = _that.faqDetails.en_title;
                        _that.faqData.bn_title      = _that.faqDetails.bn_title;
                        _that.faqData.tag           = _that.faqDetails.tag;
                        _that.faqData.en_body       = _that.faqDetails.en_body;
                        _that.faqData.bn_body       = _that.faqDetails.bn_body;
                        _that.faqData.status        = _that.faqDetails.status;

                        _that.enBodyData            = _that.faqDetails.en_body;
                        _that.bnBodyData            = _that.faqDetails.bn_body;
                        _that.isMounted             = true;
                        //console.log('enBody', + _that.enBodyData);

                    } else {
                        _that.success_message = "";
                        _that.error_message = response.data.error;
                    }
                })
        },

        getCategoryList(){

            let _that =this;

            axios.get('categories',
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
                        //console.log(response.data);
                        _that.categoryList = response.data.category_list;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

    },

    created() {
        this.faq_id = this.faqId;
        this.getFaqDetails(this.faq_id);
        this.getCategoryList();
    }
}
</script>

<style scoped>

</style>
