<template>

    <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isAdd===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                <img src="../../assets/img/cancel.svg" alt="cancel">
            </button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Add New FAQ</h2>

                    <select v-model="selected_language" class="form-control col-md-12 mb-20">
                        <option value="english">English</option>
                        <option value="bangla">Bangla</option>
                    </select>

                    <div class="col-md-12">
                        <div v-if="success_message" class="alert alert-success" role="alert">
                            {{ success_message }}
                        </div>
<!--                        <div v-if="error_messages" class="alert alert-danger" role="alert">-->
<!--                            {{ error_messages }}-->
<!--                        </div>-->
                    </div>

                    <div class="row">

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="enTitle">Title <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="faqData.en_title" id="enTitle" required>
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

                                <select class="form-control" v-model="selectedCategory" id="categoryID">
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
                                <input class="form-control" type="text" v-model="faqData.tag" id="tag">
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group mb-15">
                                <label >English Body</label>
                                <Summernote  v-model="faqData.en_body" :idFromParent="enBody"></Summernote>
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
    </div>

</template>

<script>
import axios from 'axios'

import Summernote from "@/components/summer-note/summernote";
import $ from "jquery";
export default {
    name: "faqAdd.vue",

    props: ['isAddCheck'],
    components: {
        Summernote
    },

    data() {
        return {
            isAdd  : false,
            enBody : "en_Body",
            bnBody : "bn_Body",
            selected_language : 'english',

            success_message : '',
            error_messages   : '',
            token           : '',
            categoryList    : '',
            selectedCategory: '',
            userInfo        : '',

            faqData        : {
                en_title  : '',
                bn_title  : '',
                tag       : '',
                en_body   : '',
                bn_body   : '',
                status    : 'draft',
            },

        }
    },
    methods: {

        showServerError(errors){
            $('#enTitleError').html("");
            $('#categoryIDError').html("");
            $('#enBodyError').html("");

            //
            $('#enTitle').css({'border-color': '#ced4da'});
            $('#categoryID').css({'border-color': '#ced4da'});
            $('#enBody').css({'border-color': '#ced4da'});

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
                    $('#enBody').css({'border-color': '#FF7B88'});
                }
            })
        },

        clearAllChecker() {
            this.isAdd = false;
            this.$emit('faq-data', this.isAdd);
        },

        faqAdd() {

            let _that = this;
            let enBody = document.getElementById('en_Body').value;

            if (!(document.getElementById('bn_Body'))) {
                var bnBody = '';
            } else {
                bnBody  = document.getElementById('bn_Body').value;
            }

            axios.post('admin/faqs', {
                    category_id   : this.selectedCategory,
                    en_title      : this.faqData.en_title,
                    tag           : this.faqData.tag,
                    en_body       : enBody,
                    bn_body       : bnBody,
                    status        : this.faqData.status,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                if (response.data.status_code == 201) {

                    _that.faqData          = '';
                    _that.selectedCategory = '';
                    _that.error_messages    = '';
                    _that.success_message  = "New Faq Added Successfully";
                    _that.isAdd = false;
                    _that.$emit('faq-data', _that.faqData);

                    document.body.classList.remove('open-side-slider')
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
                        _that.error_messages   = response.data.errors;
                    }
                })
        },
    },
    created() {
        this.isAdd = this.isAddCheck;
        this.getCategoryList();
    }
}
</script>

<style scoped>

</style>
