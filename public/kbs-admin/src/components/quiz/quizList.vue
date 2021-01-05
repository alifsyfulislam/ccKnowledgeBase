<template>

    <div class="main-wrapper d-flex">
        <!-- sidebar -->
        <Menu></Menu>
        <!-- sidebar end -->

        <div class="main-content-wrapper w-100 position-relative overflow-auto bg-white" >
            <!-- Topbar -->
            <Header></Header>

            <!-- Topbar End -->

            <!-- Content Area -->
            <div class="content-area">
                <div class="content-title-wrapper px-15 py-10">
                    <h2 class="content-title text-uppercase m-0">Quiz List</h2>
                </div>

                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center">
                            <div class="d-flex align-items-center">

                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="isAddCheck=true">
                                    <i class="fas fa-plus"></i>
                                    Add Quiz
                                </button>

                            </div>

                        </div>

                    </div>
                    <!-- list top area end -->

                    <!-- Content Area -->
                    <div class="data-content-area px-15 py-10">
                        <Loading v-if="isLoading===true"></Loading>
                        <!-- Table Data -->
                        <div class="table-responsive" v-if="isLoading===false">
                            <table class="table table-bordered gsl-table">
                                <thead>
                                <tr>
                                    <th class="text-center">Name</th>
                                    <!--                                        <th class="text-center">Article</th>-->
                                    <th class="text-center">Duration</th>
                                    <th class="text-center">Total Marks</th>
                                    <th class="text-center">Number of Questions</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center">Action</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr v-for="a_quiz in quizList" :key="a_quiz">

                                    <td class="text-center"> {{ a_quiz.name  }} </td>
                                    <!--                                    <td class="text-center"> {{ a_quiz.article ? a_quiz.article.en_title : '' }} </td>-->
                                    <td class="text-center"> {{ a_quiz.duration }} </td>
                                    <td class="text-center"> {{ a_quiz.total_marks  }} </td>
                                    <td class="text-center"> {{ a_quiz.number_of_questions  }} </td>
                                    <td class="text-center" v-if="a_quiz.status === 0"> Inactive </td>
                                    <td class="text-center" v-else> Active </td>

                                    <td class="text-center">
                                        <button class="btn btn-success ripple-btn right-side-common-form btn-xs mx-1"  @click="quiz_id=a_quiz.id, isEditCheck=true"><i class="fas fa-pen"></i></button>
                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs mx-1" @click="quiz_id=a_quiz.id, isDeleteCheck=true"><i class="fas fa-trash-restore-alt"></i></button>
                                    </td>

                                </tr>

                                </tbody>
                            </table>
                        </div>
                        <!-- Table Data End -->

                        <!-- Pagination -->
                        <div v-if="pagination.total > pagination.per_page" class="col-md-offset-4">
                            <nav aria-label="Page navigation">
                                <ul class="pagination mb-0">
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getQuizList(pagination.first_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">First</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.prev_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getQuizList(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                                    </li>
                                    <li v-for="n in pagination.last_page" class="page-item mx-1"  :key="n">
                                        <a @click.prevent="getQuizList('admin/quizzes?page='+n)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">{{ n }}</a>
                                    </li>

                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getQuizList(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                                    </li>
                                    <li :class="[{disabled:!pagination.next_page_url}]" class="page-item mx-1">
                                        <a @click.prevent="getQuizList(pagination.last_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Last</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                        <!-- Pagination End -->
                    </div>
                    <!-- Content Area End -->
                </div>
            </div>
            <!-- Content Area End -->
        </div>

        <!-- Common Right SideBar -->


        <div class="action-modal-wraper" v-if="success_message">
            <span>{{ success_message }}</span>
        </div>

        <div class="action-modal-wraper-error" v-if="error_message">
            <span>{{ error_message }}</span>
        </div>

<!--        <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                    <img src="../../assets/img/cancel.svg" alt="cancel">
                </button>
            </div>
            &lt;!&ndash;            add data&ndash;&gt;
            <CategoryAdd v-if="isAddCheck" :isAddCheck="isAddCheck" @category-slide-close="getAddDataFromChild"></CategoryAdd>
            &lt;!&ndash;            edit data&ndash;&gt;
            <CategoryEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :categoryId="category_id" @category-slide-close="getEditDataFromChild"></CategoryEdit>
            &lt;!&ndash;            delete data &ndash;&gt;
            <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isDeleteCheck">
                <div class="right-sidebar-content-area px-2">

                    <div class="form-wrapper">
                        <h2 class="section-title text-uppercase mb-20">Delete</h2>

                        <div class="row mt-50 mt-md-80">
                            <div class="col-md-12">
                                <figure class="mx-auto text-center">
                                    <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                </figure>
                                <p class="text-center"> Confirmation for Deleting Category</p>
                                <div class="form-group d-flex justify-content-center align-items-center">
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteCategory()"><i class="fas fa-trash"></i> Confirm</button>
                                    <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper(), isDeleteCheck=false"><i class="fas fa-times-circle" ></i> Cancel</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>-->

        <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                    <img src="../../assets/img/cancel.svg" alt="cancel">
                </button>
            </div>

            <QuizzAdd v-if="isAddCheck" :isAddCheck="isAddCheck" @quiz-slide-close="getAddDataFromChild"></QuizzAdd>

            <QuizzEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :quizId="quiz_id" @quiz-slide-close="getEditDataFromChild"></QuizzEdit>

            <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isDeleteCheck">
                <div class="right-sidebar-content-area px-2">

                    <div class="form-wrapper">
                        <h2 class="section-title text-uppercase mb-20">Delete</h2>

                        <div class="row mt-50 mt-md-80">
                            <div class="col-md-12">
                                <figure class="mx-auto text-center">
                                    <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                </figure>
                                <p class="text-center"> Confirmation for Deleting Quiz</p>

                                <div class="form-group d-flex justify-content-center align-items-center">
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteQuiz()"><i class="fas fa-trash"></i> Confirm</button>
                                    <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper()"><i class="fas fa-times-circle" ></i> Cancel</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>

        <!-- Common Right SideBar End -->
    </div>
</template>

<script>

import Header from "@/layouts/common/Header";
import Menu from "@/layouts/common/Menu";
import QuizzAdd from "@/components/quiz/quizAdd";
import QuizzEdit from "@/components/quiz/quizEdit";
import Loading from "@/components/loader/loading";
import axios from "axios";
import $ from "jquery";

export default {
    name: "quizList",
    components: {
        Header,
        Menu,
        QuizzAdd,
        QuizzEdit,
        Loading
    },

    data() {
        return {

            isLoading       : false,
            isEditCheck     : false,
            isAddCheck      : false,
            isDeleteCheck   : false,
            isSearch        : false,

            success_message : '',
            error_message   : '',
            token           : '',

            quiz_id         : '',

            articleList     : '',
            quizList        : '',
            userInfo        : '',

            filter : {
                isAdmin      : 1,
                status    : '',
                name      : '',
            },

            pagination:{
                from : '',
                to   : '',
                first_page_url : '',
                last_page      : '',
                last_page_url  : '',
                next_page_url  :'',
                prev_page_url  : '',
                path     : '',
                per_page : 10,
                total    : ''
            },
        }
    },

    methods: {

        removingRightSideWrapper()
        {
            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;

            document.body.classList.remove('open-side-slider');
            $('.right-sidebar-wrapper').toggleClass('right-side-common-form-show');
        },

        clearAllChecker() {
            this.isAddCheck    = false;
            this.isDeleteCheck = false;
            this.isSearch      = false;
        },

        getAddDataFromChild (status){

            this.success_message = status;
            this.getQuizList();
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },

        getEditDataFromChild (status)
        {
            this.success_message = status;
            this.getQuizList();
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },

        /*getQuizDataFromAdd (newData) {
            console.log(newData)
            this.isAddCheck = false;
            this.getQuizList();

        },

        getQuizDataFromEdit (newEditData) {

            console.log(newEditData)
            this.isEditCheck = false;
            this.getQuizList();

        },*/

        clearFilter(){

            this.filter.status   = "";
            this.filter.name     = "";
            this.success_message = "";
            this.error_message   = "";
            this.getQuizList();
        },

        getQuizList(pageUrl){

            let _that =this;

            pageUrl = pageUrl == undefined ? 'admin/quizzes' : pageUrl;

            axios.get(pageUrl,
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin : 1,
                            status     : this.filter.status,
                            name       : this.filter.name
                        },

                })
                .then(function (response) {
                    if(response.data.status_code === 200){
                        console.log(response.data);
                        _that.quizList   = response.data.quiz_list.data;
                        _that.pagination = response.data.quiz_list;
                        _that.isLoading  = false;

                    }
                    else{
                        _that.success_message = "";
                        _that.error_message   = response.data.error;
                    }
                })
        },

        deleteQuiz() {
            let _that = this;

            axios.delete('admin/quizzes/delete',
                {
                    data:
                        {
                            id      : this.quiz_id
                        },
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                }).then(function (response) {

                if (response.data.status_code == 200) {
                    _that.getQuizList();
                    _that.error_message   = '';
                    _that.success_message = "Successfully deleted the Quiz";
                    _that.removingRightSideWrapper();
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

        setTimeoutElements() {
            //setTimeout(() => this.isLoading = false, 3000);
            setTimeout(() => this.success_message = "", 3000);
            setTimeout(() => this.error_message = "", 3000);
        },

    },

    created() {

        this.isLoading = true;
        this.getQuizList();

    }
}
</script>

<style scoped>
.mhv-100 {
    min-height: 50vh;
}
</style>
