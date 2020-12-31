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
                    <h2 class="section-title text-uppercase mb-20">FAQ Update</h2>

                    <select v-model="selected_language" class="form-control col-md-12 mb-20">
                        <option value="english">English</option>
                        <option value="bangla">Bangla</option>
                    </select>

                    <div class="col-md-12">
                        <div v-if="success_message" class="alert alert-success" role="alert">
                            {{ success_message }}
                        </div>
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
    </div>
</template>

<script>
import axios from "axios";
import SummernoteEdit from "@/components/summer-note/summernote-edit";
import $ from "jquery";

export default {
    name: "faqEdit.vue",
    components: {
        SummernoteEdit
    },

    props: ['isEditCheck', 'faqId'],

    data() {
        return {
            isMounted : false,
            isEdit : false,
            enBody : "en_Body",
            bnBody : "bn_Body",
            selected_language  : 'english',

            enBodyData : '',
            bnBodyData : '',

            success_message : '',
            error_message   : '',
            token           : '',
            faqDetails      : '',
            faq_id          :  '',
            categoryList    :  '',
            isSummerNoteError: false,

            selectedCategory  : '',
            faqData        : {
                en_title  : '',
                bn_title  : '',
                tag  : '',
                en_body  : '',
                bn_body  : '',
                status  : '',
            },
            filter : {
                isAdmin : 1
            }
        }
    },

    methods: {
        showServerError(errors){
            $('#enTitleError').html("");
            $('#categoryIDError').html("");
            $('#enBodyError').html("");
            this.isSummerNoteError = false;

            //
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

        clearAllChecker()
        {
            this.isEdit = false;
            this.$emit('faq-edit-data', this.isEdit);
        },

        faqUpdate() {
            let _that = this;
            let faqID = this.faq_id;
            let enBody = document.getElementById('en_Body').value;

            if (!(document.getElementById('bn_Body'))) {
                var bnBody = '';
            } else {
                bnBody  = document.getElementById('bn_Body').value;
            }

            axios.put('admin/faqs/update',
                {
                    id            : faqID,
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
                if (response.data.status_code == 200) {
                    _that.faqData          = '';
                    _that.selectedCategory = '';
                    _that.error_message    = '';
                    _that.success_message  = "Faq Updated Successfully";

                    _that.isEdit = false;
                    _that.$emit('faq-edit-data', "Faq Updated Successfully");
                    document.body.classList.remove('open-side-slider')
                }
                else
                {
                    _that.success_message = "";
                    _that.error_message   = response.data.errors;
                    _that.showServerError(response.data.errors);
                }

            }).catch(function (error) {
                console.log(error);
            });
        },

        getFaqDetails() {
            let _that = this;
            let faqID = this.faq_id;

            let apiUrl = "admin/faqs/";

            axios.get(apiUrl+faqID,
                {
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if (response.data.status_code === 200) {
                        //console.log(response.data);
                        _that.faqDetails       = response.data.faq_info;

                        _that.selectedCategory  = _that.faqDetails.category_id;
                        _that.faqData.en_title  = _that.faqDetails.en_title;
                        _that.faqData.bn_title  = _that.faqDetails.bn_title;
                        _that.faqData.tag       = _that.faqDetails.tag;
                        _that.faqData.en_body   = _that.faqDetails.en_body;
                        _that.faqData.bn_body   = _that.faqDetails.bn_body;
                        _that.faqData.status    = _that.faqDetails.status;

                        _that.enBodyData        = _that.faqDetails.en_body;
                        _that.bnBodyData        = _that.faqDetails.bn_body;
                        _that.isMounted         = true;

                        //console.log('enBody', + _that.enBodyData);

                    } else {
                        _that.success_message = "";
                        _that.error_message = response.data.error;
                    }
                })
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

        // console.log("faq_id" + this.faq_id);
        this.getFaqDetails();
        this.getCategoryList();
        this.isEdit = this.isEditCheck;

    }
}
</script>

<style scoped>

</style>
