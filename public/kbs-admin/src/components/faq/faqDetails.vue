<template>
  <div class="col-md-12 wrapper d-flex align-items-stretch">
    <Menu></Menu>

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
                <h3 class="nk-block-title page-title text-left">Faq Details</h3>
              </div>
            </div>
          </div>
          <div  class="card card-bordered card-preview">
            <div class="card-body">

              <h2>{{ faqDetails.en_title  }}</h2>
              <h5>{{ faqDetails.publish_date  }}, <span style="font-style: italic;color:#C0C0C0;">author: {{ faqDetails.user ? (faqDetails.user.first_name + ' ' + faqDetails.user.last_name) : ''   }}</span></h5>

              <p>{{ faqDetails.en_body  }}</p>
            </div>

            <div class="card-footer">
              <div class="row">
                <router-link :to="{ name: 'faqList'}" class="btn btn-info">
                  Faq List
                </router-link>

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
name: "faqDetails.vue",
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
      userInfo        : '',
      filter : {
        isAdmin : 1
      }
    }
  },

  methods: {
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
              console.log(response.data);
              _that.faqDetails = response.data.faq_info;
            } else {
              _that.success_message = "";
              _that.error_message = response.data.error;
            }
          })
    },
  },

  created() {

    this.faq_id = this.$route.params.id;
    //console.log(this.faq_id);
    this.getFaqDetails();
  }
}
</script>

<style scoped>

</style>