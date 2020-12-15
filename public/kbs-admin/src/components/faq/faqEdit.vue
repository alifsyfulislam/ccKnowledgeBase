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
  </div>-->

    <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isEdit===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">FAQ Update</h2>

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
                                <label for="faqID">Title <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="faqData.en_title" id="faqID" required>
                            </div>
                        </div>

                        <div class="col-md-6" v-if="selected_language==='bangla'">
                            <div class="form-group">
                                <label>Bangla Title </label>
                                <input class="form-control" type="text" v-model="faqData.bn_title" >
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
                                <input class="form-control" type="text" v-model="faqData.tag" id="tag">
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group mb-15">
                                <label >English Body</label>
                                <SummernoteEdit v-if="isMounted"   :idFromParent="enBody" :dataFromParent="enBodyData"></SummernoteEdit>

                            </div>
                        </div>

                        <div class="col-md-12" v-if="selected_language==='bangla'">
                            <div class="form-group mb-15">
                                <label >Bangla Body</label>
                                <SummernoteEdit  :idFromParent="bnBody" :dataFromParent="bnBodyData"></SummernoteEdit>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Select A Status</label>
                                <select class="form-control" v-model="faqData.status">
                                    <option value="draft">Draft</option>
                                    <option value="hide">Hide</option>
                                    <option value="private">Private</option>
                                    <option value="public">Public</option>
                                </select>
                            </div>
                        </div>

                    </div>


                    <div class="form-group text-right">
                        <button class="btn common-gradient-btn ripple-btn px-50" @click="faqUpdate()">Update</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import SummernoteEdit from "@/components/summer-note/summernote-edit";

export default {
    name: "faqEdit.vue",
    components: {
        SummernoteEdit
    },

    props: ['isEditCheck', 'faqId'],

    data() {
        return {
            isMounted : false,
            isEdit : false,
            enBody : "en_Body",
            bnBody : "bn_Body",
            selected_language  : 'english',

            enBodyData : '',
            bnBodyData : '',

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

      clearAllChecker()
      {
          this.isEdit = false;
          this.$emit('article-edit-data', this.isEdit);
      },

      faqUpdate() {
          let _that = this;
          let faqID = this.faq_id;
          let enBody = document.getElementById('en_Body').value;

          if (!(document.getElementById('bn_Body'))) {
            var bnBody = '';
          } else {
              bnBody  = document.getElementById('bn_Body').value;
          }

          axios.put('admin/faqs/update',
              {
                id            : faqID,
                category_id   : this.selectedCategory,
                en_title      : this.faqData.en_title,
                tag           : this.faqData.tag,
                en_body       : enBody,
                bn_body       : bnBody,
                status        : this.faqData.status,
              },
              {
                headers: {
                  'Authorization': 'Bearer '+localStorage.getItem('authToken')
                }
              }).then(function (response) {
            if (response.data.status_code == 200) {
                _that.faqData          = '';
                _that.selectedCategory = '';
                _that.error_message    = '';
                _that.success_message  = " Faq Updated Successfully";

                _that.isEdit = false;
                _that.$emit('faq-edit-data', _that.faqData);
                document.body.classList.remove('open-side-slider')
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
                    _that.faqDetails       = response.data.faq_info;

                    _that.selectedCategory  = _that.faqDetails.category_id;
                    _that.faqData.en_title  = _that.faqDetails.en_title;
                    _that.faqData.bn_title  = _that.faqDetails.bn_title;
                    _that.faqData.tag       = _that.faqDetails.tag;
                    _that.faqData.en_body   = _that.faqDetails.en_body;
                    _that.faqData.bn_body   = _that.faqDetails.bn_body;
                    _that.faqData.status    = _that.faqDetails.status;

                    _that.enBodyData        = _that.faqDetails.en_body;
                    _that.bnBodyData        = _that.faqDetails.bn_body;
                    _that.isMounted         = true;

                    //console.log('enBody', + _that.enBodyData);

                } else {
                  _that.success_message = "";
                  _that.error_message = response.data.error;
                }
              })
        },

        getCategoryList(){

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
                  //console.log(response.data);
                  _that.categoryList = response.data.category_list;
                }
                else{
                  _that.success_message = "";
                  _that.error_message   = response.data.error;
                }
              })
        },

  },

  created() {
      this.faq_id = this.faqId;

      console.log("faq_id" + this.faq_id);
      this.getFaqDetails();
      this.getCategoryList();
      this.isEdit = this.isEditCheck;

      console.log(this.isEditCheck)
  }
}
</script>

<style scoped>

</style>
