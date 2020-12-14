<template>
  <div class="col-md-12 wrapper d-flex align-items-stretch">
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
<!--                          <router-link :to="{ name: 'faqDetails', params: { id: an_faq.id }}" class="btn btn-success ">
                            Details
                          </router-link>-->

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
  </div>
</template>

<script>

import Header from "@/layouts/common/Header";
import Menu from "@/layouts/common/Menu";
import axios from "axios";

export default {
name: "quizList",
  components: {
    Header,
    Menu
  },

  data() {
    return {

      success_message : '',
      error_message   : '',
      token           : '',

      articleList     : '',
      quizList        : '',
      userInfo        : '',

      filter : {
        isAdmin      : 1,
        article_id  : '',
        status    : '',
        name      : '',
      }
    }
  },
  methods: {

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

    getQuizList()
    {
      let _that =this;

      axios.get('quizzes',
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