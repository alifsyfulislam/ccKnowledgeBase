<template>
  <!--  <div class="col-md-12 wrapper d-flex align-items-stretch">
      <Menu></Menu>

      &lt;!&ndash; Page Content  &ndash;&gt;
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

            <div  class="card card-bordered card-preview">
              <div class="card-header">
                <div class="row">
                  <div class="col-sm-4">
                    <h4 class="card-title ">
                      Update Article
                    </h4>
                  </div>

                  <div class="col-sm-7 text-right">

                    <select v-model="selected_language">
                      <option value="english">English</option>
                      <option value="bangla">Bangla</option>
                    </select>

                  </div>

                </div>
              </div>
              <div class="card-body">

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label">Title</label>
                  </div>
                  <div class="col-md-8">
                    <input type="text" class="form-control form-control-lg" v-model="articleData.en_title" placeholder="Enter English Title">
                  </div>

                </div>

                <div class="row form-group" v-if="selected_language=='bangla'">
                  <div class="col-md-4">
                    <label class="form-label" >Bangla Title</label>
                  </div>
                  <div class="col-md-8">
                    <input type="text" class="form-control form-control-lg" v-model="articleData.bn_title" placeholder="Enter Bangla Title">
                  </div>

                </div>

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label">Select A Category</label>
                  </div>
                  <div class="col-md-8">
                    <select class="form-control" v-model="articleData.category_id">
                      <option value="">Select A Category</option>
                      <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                        {{a_category.name}}
                      </option>
                    </select>
                  </div>
                </div>

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label" >Tag</label>
                  </div>
                  <div class="col-md-8">
                    <input type="text" class="form-control form-control-lg" v-model="articleData.tag" placeholder="Ex. Horror, Thriller">
                  </div>

                </div>

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label">English Short Story</label>
                  </div>
                  <div class="col-md-8">
                    <textarea  cols="30" rows="4" class="form-control form-control-lg" v-model="articleData.en_short_summary"></textarea>
                    &lt;!&ndash; <input type="textarea" class="form-control form-control-lg" v-model="articleData.en_short_summary" placeholder="Enter Category Name">&ndash;&gt;
                  </div>

                </div>

                <div class="row form-group" v-if="selected_language=='bangla'">
                  <div class="col-md-4">
                    <label class="form-label" >Bangla Short Story</label>
                  </div>
                  <div class="col-md-8">
                    <textarea cols="30" rows="4" class="form-control form-control-lg" v-model="articleData.bn_short_summary"></textarea>
                  </div>

                </div>

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label" >English Body</label>
                  </div>
                  <div class="col-md-8">
                    <textarea cols="30" rows="6" class="form-control form-control-lg" v-model="articleData.en_body"></textarea>
                  </div>

                </div>

                <div class="row form-group" v-if="selected_language=='bangla'">
                  <div class="col-md-4">
                    <label class="form-label" >Bangla Body</label>
                  </div>
                  <div class="col-md-8">
                    <textarea cols="30" rows="6" class="form-control form-control-lg" v-model="articleData.bn_body"></textarea>
                  </div>

                </div>

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label" >Upload Images</label>
                  </div>
                  <div class="col-md-8">
                    <input type="file" id="files" ref="files" multiple @change="onFileChange"  >
                  </div>

                </div>

  &lt;!&ndash;              <div class="row form-group">
                  <div v-for="(image, key) in images" :key="key">
                    <img class="preview"  :src="image"/>
                  </div>
                </div>&ndash;&gt;

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label">Select A Status</label>
                  </div>
                  <div class="col-md-8">
                    <select class="form-control" v-model="articleData.status">
                      <option value="draft">Draft</option>
                      <option value="hide">Hide</option>
                      <option value="private">Private</option>
                      <option value="public">Public</option>

                    </select>
                  </div>
                </div>

                <div class="row">
                  <div class="col-md-3" >
                    <button class="btn btn-info" @click="articleUpdate()">Update</button>
                  </div>
                </div>

              </div>
            </div>

          </div>
        </div>

      </div>
    </div>-->


  <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isEdit===true">
    <div class="close-bar d-flex align-items-center justify-content-end">
      <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
    </div>

    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
      <div class="right-sidebar-content-area px-2">

        <div class="form-wrapper">
          <h2 class="section-title text-uppercase mb-20">Edit Category</h2>

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
                <label for="articleID">Name <span class="required">*</span></label>
                <input class="form-control" type="text" v-model="category_name" id="articleID" required>
              </div>
            </div>
          </div>


<!--            <div class="col-md-6">
              <div class="form-group">
                <label>Category <span class="required">*</span></label>

                <select class="form-control" v-model="articleData.category_id">
                  <option value="">Select A Category</option>
                  <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                    {{a_category.name}}
                  </option>
                </select>
              </div>
            </div>-->

          <div class="form-group text-right">
            <button class="btn common-gradient-btn ripple-btn px-50" @click="categoryUpdate()">Update</button>
          </div>
        </div>

      </div>
    </div>
  </div>


</template>

<script>

import axios from "axios";

export default {

  name: "categoryEdit.vue",
  props: ['isEditCheck', 'categoryId'],

  data() {
    return {
      isEdit : false,

      category_id : '',
      category_parent_id : '',

      category_name   : '',
      categoryDetails : '',
      categoryList    : '',
      success_message : '',
      error_message   : '',
      token           : '',
    }
  },

  methods: {

    clearAllChecker()
    {
      this.isEdit = false;
      this.$emit('category-edit-data', this.isEdit);
    },

    categoryUpdate() {

      let _that = this;

      axios.put('admin/categories/update', {
            id        : this.category_id,
            name      : this.category_name,
            parent_id : this.category_parent_id,
          },
          {
            headers: {
              'Authorization': 'Bearer '+localStorage.getItem('authToken')
            }
          }).then(function (response) {
        console.log(response)
        if (response.data.status_code == 200) {

          _that.error_message    = '';
          _that.success_message  = response.data.messages;
          _that.$emit('category-edit-data',"category updated successfully");
          document.body.classList.remove('open-side-slider')

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
                  isAdmin : 1,
                  without_pagination : 1
                },

          })
          .then(function (response) {
            if(response.data.status_code === 200){
              console.log(response.data);
              _that.categoryList = response.data.category_list;
            }
            else{
              _that.success_message = "";
              _that.error_message   = response.data.error;
            }
          })
    },

    getCategoryDetails() {

      let _that = this;
      let categoryID = this.category_id;
      console.log("article Id " + categoryID);
      let apiUrl = "admin/categories/";

      axios.get(apiUrl+categoryID,
          {
            headers: {
              'Authorization': 'Bearer ' + localStorage.getItem('authToken')
            },
          })
          .then(function (response) {
            if (response.data.status_code === 200) {
              console.log(response.data);
              _that.categoryDetails       = response.data.category_info;

              _that.category_name =  _that.categoryDetails.name;
              _that.category_parent_id =  _that.categoryDetails.parent_id;

            } else {
              _that.success_message = "";
              _that.error_message = response.data.error;
            }
          })
    },

  },

  created() {

    this.category_id = this.categoryId;
    console.log("category_id" + this.category_id);
    this.getCategoryDetails();
    this.getCategoryList();
    this.isEdit = this.isEditCheck;
    console.log(this.isEditCheck)

  }
}
</script>

<style scoped>

</style>