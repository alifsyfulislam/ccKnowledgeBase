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
                    <h2 class="content-title text-uppercase m-0">FAQ Details</h2>
                    <router-link :to="{ name: 'faqList'}" class="btn btn-primary btn-xs m-1 px-15 py-2">
                        <i class="fas fa-arrow-left"></i> Back
                    </router-link>
                </div>


                <div class="content-wrapper bg-white" v-if="faqDetails">
                    <div class="data-content-area px-15 py-10">
                        <h3 class="">{{faqDetails.en_title}}</h3>



                        <p class="font-16"><strong>Tags: </strong>{{faqDetails.tag}}</p>
                        <div class="ta-wrapper d-flex align-items-center py-10 my-25">
                            <div class="avatar mr-10">
                                <img class="img-fluid" src="@/assets/image.png" style="height: 50px; width: 50px" alt="avatar">
                            </div>
                            <div class="tc-wrapper">
                                <h5 v-cloak class="my-0 pb-1">{{faqDetails.user.first_name}} {{faqDetails.user.last_name}}</h5>
                                <p class="mb-0">Post on: {{faqDetails.created_at}}</p>
                            </div>
                        </div>

                        <!--              <div class="ta-content-wrapper">
                                        <h3 class="">{{aArticle.en_title}}</h3>
                                      </div>-->

                        <div class="ta-content-wrapper">
                            <p class="text-justify" v-html="faqDetails.en_body"></p>
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
