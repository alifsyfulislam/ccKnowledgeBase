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
                    <h2 class="section-title text-uppercase mb-20">Quiz Edit</h2>

                    <div class="col-md-12">
                        <div v-if="success_message" class="alert alert-success" role="alert">
                            {{ success_message }}
                        </div>
                        <div v-if="error_message" class="alert alert-danger" role="alert">
                            {{ error_message }}
                        </div>
                    </div>

                    <div class="row">

                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="title">Title <span class="required">*</span></label>
                                <input type="text" class="form-control" v-model="quizData.name" id="title" placeholder="Enter Quiz Title" required>
                                <span id="titleError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Select Quiz Form</label>

                                <select class="form-control" id="quizForm" v-model="quizData.quiz_form_id">
                                    <option value="" disabled>Select A Quiz Form</option>
                                    <option v-for="a_quiz_form in quizformList" :value="a_quiz_form.id" :key="a_quiz_form">
                                        {{a_quiz_form.name}}
                                    </option>
                                </select>
                                <span id="quizFormError" class="text-danger small"></span>

                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="duration">Duration (Minutes)</label>
                                <input type="number" class="form-control" v-model="quizData.duration"  id="duration" placeholder="Ex : 30">
                                <span id="durationError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="totalMarks">Total Marks<span class="required">*</span></label>
                                <input type="number" class="form-control " v-model="quizData.total_marks" id="totalMarks" placeholder="Ex : 100">
                                <span id="totalMarksError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="numberOfQuestions">Number Of Questions<span class="required">*</span></label>
                                <input type="number" class="form-control" v-model="quizData.number_of_questions" id="numberOfQuestions" placeholder="Ex : 10">
                                <span id="numberOfQuestionsError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Select Quiz Form</label>

                                <select class="form-control" v-model="quizData.status">
                                    <option value="" disabled>Select A Status</option>
                                    <option value="0">Inactive</option>
                                    <option value="1">Active</option>
                                </select>
                            </div>

                        </div>

                    </div>

                    <div class="form-group text-right">
                        <button class="btn common-gradient-btn ripple-btn px-50" @click="quizUpdate()">Update</button>
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
    name: "quizEdit",
    props: ['isEditCheck', 'quizId'],

    data() {
        return {
            success_message : '',
            error_message   : '',
            token           : '',
            articleList     : '',
            quizformList    : '',

            quiz_id         : '',
            quizDetails     : '',

            quizData        :
                {
                    name          : '',
                    article_id    : '',
                    quiz_form_id  : '',
                    duration      : '',
                    total_marks   : '',
                    status        : '',
                    number_of_questions   : '',
                },
        }
    },

    methods: {

        clearAllChecker() {

            this.isEdit = false;
            this.$emit('quiz-edit-data', this.isEdit);

        },

        showServerError(errors){

            $('#titleError').html("");
            $('#quizFormError').html("");
            $('#durationError').html("");
            $('#totalMarksError').html("");
            $('#numberOfQuestionsError').html("");

            $('#title').css({'border-color': '#ced4da'});
            $('#quizForm').css({'border-color': '#ced4da'});
            $('#duration').css({'border-color': '#ced4da'});
            $('#totalMarks').css({'border-color': '#ced4da'});
            $('#numberOfQuestions').css({'border-color': '#ced4da'});

            errors.forEach(val=>{

                if (val.includes("name") === true){

                    $('#titleError').html(val)
                    $('#title').css({'border-color': '#FF7B88'});
                }else if(val.includes("quiz form") === true){
                    $('#quizFormError').html(val)
                    $('#quizForm').css({'border-color': '#FF7B88'});

                }else if(val.includes("duration") === true){
                    $('#durationError').html(val)
                    $('#duration').css({'border-color': '#FF7B88'});

                }else if(val.includes("total marks") === true){
                    $('#totalMarksError').html(val)
                    $('#totalMarks').css({'border-color': '#FF7B88'});

                }else if(val.includes("number of questions") === true){
                    $('#numberOfQuestionsError').html(val)
                    $('#numberOfQuestions').css({'border-color': '#FF7B88'});
                }


            })
        },

        quizUpdate() {

            let _that = this;
            let quizID = this.quiz_id;

            axios.put('admin/quizzes/update',
                {
                    id            : quizID,
                   // article_id    : this.quizData.article_id,
                    name          : this.quizData.name,
                    quiz_form_id  : this.quizData.quiz_form_id,
                    duration      : this.quizData.duration,
                    total_marks   : this.quizData.total_marks,
                    status        : this.quizData.status,
                    number_of_questions : this.quizData.number_of_questions,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+ localStorage.getItem('authToken')
                    }
                }).then(function (response) {

                if (response.data.status_code === 200) {

                    _that.quizData         = '';
                    _that.error_message    = '';
                    _that.success_message  = " quiz Updated Successfully";
                    _that.isEdit = false;
                    _that.$emit('quiz-edit-data', "quiz updated successfully");
                    document.body.classList.remove('open-side-slider')

                } else if(response.data.status_code === 400){

                    _that.success_message = "";
                    _that.error_message   = "";
                    _that.showServerError(response.data.errors);

                }else{
                    _that.success_message  = "";
                    _that.error_message    = response.data.message;
                }

            }).catch(function (error) {
                console.log(error);
            });

        },

        getQuizDetails() {

            let _that = this;
            let quizID = this.quiz_id;

            let apiUrl = "admin/quizzes/";

            axios.get(apiUrl+quizID,
                {
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if (response.data.status_code === 200) {
                        console.log(response.data);
                        _that.quizDetails    = response.data.quiz_info;

                        _that.quizData.name = _that.quizDetails.name;
                      //  _that.quizData.article_id = _that.quizDetails.article_id;
                        _that.quizData.quiz_form_id = _that.quizDetails.quiz_form_id;
                        _that.quizData.duration = _that.quizDetails.duration;
                        _that.quizData.total_marks = _that.quizDetails.total_marks;
                        _that.quizData.status = _that.quizDetails.status;
                        _that.quizData.number_of_questions = _that.quizDetails.number_of_questions;
                    } else {
                        _that.success_message = "";
                        _that.error_message = response.data.error;
                    }
                })
        },

        getArticleList()
        {
            let _that =this;

            axios.get('admin/articles',
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin : 1
                        },
                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        _that.articleList = response.data.article_list.data;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

        getQuizFormList(){
            let _that =this;

            axios.get('admin/quiz-forms',
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        // console.log(response.data.quiz_form_list);
                        _that.quizformList = response.data.quiz_form_list.data;
                    } else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

    },

    created() {

        this.quiz_id = this.quizId;
        console.log("quiz_id" + this.quiz_id);
        this.getQuizDetails();
        this.getArticleList();
        this.getQuizFormList();
        this.isEdit = this.isEditCheck;
        console.log(this.isEditCheck)

    }
}
</script>

<style scoped>

</style>
