<template>
<!--  <div class="col-md-12 wrapper d-flex align-items-stretch">
    <Menu></Menu>

    <div class="col-md-9" style="margin-left:40px; ">

      <Header></Header>

      <div class="row">
        <div class="col-md-12">
          <div class="card">
            <div class="card-header bg-primary">
              <h4 class="mb-0">
                Search
              </h4>
            </div>
            <div class="card-body">
              <div class="row mt-3">

                <div class="form-row col-md-12">
                  <div class="form-group col-md-4">
                    <label class="form-label" >Name</label>
                    <input type="text" class="form-control" v-model="filter.name" >
                  </div>

                  <div class="form-group col-md-4">
                    <label class="form-label" >Select Article</label>

                    <select class="form-control" v-model="filter.article_id">
                      <option value="">Select One</option>
                      <option v-for="an_article in articleList" :value="an_article.id" :key="an_article">
                        {{an_article.en_title}}
                      </option>
                    </select>

                  </div>

                  <div class="form-group col-md-4">
                    <label class="form-label" >Select A Status</label>

                    <select class="form-control" v-model="filter.status">
                      <option value="">Select A Status</option>
                      <option value="0">Inactive</option>
                      <option value="1">Active</option>
                    </select>

                  </div>
                </div>

              </div>
            </div>
            <div class="card-footer clearfix">
              <div class="btn-toolbar">
                <a class="btn btn-danger btn-sm" @click="clearFilter()"> Clear</a>
                <div class="col-md-1">
                  <button type="button" class="btn btn-success btn-sm" @click="getQuizList()">Filter</button>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>

      <div class="row">
        <div class="col-md-12">
          <div v-if="success_message" class="alert alert-success" role="alert">
            {{ success_message }}
          </div>
          <div v-if="error_message" class="alert alert-danger" role="alert">
            {{ error_message }}
          </div>
        </div>

        <div class="col-md-12">
          <div class="card">
            <div class="card-body">
              <div class="row">
                <div class="col-sm-3">
                  <h4 class="card-title ">
                    Quiz List
                  </h4>
                </div>

                <div class="col-sm-9 text-right">
                  <router-link :to="{ name: 'quizAdd'}" class="btn btn-primary">
                    + Add New
                  </router-link>
                </div>

              </div>

              <div class="row mt-4">
                <div class="col">
                  <div class="table-responsive text-nowrap">
                    <table class="table">
                      <thead>
                      <tr>
                        <th>Name</th>
                        <th>Article</th>
                        <th>Duration</th>
                        <th>Total Marks</th>
                        <th>Number of Questions</th>
                        <th>Status</th>
                        <th>Action</th>
                      </tr>
                      </thead>
                      <tbody>

                      <tr v-for="a_quiz in quizList" :key="a_quiz">

                        <td> {{ a_quiz.name  }} </td>
                        <td> {{ a_quiz.article ? a_quiz.article.en_title : '' }} </td>
                        <td> {{ a_quiz.duration }} </td>
                        <td> {{ a_quiz.total_marks  }} </td>
                        <td> {{ a_quiz.number_of_questions  }} </td>
                        <td v-if="a_quiz.status == 0"> Inactive </td>
                        <td v-else> Active </td>

                        <td>
&lt;!&ndash;                          <router-link :to="{ name: 'faqDetails', params: { id: an_faq.id }}" class="btn btn-success ">
                            Details
                          </router-link>&ndash;&gt;

                          <router-link :to="{ name: 'quizEdit', params: { id: a_quiz.id }}" class="btn btn-info ">
                            Edit
                          </router-link>

                          <a href="#" class="btn btn-danger" data-toggle="modal"  :data-target="'#deleteModal_'+ a_quiz.id">Delete</a>

                          <div class="modal col-md-offset-2 fade" :id="'deleteModal_'+ a_quiz.id" role="dialog">
                            <div class="modal-dialog">

                              <div class="modal-content">
                                <div class="modal-header">
                                  <h4 class="modal-title">Confirmation for Deleting Category</h4>
                                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body">
                                  <div class="col-md-12">
                                    <div class="col-md-10">
                                      <h6>Are You Sure to delete?</h6>
                                    </div>
                                  </div>

                                </div>

                                <div class="modal-footer">
                                  <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                  <button @click="deleteQuiz(a_quiz.id)" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
                                </div>
                              </div>
                            </div>
                          </div>

                        </td>

                      </tr>

                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>
  </div>-->

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
                        <!-- Table Data -->
                        <div class="table-responsive">
                            <table class="table table-bordered gsl-table">
                                <thead>
                                    <tr>
                                        <th class="text-center">Name</th>
                                        <th class="text-center">Article</th>
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
                                    <td class="text-center"> {{ a_quiz.article ? a_quiz.article.en_title : '' }} </td>
                                    <td class="text-center"> {{ a_quiz.duration }} </td>
                                    <td class="text-center"> {{ a_quiz.total_marks  }} </td>
                                    <td class="text-center"> {{ a_quiz.number_of_questions  }} </td>
                                    <td class="text-center" v-if="a_quiz.status === 0"> Inactive </td>
                                    <td class="text-center" v-else> Active </td>

                                    <td class="text-center">
                                        <!--                    <button class="btn btn-primary ripple-btn right-side-common-form btn-xs mx-1"><i class="fas fa-eye"></i></button>-->
                                        <button class="btn btn-success ripple-btn right-side-common-form btn-xs mx-1"  @click="category_id=a_category.id, isEditCheck=true"><i class="fas fa-pen"></i></button>
                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs mx-1" @click="category_id=a_category.id, isDelete=true"><i class="fas fa-trash-restore-alt"></i></button>
                                    </td>

