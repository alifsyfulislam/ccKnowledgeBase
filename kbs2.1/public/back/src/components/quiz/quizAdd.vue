<template>

    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isAddCheck===true">
        <div class="right-sidebar-content-area px-2">

            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Add New Quiz</h2>

                <div class="row">

                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="title">Title <span class="required">*</span></label>
                            <input type="text" class="form-control" v-model="quizData.name" id="title" placeholder="Enter Quiz Title" @keyup="checkAndChangeValidation(quizData.name, '#title', '#titleError', '*title')" required>
                            <span id="titleError" class="text-danger small"></span>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Select Quiz Form</label>

                            <select class="form-control" id="quizForm" v-model="quizData.quiz_form_id" @change="checkAndValidateSelectType()" >
                                <option value="" disabled>Select A Quiz Form</option>
                                <option v-for="a_quiz_form in quizformList" :value="a_quiz_form.id" :key="a_quiz_form.id">
                                    {{ a_quiz_form.name }}
                                </option>
                            </select>
                            <span id="quizFormError" class="text-danger small"></span>

                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="duration">Duration (Minutes)</label>
                            <input type="number" class="form-control" v-model="quizData.duration"  id="duration" placeholder="Ex : 30" @keyup="checkAndChangeValidation(quizData.duration, '#duration', '#durationError', '*duration')">
                            <span id="durationError" class="text-danger small"></span>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="totalMarks">Total Marks<span class="required">*</span></label>
                            <input type="number" class="form-control " v-model="quizData.total_marks" id="totalMarks" placeholder="Ex : 100" @keyup="checkAndChangeValidation(quizData.total_marks, '#totalMarks', '#totalMarksError', '*total marks')">
                            <span id="totalMarksError" class="text-danger small"></span>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="numberOfQuestions">Number Of Questions<span class="required">*</span></label>
                            <input type="number" class="form-control" v-model="quizData.number_of_questions" id="numberOfQuestions" placeholder="Ex : 10" @keyup="checkAndChangeValidation(quizData.number_of_questions, '#numberOfQuestions', '#numberOfQuestionsError', '*number of questions')">
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
                    <button class="btn common-gradient-btn ripple-btn px-50" @click="validateAndSubmit()">Add</button>
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

           // isAdd : false,
            success_message : '',
            error_message   : '',
            token           : '',
            articleList     : '',
            quizformList   : '',

            quizData        :{
                name          : '',
                quiz_form_id  : '',
                duration      : '',
                total_marks   : '',
                status        : 1,
                number_of_questions   : '',
            },

            validation_error :{
                isTitleStatus : false,
                isQuizFormStatus : false,
                isDurationStatus : false,
                isTotalMarksStatus : false,
                isNumberOfQuestionStatus : false,
            },
        }
    },
    methods: {

        checkAndChangeValidation(selected_data, selected_id, selected_error_id, selected_name) {

            if (selected_data.length >0) {
                if (selected_name === "*title"){

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

                        if (selected_name === "*title"){
                            this.validation_error.isTitleStatus = true;
                        }
                    }
                }else{
                    $(selected_id).css({
                        'border-color': '#ced4da',
                    });
                    $(selected_error_id).html("");

                    if (selected_name === "*duration"){
                        this.validation_error.isDurationStatus = true;
                    }else if(selected_name === "*total marks"){
                        this.validation_error.isTotalMarksStatus = true;
                    }else if(selected_name === "*number of questions"){
                        this.validation_error.isNumberOfQuestionStatus = true;
                    }
                }

            } else{
                $(selected_id).css({
                    'border-color': '#FF7B88',
                });
                $(selected_error_id).html(selected_name+" field is required")

                if (selected_name === "*title"){
                    this.validation_error.isTitleStatus = true;
                }else if (selected_name === "*duration"){
                    this.validation_error.isDurationStatus = true;
                }else if(selected_name === "*total marks"){
                    this.validation_error.isTotalMarksStatus = true;
                }else if(selected_name === "*number of questions"){
                    this.validation_error.isNumberOfQuestionStatus = true;
                }
            }
        },

        checkAndValidateSelectType(){

            if (!this.quizData.quiz_form_id) {
                $('#quizForm').css({
                    'border-color': '#FF7B88',
                });
                $('#quizFormError').html("*quiz form field is required");
                this.validation_error.isQuizFormStatus = false;

            } else{
                $('#quizForm').css({
                    'border-color': '#ced4da',
                });
                $('#quizFormError').html("");
                this.validation_error.isQuizFormStatus = true;
            }
        },

        validateAndSubmit(){

            if (!this.quizData.name){
                $('#title').css({
                    'border-color': '#FF7B88',
                });
                $('#titleError').html("*title field is required");
            }
            if (!this.quizData.quiz_form_id){
                $('#quizForm').css({
                    'border-color': '#FF7B88',
                });
                $('#quizFormError').html("*quiz form field is required");
            }
            if (!this.quizData.duration){
                $('#duration').css({
                    'border-color': '#FF7B88',
                });
                $('#durationError').html("*duration field is required");
            }
            if (!this.quizData.total_marks){
                $('#totalMarks').css({
                    'border-color': '#FF7B88',
                });
                $('#totalMarksError').html("*total marks field is required");
            }
            if (!this.quizData.number_of_questions){
                $('#numberOfQuestions').css({
                    'border-color': '#FF7B88',
                });
                $('#numberOfQuestionsError').html("*number of questions field is required");
            }

            console.log(this.validation_error);

            if (this.validation_error.isTitleStatus === true &&
                this.validation_error.isQuizFormStatus === true &&
                this.validation_error.isDurationStatus === true &&
                this.validation_error.isTotalMarksStatus === true &&
                this.validation_error.isNumberOfQuestionStatus === true){
                //console.log(this.validation_error)
                this.quizAdd();
            }
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

            axios.post('quizzes',
                {
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
                    _that.success_message  = "Quiz added successfully";
                    _that.$emit('quiz-slide-close', _that.success_message);

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

            axios.get('articles',
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

            axios.get('quiz-forms',
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
      /*  this.isAdd = this.isAddCheck;*/
        this.getArticleList();
        this.getQuizFormList();
    }
}
</script>

<style scoped>

</style>
