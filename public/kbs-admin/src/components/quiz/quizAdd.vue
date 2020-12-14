<template>
  <div class="col-md-12 wrapper d-flex align-items-stretch">
    <Menu></Menu>

    <!-- Page Content  -->
    <div id="content" style="margin-left:50px; ">

      <Header></Header>

      <div class="col-md-12">
        <div v-if="success_message" class="alert alert-success" role="alert">
          {{ success_message }}
        </div>
        <div v-if="error_message" class="alert alert-danger" role="alert">
          {{ error_message }}
        </div>
      </div>

      <div class="row">
        <div class="col-md-9">
          <div class="nk-block-head nk-block-head-sm">
            <div class="nk-block-between">
              <div class="nk-block-head-content">
                <h3 class="nk-block-title page-title text-left">Add New Quiz</h3>
              </div>
            </div>
          </div>
          <div  class="card card-bordered card-preview">
            <div class="card-body">

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label">Title</label>
                </div>
                <div class="col-md-8">
                  <input type="text" class="form-control form-control-lg" v-model="quizData.name" placeholder="Enter Quiz Title">
                </div>

              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label">Select Article</label>
                </div>
                <div class="col-md-8">
                  <select class="form-control" v-model="quizData.article_id">
                    <option value="">Select One</option>
                    <option v-for="a_article in articleList" :value="a_article.id" :key="a_article">
                      {{a_article.en_title}}
                    </option>
                  </select>
                </div>
              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label">Select Quiz Form</label>
                </div>
                <div class="col-md-8">
                  <select class="form-control" v-model="quizData.quiz_form_id">
                    <option value="">Select A Quiz Form</option>
                    <option v-for="a_quiz_form in quizformList" :value="a_quiz_form.id" :key="a_quiz_form">
                      {{a_quiz_form.name}}
                    </option>
                  </select>
                </div>
              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label" >Duration</label>
                </div>
                <div class="col-md-8">
                  <input type="text" class="form-control form-control-lg" v-model="quizData.duration" placeholder="Ex. 2 hours, 5 hours">
                </div>

              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label" >Total Marks</label>
                </div>
                <div class="col-md-8">
                  <input type="number" class="form-control form-control-lg" step="any" v-model="quizData.total_marks" >
                </div>

              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label" >Number Of Questions</label>
                </div>
                <div class="col-md-8">
                  <input type="number" class="form-control form-control-lg" v-model="quizData.number_of_questions" >
                </div>

              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label">Select A Status</label>
                </div>
                <div class="col-md-8">
                  <select class="form-control" v-model="quizData.status">
                    <option value="">Select A Status</option>
                    <option value="0">Inactive</option>
                    <option value="1">Active</option>
                  </select>
                </div>
              </div>

              <div class="row">
                <div class="col-md-3" >
                  <button class="btn btn-info" @click="quizAdd()">Save</button>
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
name: "quizAdd",
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
      quizformList   : '',

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

    quizAdd() {
      let _that = this;

      axios.post('admin/quizzes',
          {
            article_id    : this.quizData.article_id,
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
        if (response.data.status_code == 201)
        {
          _that.quizData         = '';
          _that.error_message    = '';
          _that.success_message  = "New Quiz Added Successfully";
          _that.$router.push('/admin/quizList');
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
    this.getArticleList();
    this.getQuizFormList();
  }
}
</script>

<style scoped>

</style>