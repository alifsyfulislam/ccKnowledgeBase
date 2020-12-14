<template>
  <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isAdd===true">
    <div class="close-bar d-flex align-items-center justify-content-end">
      <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
    </div>

      <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
        <div class="right-sidebar-content-area px-2">

          <div class="form-wrapper">
            <h2 class="section-title text-uppercase mb-20">Add New Article</h2>
            <select v-model="selected_language" class="form-control col-md-12 mb-20">
              <option value="english">English</option>
              <option value="bangla">Bangla</option>
            </select>

            <div class="col-md-12">
              <div v-if="success_message" class="alert alert-success" role="alert">
                {{ success_message }}
              </div>
              <div v-if="error_message" class="alert alert-danger" role="alert">
                {{ error_message }}
              </div>
            </div>

            <div class="row">

              <div class="col-md-6">
                <div class="form-group">
                  <label for="articleID">Title <span class="required">*</span></label>
                  <input class="form-control" type="text" v-model="articleData.en_title" id="articleID" required>
                </div>
              </div>

              <div class="col-md-6" v-if="selected_language=='bangla'">
                <div class="form-group">
                  <label>Bangla Title </label>
                  <input class="form-control" type="text" v-model="articleData.bn_title" >
                </div>
              </div>

              <div class="col-md-6">
                <div class="form-group">
                  <label>Category <span class="required">*</span></label>

                  <select class="form-control" v-model="selectedCategory">
                    <option value="">Select A Category</option>
                    <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                      {{a_category.name}}
                    </option>
                  </select>
                </div>
              </div>
              <div class="col-md-12">
                <div class="form-group">
                  <label for="tag">Tag</label>
                  <input class="form-control" type="text" v-model="articleData.tag" id="tag">
                </div>
              </div>

              <div class="col-md-12">
                <div class="form-group mb-15">
                  <label>English Short Summary</label>
                  <textarea  cols="30" rows="4" class="form-control" v-model="articleData.en_short_summary"></textarea>
                </div>
              </div>
              <div class="col-md-12" v-if="selected_language=='bangla'">
                <div class="form-group mb-15">
                  <label for="bn_short_summary">Bangla Short Summary</label>
                  <textarea cols="30" rows="4" class="form-control " v-model="articleData.bn_short_summary" id="bn_short_summary"></textarea>
                </div>
              </div>

              <div class="col-md-12">
                <div class="form-group mb-15">
                  <label >English Body</label>
                  <Summernote  v-model="articleData.en_body" :idFromParent="enBody" ></Summernote>

                </div>
              </div>

              <div class="col-md-12" v-if="selected_language=='bangla'">
                <div class="form-group mb-15">
                  <label >Bangla Body</label>
                  <Summernote   v-model="articleData.bn_body" :idFromParent="bnBody" ></Summernote>
                </div>
              </div>

              <div class="col-md-12">
                <div class="form-group">
                  <label>Select A Status</label>
                  <select class="form-control" v-model="articleData.status">
                    <option value="draft">Draft</option>
                    <option value="hide">Hide</option>
                    <option value="private">Private</option>
                    <option value="public">Public</option>
                  </select>
                </div>
              </div>

            </div>


            <div class="form-group text-right">
              <button class="btn common-gradient-btn ripple-btn px-50" @click="articleAdd()">Add</button>
            </div>
          </div>

        </div>
      </div>
  </div>


</template>

<script>
import axios from 'axios'
import Summernote from "@/components/summer-note/summernote";


export default {
  name: "articleAdd.vue",
  props: ['isAddCheck'],
  components: {
    Summernote
  },
  data() {
    return {
      isAdd : false,
      enBody : "en_Body",
      bnBody : "bn_Body",
      selected_language : 'english',
      success_message : '',
      error_message   : '',
      token           : '',
      categoryList    : '',
      selectedCategory  : '',
      userInfo        : '',
      articleData        : {
        en_title  : '',
        bn_title  : '',
        tag  : '',
        en_short_summary  : '',
        bn_short_summary  : '',
        en_body  : '',
        bn_body  : '',
        status  : 'draft',
      },
      images: [],
      files: [],
      url : '',
      video_files : ''

    }
  },
  methods: {

    clearAllChecker()
    {
      this.isAdd = false;
      this.$emit('article-data', this.isAdd);
    },

    articleAdd() {

      let _that = this;
      let formData = new FormData();
      let enBody = document.getElementById('en_Body').value;

      if (!(document.getElementById('bn_Body'))) {
        var bnBody = '';
      } else {
         bnBody  = document.getElementById('bn_Body').value;
      }


      formData.append('category_id', this.selectedCategory);
      formData.append('en_title', this.articleData.en_title);
      formData.append('bn_title', this.articleData.bn_title);
      formData.append('tag', this.articleData.tag);
      formData.append('en_short_summary', this.articleData.en_short_summary);
      formData.append('bn_short_summary', this.articleData.bn_short_summary);
      formData.append('en_body', enBody);
      formData.append('bn_body', bnBody);
      formData.append('status', this.articleData.status);

      axios.post('admin/articles', formData,
          {
            headers: {
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer '+localStorage.getItem('authToken')
            }
          }).then(function (response) {
        if (response.data.status_code == 201) {

          _that.articleData      = '';
          _that.selectedCategory = '';
          _that.error_message    = '';
          _that.success_message  = "New Article Added Successfully";
          _that.isAdd = false;
          _that.$emit('article-data', _that.articleData);

          document.body.classList.remove('open-side-slider')
          console.log(formData);

        } else {

          _that.success_message = "";
          _that.error_message   = response.data.error;

        }

      }).catch(function (error) {

        console.log(error);

      });

    },

    getCategoryList()
    {
      let _that =this;

      axios.get('admin/categories',
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
              _that.categoryList = response.data.category_list.data;
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
    this.getCategoryList();
  }
}
</script>

<style scoped>

</style>