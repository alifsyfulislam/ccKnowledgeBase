<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isEditCheck">
        <div class="right-sidebar-content-area px-2">

            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Article Edit</h2>

                <div class="row">
                    <div class="col-md-12">
                        <div class="d-inline-block pr-15">
                            <input type="checkbox" id="checkbox1"  v-model="selected_checkbox" checked disabled>
                            <label for="checkbox1" class="ml-2">English</label>
                        </div>

                        <div class="d-inline-block pr-15">
                            <input type="checkbox" id="checkbox2" v-model="bangla_checkbox" @change="changeCheckBox()">
                            <label for="checkbox2" class="ml-2">Bangla</label>
                        </div>
                    </div>
                </div>

<!--                <select v-model="selected_language" class="form-control col-md-12 mb-20">
                    <option value="english">English</option>
                    <option value="bangla">Bangla</option>
                </select>-->

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
                                <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category.id">
                                    {{a_category.name}}
                                </option>
                            </select>
                            <span id="categoryIDError" class="text-danger small"></span>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="tag" class="d-block">Tag</label>
<!--                            <input class="form-control" type="text" v-model="articleData.tag" id="tag">-->
                            <tag-input-edit class="tag-input-wrapper" v-if="articleData.tag" id="tag" :faqInfo="articleData" @tag-list="collectArticleList"/>
                            <tag-input-edit class="tag-input-wrapper" v-else :faqInfo="articleData" @tag-list="collectArticleList"/>
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

                        <div class="form-group mb-15">
                            <label class="form-label" >Upload Files</label>
                            <input type="file"  id="files" class="form-control" ref="files" multiple @change="fileUploadChange"  >
                        </div>

                    </div>

                    <div class="col-md-12 mb-15" v-if="article_files.length >0">
                        <div class="card">
                            <div class="card-header bg-light-2 px-10 py-1">List of Files</div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item px-10 py-1"
                                    v-for="(file, index) in article_files"
                                    :key="index"
                                >
                                    <a :href="file.url" class="font-12 text-body d-flex justify-content-between align-items-center">
                                        {{ file.name }}
                                        <span class="close-btn" @click="deleteUploadedFile(index)">x</span>
                                    </a>

                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-md-12 mb-15" v-if="previous_media_list.length >0">
                        <div class="card">
                            <div class="card-header bg-light-2 px-10 py-1">List of Previous Files</div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item px-10 py-1"
                                    v-for="(previous_file, prev_index) in previous_media_list" :key="prev_index">
                                        <a href="#" class="font-12 text-body d-flex justify-content-between align-items-center">
                                            {{ previous_file.name }}
                                            <span class="close-btn" @click="deletePreviousUploadedFile(prev_index)">x</span>
                                        </a>
                                </li>
                            </ul>
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
<!--                                <option value="scheduling">Scheduling</option>-->
<!--                                <option value="announcement">Announcement</option>-->
                            </select>
                        </div>
                    </div>

                </div>

                <div class="form-group text-right">
                    <button class="btn common-gradient-btn ripple-btn px-50" @click="validateAndSubmit()">Update</button>
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

    name: "articleEdit.vue",
    components: {
        SummernoteEdit,
        TagInputEdit
    },
    props: ['isEditCheck', 'articleId'],

    data() {
        return {
            isMounted               : false,
            isEdit                  : false,
            enBody                  : "en_Body",
            bnBody                  : "bn_Body",
            selected_language       : 'english',
            category_parent_id      : '',
            category_name           : '',
            selectedCategory        : '',
            categoryList            : '',
            success_message         : '',
            error_message           : '',
            token                   : '',
            articleDetails          : '',
            enBodyData              : '',
            bnBodyData              : '',

            articleData    : {
                category_id         : '',
                id                  :  '',
                en_title            : '',
                bn_title            : '',
                tag                 : '',
                en_short_summary    : '',
                bn_short_summary    : '',
                en_body             : '',
                bn_body             : '',
                status              : 'draft',
            },

            validation_error: {
                isTitleStatus       : true,
                isCategoryStatus    : true,
            } ,

            selected_checkbox    : 1,
            bangla_checkbox      : '',

            fileUrl       : [],
            article_files : [],
            video_files   : '',
            images                  : [],
            files                   : [],
            url                     : '',

            filter      : {
                isAdmin             : 1
            },
            previous_media_list : [],
        }
    },

    methods: {

        deleteUploadedFile(index){
            document.getElementById('files').value= "";
            (this.article_files).splice(index, 1);
        },

        deletePreviousUploadedFile(index){
            //document.getElementById('files').value= "";
            (this.previous_media_list).splice(index, 1);
        },

        fileUploadChange(e) {
            let _that = this;
            const selectedFiles = e.target.files;

            for(var j=0; j<selectedFiles.length; j++){
                // console.log(selectedFiles[j]);
                _that.article_files.push(selectedFiles[j]);
            }

        },

        collectArticleList(tagList){
            this.articleData.tag = tagList.join();
        },

        changeCheckBox() {
            if (this.bangla_checkbox === true)
                this.selected_language = 'bangla';
            else
                this.selected_language = 'english';
        },

        checkAndValidateSelectType()
        {
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

        checkAndChangeValidation(selected_data, selected_id, selected_error_id, selected_name)
        {
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

        validateAndSubmit()
        {
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
                this.articleUpdate();
            }
        },

        showServerError(errors)
        {
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

        articleUpdate()
        {
            let _that           = this;
            let formData        = new FormData();

            for( var i = 0; i < this.article_files.length; i++ ){
                let file = this.article_files[i];

                formData.append('uploaded_file[' + i + ']', file);
            }

            var json_arr = JSON.stringify(this.previous_media_list);
            console.log(json_arr)



            let enBody          = document.getElementById('en_Body').value;

            if (!(document.getElementById('bn_Body'))) {
                var bnBody      = '';
            } else {
                bnBody          = document.getElementById('bn_Body').value;
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
            formData.append('previous_file_list', json_arr);

            axios.post('article/update-data', formData,
                {
                    headers : {
                        'Content-Type'      : 'multipart/form-data',
                        'Authorization'     : 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                if (response.data.status_code === 200){
                    _that.articleData           = '';
                    _that.error_message         = '';
                    _that.success_message       = "Article Updated Successfully";
                    console.log(_that.success_message);

                    _that.$emit('article-edit-close', _that.success_message);
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
            let apiUrl = "articles/";

            axios.get(apiUrl+articleID,
                {
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if (response.data.status_code === 200) {
                        _that.articleDetails          = response.data.article_info;

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

                        console.log(_that.articleDetails);

                        if ((_that.articleDetails.media).length >=0){
                            (_that.articleDetails.media).forEach( aMedia => {
                                var previousMediaTemp = {};

                                var mediaName = (aMedia.url).slice( (aMedia.url).indexOf('_') + 1);

                                previousMediaTemp = {
                                    id   : aMedia.id,
                                    url  : aMedia.url,
                                    name : mediaName
                                };

                                _that.previous_media_list.push(previousMediaTemp);

                            });

                        }
                        console.log( _that.previous_media_list);

                    } else {
                        _that.success_message = "";
                        _that.error_message = response.data.error;
                    }
                })
        },

    },

    created() {
        this.articleData.id = this.articleId;
        this.getArticleDetails();
        this.getCategoryList();
    }
}
</script>

<style scoped>
.font-12 {
    font-size: 12px;
}

.close-btn {
    cursor: pointer;
    background: #ff7b88;
    color: #ffffff;
    width: 18px;
    height: 18px;
    text-align: center;
    line-height: 16px;
    border-radius: 50%;
    text-indent: 1px;
}
</style>
