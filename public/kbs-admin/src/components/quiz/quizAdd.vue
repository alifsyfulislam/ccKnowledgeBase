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
                    <h2 class="section-title text-uppercase mb-20">Add New Quiz</h2>

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
                                <label>Select A Status</label>

                                <select class="form-control" v-model="quizData.status">
                                    <option value="" disabled>Select A Status</option>
                                    <option value="0">Inactive</option>
                                    <option value="1">Active</option>
                                </select>
                            </div>

                        </div>

                    </div>

                    <div class="form-group text-right">
                        <button class="btn common-gradient-btn ripple-btn px-50" @click="quizAdd()">Add</button>
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
    name: "quizAdd",
    props: ['isAddCheck'],
    components: {

    },

    data() {
        return {

            isAdd : false,
            success_message : '',
            error_message   : '',
            token           : '',
            articleList     : '',
            quizformList   : '',

            quizData        :{
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

            this.isAdd = false;
            this.$emit('quiz-data', this.isAdd);

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

        quizAdd() {
            let _that = this;

            axios.post('admin/quizzes',
                {
                    //article_id    : this.quizData.article_id,
                    name          : this.quizData.name,
                    quiz_form_id  : this.quizData.quiz_form_id,
                    duration      : this.quizData.duration,
                    total_marks   : this.quizData.total_marks,
                    status        : this.quizData.status,
                    number_of_questions   : this.quizData.number_of_questions,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {

                if (response.data.status_code === 201){
                    _that.quizData         = '';
                    _that.error_message    = '';

                    _that.isAdd = false;
                    _that.success_message  = "New Quiz Added Successfully";
                    _that.$emit('quiz-data', "New Quiz Added Successfully");
                    document.body.classList.remove('open-side-slider')

                }else if(response.data.status_code === 400){

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
                        console.log(response.data);
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
                        console.log(response.data.quiz_form_list);
                        _that.quizformList = response.data.quiz_form_list.data;
                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

    },
    created() {
        this.isAdd = this.isAddCheck;
        this.getArticleList();
        this.getQuizFormList();
    }
}
</script>

<style scoped>

</style>
