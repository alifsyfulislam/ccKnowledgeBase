<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isAddCheck">
        <div class="right-sidebar-content-area px-2">
            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Add New Article</h2>

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

                    <div class="col-md-6" v-if="selected_language=='bangla'">
                        <div class="form-group">
                            <label>Bangla Title </label>
                            <input class="form-control" type="text" v-model="articleData.bn_title">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="categoryID">Category <span class="required">*</span></label>

                            <select class="form-control" v-model="selectedCategory" id="categoryID" @change="checkAndValidateSelectType()">
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
                            <tag-input id="tag" class="tag-input-wrapper" @tag-list="collectArticleList"/>
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
                            <Summernote  v-model="articleData.en_body" :idFromParent="enBody" ></Summernote>

                        </div>
                    </div>

                    <div class="col-md-12" v-if="selected_language=='bangla'">
                        <div class="form-group mb-15">
                            <label >Bangla Body</label>
                            <Summernote   v-model="articleData.bn_body" :idFromParent="bnBody" ></Summernote>
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
                    <button class="btn common-gradient-btn ripple-btn px-50" @click="validateAndSubmit()">Add</button>
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
// import "@/jquery.fileupload.js";


export default {
    name: "articleAdd.vue",
    props: ['isAddCheck'],
    components: {
        Summernote,
        TagInput
    },
    data() {
        return {
            checked :true,
            enBody                  : "en_Body",
            bnBody                  : "bn_Body",
            selected_language       : 'english',
            success_message         : '',
            error_message           : '',
            token                   : '',
            categoryList            : '',
            selectedCategory        : '',
            userInfo                : '',

            articleData : {
                en_title            : '',
                bn_title            : '',
                tag                 : '',
                en_short_summary    : '',
                bn_short_summary    : '',
                en_body             : '',
                bn_body             : '',
                status              : 'draft',
            },

            validation_error : {
                isTitleStatus       : false,
                isCategoryStatus    : false,
            },

            selected_checkbox    : 1,
            bangla_checkbox      : '',

            fileUrl       : [],
            article_files : [],
            url           : '',
            video_files   : ''
        }
    },
    methods: {

        deleteUploadedFile(index){
            document.getElementById('files').value= "";
            (this.article_files).splice(index, 1);
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

        validateAndSubmit(){

            if (!this.articleData.en_title){
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
                this.articleAdd();
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

        articleAdd()
        {

            let _that       = this;
            let formData    = new FormData();

            for( var i = 0; i < this.article_files.length; i++ ){
                let file = this.article_files[i];

                formData.append('uploaded_file[' + i + ']', file);
            }

            let enBody      = document.getElementById('en_Body').value;

            if (!(document.getElementById('bn_Body'))) {
                var bnBody  = '';
            } else {
                bnBody      = document.getElementById('bn_Body').value;
            }
            formData.append('category_id', this.selectedCategory);
            formData.append('en_title', this.articleData.en_title);
            formData.append('bn_title', this.articleData.bn_title);
            formData.append('tag', this.articleData.tag);
            formData.append('en_short_summary', this.articleData.en_short_summary);
            formData.append('bn_short_summary', this.articleData.bn_short_summary);
            formData.append('en_body', enBody);
            formData.append('bn_body', bnBody);
            formData.append('status', this.articleData.status);

            axios.post('articles', formData,
                {
                    headers: {
                        'Content-Type'  : 'multipart/form-data',
                        'Authorization' : 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {

                if (response.data.status_code === 201) {
                    _that.articleData           = '';
                    _that.selectedCategory      = '';
                    _that.error_message         = '';
                    _that.success_message       = "Article Added Successfully";
                    _that.$emit('article-slide-close', _that.success_message);
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
                        console.log(response.data);
                        _that.categoryList = response.data.category_list;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

    },
    created()
    {
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
