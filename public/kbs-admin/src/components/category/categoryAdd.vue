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
                <h3 class="nk-block-title page-title text-left">Add New Category</h3>
              </div>
            </div>
          </div>
          <div  class="card card-bordered card-preview">
            <div class="card-body">

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label" >Name</label>
                  </div>
                  <div class="col-md-8">
                    <input type="text" class="form-control form-control-lg" v-model="categoryData.name" placeholder="Enter Category Name">
                  </div>

                </div>

                <div class="row form-group">
                  <div class="col-md-4">
                    <label class="form-label">Select A Parent</label>
                  </div>
                  <div class="col-md-8">
                    <select class="form-control" v-model="selectedCategory">
                      <option value="">Select A Parent Category</option>
                      <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                        {{a_category.name}}
                      </option>
                    </select>
                  </div>
                </div>

                <div class="row">
                    <div class="col-md-3" >
                      <button class="btn btn-info" @click="categoryAdd()">Save</button>
                    </div>
                </div>

            </div>
          </div>

        </div>
      </div>

    </div>
  </div>-->

  <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isAdd===true">
    <div class="close-bar d-flex align-items-center justify-content-end">
      <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
    </div>

    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
      <div class="right-sidebar-content-area px-2">

        <div class="form-wrapper">
          <h2 class="section-title text-uppercase mb-20">Add New Category</h2>

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
                <label for="name">Name <span class="required">*</span></label>
                <input class="form-control" type="text" v-model="categoryData.name" id="name" placeholder="Enter Category Name" required>
              </div>
            </div>

            <div class="col-md-12">
              <div class="form-group">
                <label>Select A Parent</label>

                <select class="form-control" v-model="selectedCategory">
                  <option value="">Select A Category</option>
                  <option v-for="a_category in categoryList" :value="a_category.id" :key="a_category">
                    {{a_category.name}}
                  </option>
                </select>
              </div>
            </div>

          </div>

          <div class="form-group text-right">
            <button class="btn common-gradient-btn ripple-btn px-50" @click="categoryAdd()">Add</button>
          </div>
        </div>

      </div>
    </div>
  </div>

</template>

<script>
import axios from 'axios'

export default {
  name: "categoryAdd.vue",
  props: ['isAddCheck'],
  data() {
    return {
      success_message : '',
      error_message   : '',
      token           : '',
      categoryList    : '',
      selectedCategory  : '',
      userInfo        : '',
      categoryData        : {
        name  : '',
      },
    }
  },
  methods: {

    clearAllChecker() {

      this.isAdd = false;
      this.$emit('category-data', this.isAdd);

    },

    categoryAdd() {
      let _that = this;

      axios.post('admin/categories', {

            name      : this.categoryData.name,
            parent_id : this.selectedCategory,
      },
          {
            headers: {
              'Authorization': 'Bearer '+localStorage.getItem('authToken')
            }
          }).then(function (response) {
        console.log(response)
        if (response.data.status_code == 200)
        {
          _that.categoryData     = '';
          _that.selectedCategory = '';
          _that.error_message    = '';
          _that.success_message  = "New Category Added Successfully";
          _that.$emit('category-data', _that.categoryData);
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

  },
  created() {
    this.isAdd = this.isAddCheck;
    console.log(this.isAddCheck)
    this.getCategoryList();
  }
}
</script>

<style scoped>

</style>