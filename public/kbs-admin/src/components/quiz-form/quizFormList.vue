<template>
    <div class="main-wrapper d-flex">
        <Menu></Menu>
        <div class="main-content-wrapper w-100 position-relative overflow-auto bg-white" >
            <!-- Topbar -->
            <Header></Header>
            <!-- Topbar End -->
            <!-- Content Area -->
            <div class="content-area">
                <div class="content-title-wrapper px-15 py-10">
                    <h2 class="content-title text-uppercase m-0">Quiz Form List</h2>
                </div>
                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center">
                            <div class="d-flex align-items-center">
                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="isAddCheck=true">
                                    <i class="fas fa-plus"></i>
                                    Add Quiz Form
                                </button>
                            </div>
                        </div>
                    </div>
                    <!-- list top area end -->
                    <!-- Content Area -->
                    <div class="data-content-area px-15 py-10">
                        <!-- Table Data -->
                        <div class="table-responsive">
                            <table class="table table-bordered gsl-table" v-if="allQuizField">
                                <thead>
                                <tr>
                                    <th class="text-center">SL</th>
                                    <th class="text-center">Name</th>
                                    <th class="text-center">Publish Date</th>
                                    <th class="text-center">Quiz Form Field</th>
                                    <th class="text-center">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="(a_quiz_field,index) in allQuizField" :key="a_quiz_field.id">
                                    <td class="text-center">{{ ++index }}</td>
                                    <td class="text-center">{{ a_quiz_field.name }}</td>
                                    <td class="text-center">{{ a_quiz_field.created_at }}</td>
                                    <td class="text-center">
                                        <button class="btn btn-primary ripple-btn right-side-common-form btn-xs m-1" @click="quiz_form_id = a_quiz_field.id, isAddFieldCheck=true">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </td>
                                    <td class="text-center" style="min-width: 120px">
                                        <button class="btn btn-success ripple-btn right-side-common-form btn-xs m-1"  @click="quiz_form_id = a_quiz_field.id, isEditCheck=true">
                                            <i class="fas fa-pen"></i>
                                        </button>
                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs m-1" @click="quiz_form_id = a_quiz_field.id, isDelete=true">
                                            <i class="fas fa-trash-restore-alt"></i>
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- Table Data End -->
                        <!-- pagination-->
                        <div v-if="pagination.total > pagination.per_page" class="col-md-offset-4">
                            <nav aria-label="Page navigation">
                                <ul class="pagination mb-0">
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getQuizFormList(pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">First</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getQuizFormList(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                                    </li>
                                    <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                                        <a @click.prevent="getQuizFormList('admin/quiz-forms?page='+n)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">{{ n }}</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getQuizFormList(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getQuizFormList(pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Last</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <!-- Content Area End -->
                </div>
            </div>


            <div class="action-modal-wraper" v-if="success_message">
                <span>{{ success_message }}</span>
            </div>
            <div class="action-modal-wraper-error" v-if="error_message">
                <span>{{ error_message }}</span>
            </div>
            <!--            add-->
            <QuizFromAdd v-if="isAddCheck" :isAddCheck= "isAddCheck" @quiz-form-data="getQuizFormDataFromAdd"></QuizFromAdd>
            <!--            edit-->
            <QuizFromEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :quizFormId="quiz_form_id" @quiz-form-edit-data="getQuizFormDataFromEdit"></QuizFromEdit>
            <!--            delete-->
            <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isDelete===true">
                <div class="close-bar d-flex align-items-center justify-content-end">
                    <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
                </div>
                <div class="right-sidebar-content-wrapper position-relative overflow-hidden">
                    <div class="right-sidebar-content-area px-2">
                        <div class="form-wrapper">
                            <h2 class="section-title text-uppercase mb-20">Quiz Form Delete</h2>
                            <div class="row mt-50 mt-md-80">
                                <div class="col-md-12">
                                    <figure class="mx-auto text-center">
                                        <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                    </figure>
                                    <p class="text-center"> Confirmation for Deleting Quiz Form</p>
                                    <div class="form-group d-flex justify-content-center align-items-center">
                                        <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteQuizForm()"><i class="fas fa-trash"></i> Confirm</button>
                                        <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper()"><i class="fas fa-times-circle" ></i> Cancel</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Content Area End -->
            <QuizFromFieldAdd v-if="isAddFieldCheck" :isAddFieldCheck= "isAddFieldCheck" :quizFormId="quiz_form_id" @quiz-form-field-data="getQuizFormFieldDataFromAdd"></QuizFromFieldAdd>
        </div>
    </div>
</template>
<script>
    import Header from "@/layouts/common/Header";
    import Menu from "@/layouts/common/Menu";
    import QuizFromAdd from "@/components/quiz-form/quizFormAdd";
    import QuizFromEdit from "@/components/quiz-form/quizFormEdit";

    import QuizFromFieldAdd from "../quiz-form-fields/quizFormFieldAdd";


    import axios from "axios";

    export default {
        name: "quizFormList.vue",
        components: {
            Header,
            Menu,
            QuizFromAdd,
            QuizFromEdit,
            QuizFromFieldAdd
        },

        data() {
            return {
                isAddFieldCheck      : false,

                isAddCheck      : false,
                isEditCheck     : false,
                isDelete        : false,

                success_message : '',
                error_message   : '',
                token           : '',
                allQuizField    : '',

                allQuizFieldFrom : '',

                filter : {
                    isAdmin     : 1,
                    username    : '',
                    email       : '',
                    role        : ''
                },
                pagination:{
                    from: '',
                    to: '',
                    first_page_url: '',
                    last_page: '',
                    last_page_url: '',
                    next_page_url:'',
                    prev_page_url: '',
                    path: '',
                    per_page: 10,
                    total: ''
                },
            }
        },
        methods: {
            setTimeoutElements()
            {
                setTimeout(() => this.success_message = "", 3000);
                setTimeout(() => this.error_message = "", 3000);
            },

            deleteQuizForm() {
                let _that = this;

                axios.delete('admin/quiz-forms/delete',
                    {
                        data:
                            {
                                id      : _that.quiz_form_id
                            },
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    }).then(function (response) {

                    if (response.data.status_code == 200)
                    {
                        _that.getQuizFormList();
                        _that.error_message   = '';
                        _that.clearAllChecker();
                        document.body.classList.remove('open-side-slider');
                        _that.success_message = "Successfully deleted the Quiz Form";
                        _that.setTimeoutElements();

                    }
                    else
                    {
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }

                }).catch(function (error) {
                    console.log(error);
                });

            },

            removingRightSideWrapper() {

                this.isAddCheck = false;
                this.isDelete   = false;
                document.body.classList.remove('open-side-slider');

            },

            clearAllChecker() {
                this.isAddCheck = false;
                this.isDelete   = false;
                this.isEditCheck     = false;
                this.isAddFieldCheck      = false;
            },

            getQuizFormDataFromAdd (newData) {
                console.log(newData)
                this.isAddCheck = false;
                this.getQuizFormList();
            },
// work
            getQuizFormFieldDataFromAdd (newData) {
                console.log(newData)
                this.isAddFieldCheck = false;
                this.getQuizFormList();
            },
            getQuizFormDataFromEdit (newEditData) {
                console.log(newEditData)
                this.isEditCheck = false;
                this.getQuizFormList();
            },

            getQuizFormList(pageUrl)
            {
                let _that =this;
                pageUrl = pageUrl == undefined ? 'admin/quiz-forms' : pageUrl;
                axios.get(pageUrl,
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            console.log(response.data);
                            _that.pagination  = response.data.quiz_form_list;
                            _that.allQuizField   = response.data.quiz_form_list.data;
                            // _that.success_message = "";
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },
        },
        created() {
            this.getQuizFormList();
        }
    }
</script>
<style scoped>
</style>
