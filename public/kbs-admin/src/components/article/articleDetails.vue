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
        <div class="content-title-wrapper px-15 py-10 d-md-flex justify-content-between align-items-center">
          <h2 class="content-title text-uppercase m-0">Article Details</h2>
          <router-link :to="{ name: 'articleList'}" class="btn btn-primary btn-xs m-1 px-15 py-2">
            <i class="fas fa-arrow-left"></i> Back
          </router-link>
        </div>


        <div class="content-wrapper bg-white" v-if="aArticle">
          <div class="data-content-area px-15 py-10">
            <h3 class="">{{aArticle.en_title}}</h3>



              <p class="font-16"><strong>Tags: </strong>{{aArticle.tag}}</p>
              <div class="ta-wrapper d-flex align-items-center py-10 my-25">
                <div class="avatar mr-10">
                  <img class="img-fluid" src="@/assets/image.png" style="height: 50px; width: 50px" alt="avatar">
                </div>
                <div class="tc-wrapper">
                  <h5 v-cloak class="my-0 pb-1">{{aArticle.user.first_name}} {{aArticle.user.last_name}}</h5>
                  <p class="mb-0">Post on: {{aArticle.created_at}}</p>
                </div>
              </div>

<!--              <div class="ta-content-wrapper">
                <h3 class="">{{aArticle.en_title}}</h3>
              </div>-->

              <div class="ta-content-wrapper">
                <p class="text-justify" v-html="aArticle.en_body"></p>
              </div>
          </div>

          <!-- Content Area End -->
        </div>
      </div>
      <!-- Content Area End -->
    </div>

    <!-- Common Right SideBar End -->
  </div>
</template>

<script>
import Header from "@/layouts/common/Header";
import Menu from "@/layouts/common/Menu";
import axios from "axios";


/*export default {
  name: "articleDetails.vue",
  components: {
    Header,
    Menu
  },

  data() {
    return {
      category_parent_id : '',
      category_name   : '',
      success_message : '',
      error_message   : '',
      token           : '',
      articleDetails    : '',
      article_id :  '',
      userInfo        : '',
      filter : {
        isAdmin : 1
      }
    }
  },*/

  export default {
    name: "articleDetails.vue",
    components: {
      Header,
      Menu
    },
    data(){

      return{

        articleID: '',
        aArticle: '',
        articleCounter: [],
        allCategoryArticle: '',
        categoryHasArticle: [],
        allArticle: '',
        query_string: ''

      }

    },

  methods: {
    articleSearch(v){
      let _that = this;
      let articleID = v;
      axios.get('article/'+articleID)
          .then(function (response) {
            _that.aArticle = response.data.article_info;

            console.log(_that.aArticle);
          })
    },
    searchData(){
      let _that = this;
      _that.$router.push({ name: 'Search', params: { query_string: _that.query_string } });
    },
    getRecentArticleList(){
      let _that = this;
      axios.get('article-list')
          .then(function (response) {
            _that.allArticle = response.data.article_list;
          })
    },
    getCategoryArticleList()
    {
      let _that =this;
     // let articleCounter = 0;
      axios.get('category-article-list', { cache: false })
          .then(function (response) {
            if(response.data.status_code === 200){
              _that.allCategoryArticle = response.data.category_list;
              _that.allCategoryArticle.forEach(val =>{
                if (val.article.length!=0){
                  _that.categoryHasArticle.push(val);
                }
              })
            }
          })
    },
    /*getArticleDetails() {
      let _that = this;
      let articleID = this.article_id;
      console.log("article Id " + articleID);
      let apiUrl = "admin/articles/";

      axios.get(apiUrl+articleID,
          {
            headers: {
              'Authorization': 'Bearer ' + localStorage.getItem('authToken')
            },
          })
          .then(function (response) {
            if (response.data.status_code === 200) {
              console.log(response.data);
              _that.articleDetails = response.data.article_info;
            } else {
              _that.success_message = "";
              _that.error_message = response.data.error;
            }
          })
    },*/

  },

  created() {
    this.articleID = this.$route.params.id;
    this.articleSearch(this.articleID);
    this.getCategoryArticleList();
    this.getRecentArticleList();

    /*this.article_id = this.$route.params.id;
    console.log(this.article_id);
    this.getArticleDetails();*/
  }
}

</script>

<style scoped>

</style>