<!--                                    <td>
                                        <router-link :to="{ name: 'faqDetails', params: { id: an_faq.id }}" class="btn btn-success ">
                                            Details
                                        </router-link>&ndash;&gt;

                                        <router-link :to="{ name: 'quizEdit', params: { id: a_quiz.id }}" class="btn btn-info ">
                                            Edit
                                        </router-link>

                                        <a href="#" class="btn btn-danger" data-toggle="modal"  :data-target="'#deleteModal_'+ a_quiz.id">Delete</a>

                                        <div class="modal col-md-offset-2 fade" :id="'deleteModal_'+ a_quiz.id" role="dialog">
                                            <div class="modal-dialog">

                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Confirmation for Deleting Category</h4>
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="col-md-12">
                                                            <div class="col-md-10">
                                                                <h6>Are You Sure to delete?</h6>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                                        <button @click="deleteQuiz(a_quiz.id)" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </td>-->

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

        <QuizzAdd v-if="isAddCheck" :isAddCheck= "isAddCheck" @quiz-data="getQuizDataFromAdd"></QuizzAdd>

        <QuizzEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :quizId="quiz_id" @quiz-edit-data="getQuizDataFromFromEdit"></QuizzEdit>

        <div class="right-sidebar-wrapper right-sidebar-small-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isDelete===true">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
            </div>

            <div class="right-sidebar-content-wrapper position-relative overflow-hidden">
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
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteCategory"><i class="fas fa-trash"></i> Confirm</button>
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
import axios from "axios";

export default {
name: "quizList",
  components: {
    Header,
    Menu,
    QuizzAdd,
    QuizzEdit
  },

  data() {
    return {

        isEditCheck     : false,
        isAddCheck      : false,
        isDelete        : false,
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
            article_id  : '',
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
      removingRightSideWrapper(){
        this.isAddCheck = false;
        this.isDelete   = false;
        this.isSearch   = false;
        document.body.classList.remove('open-side-slider');
      },

    clearAllChecker() {
      this.isAddCheck = false;
      this.isDelete   = false;
      this.isSearch   = false;
      },

    getDataFromAdd (newData) {
      console.log(newData)
      this.isAddCheck = false;
      this.getQuizList();

  },

  getQuizDataFromEdit (newEditData) {

      console.log(newEditData)
      this.isEditCheck = false;
      this.getQuizList();

  },

    clearFilter()
    {
      this.filter.article_id = "";
      this.filter.status   = "";
      this.filter.name     = "";
      this.success_message = "";
      this.error_message   = "";
      this.getQuizList();
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
                  article_id : this.filter.article_id,
                  status     : this.filter.status,
                  name       : this.filter.name
                },

          })
          .then(function (response) {
            if(response.data.status_code === 200){
              console.log(response.data);
              _that.quizList = response.data.quiz_list.data;
              _that.pagination   = response.data.quiz_list;
            }
            else{
              _that.success_message = "";
              _that.error_message   = response.data.error;
            }
          })
    },

    deleteQuiz(quizId) {
      let _that = this;

      axios.delete('quizzes/delete',
          {
            data:
                {
                  id      : quizId
                },
            headers: {
              'Authorization': 'Bearer ' + localStorage.getItem('authToken')
            },
          }).then(function (response) {

        if (response.data.status_code == 200)
        {
          _that.getQuizList();
          _that.error_message   = '';
          _that.success_message = "Quiz Deleted Successfully";
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

  },
  created() {
    this.getQuizList();
    this.getArticleList();
  }
}
</script>

<style scoped>

</style>
