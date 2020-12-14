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
                <h3 class="nk-block-title page-title text-left">Update Faq</h3>
              </div>
            </div>
          </div>
          <div  class="card card-bordered card-preview">
            <div class="card-body">

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label">Question</label>
                </div>
                <div class="col-md-8">
                  <input type="text" class="form-control form-control-lg" v-model="faqData.en_title" placeholder="Enter English Title">
                </div>

              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label">Select A Category</label>
                </div>
                <div class="col-md-8">
                  <select class="form-control" v-model="selectedCategory">
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
                  <input type="text" class="form-control form-control-lg" v-model="faqData.tag" placeholder="Ex. Horror, Thriller">
                </div>

              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label" >Answer</label>
                </div>
                <div class="col-md-8">
                  <textarea cols="30" rows="6" class="form-control form-control-lg" v-model="faqData.en_body"></textarea>
                </div>

              </div>

              <div class="row form-group">
                <div class="col-md-4">
                  <label class="form-label">Select A Status</label>
                </div>
                <div class="col-md-8">
                  <select class="form-control" v-model="faqData.status">
                    <option value="">Select A Status</option>
                    <option value="draft">Draft</option>
                    <option value="hide">Hide</option>
                    <option value="private">Private</option>
                    <option value="public">Public</option>

                  </select>
                </div>
              </div>


              <div class="row">
                <div class="col-md-3" >
                  <button class="btn btn-info" @click="faqUpdate()">Update</button>
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
name: "faqEdit.vue",
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
      faqDetails      : '',
      faq_id          :  '',
      categoryList    :  '',

      selectedCategory  : '',
      faqData        : {
        en_title  : '',
        bn_title  : '',
        tag  : '',
        en_body  : '',
        bn_body  : '',
        status  : '',
      },
      filter : {
        isAdmin : 1
      }
    }
  },

  methods: {
    faqUpdate() {
      let _that = this;
      let faqID = this.faq_id;

      axios.put('admin/faqs/update',
          {
            id            : faqID,
            category_id   : this.selectedCategory,
            en_title      : this.faqData.en_title,
            tag           : this.faqData.tag,
            en_body       : this.faqData.en_body,
            status        : this.faqData.status,
          },
          {
            headers: {
              'Authorization': 'Bearer '+localStorage.getItem('authToken')
            }
          }).then(function (response) {
        if (response.data.status_code == 200)
        {
          _that.faqData          = '';
          _that.selectedCategory = '';
          _that.error_message    = '';
          _that.success_message  = " Faq Updated Successfully";
          _that.$router.push('/admin/faqList');
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

    getFaqDetails() {
      let _that = this;
      let faqID = this.faq_id;

      let apiUrl = "admin/faqs/";

      axios.get(apiUrl+faqID,
          {
            headers: {
              'Authorization': 'Bearer ' + localStorage.getItem('authToken')
            },
          })
          .then(function (response) {
            if (response.data.status_code === 200) {
              //console.log(response.data);
              _that.faqDetails = response.data.faq_info;
              _that.selectedCategory = _that.faqDetails.category_id;
              _that.faqData.en_title = _that.faqDetails.en_title;
              _that.faqData.tag = _that.faqDetails.tag;
              _that.faqData.en_body = _that.faqDetails.en_body;
              _that.faqData.status = _that.faqDetails.status;
            } else {
              _that.success_message = "";
              _that.error_message = response.data.error;
            }
          })
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
              //console.log(response.data);
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
    this.faq_id = this.$route.params.id;
    this.getFaqDetails();
    this.getCategoryList();
  }
}
</script>

<style scoped>

</style>