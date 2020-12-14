<template>
    <div class="col-md-12 wrapper d-flex align-items-stretch">
        <Menu></Menu>

        <!-- Page Content  -->
        <div id="content" style="margin-left:50px; ">

            <Header></Header>

          <div v-if="isLoading" class="loader-overlay">
            <div class="loader"></div>
            <span class="text" >Hello Loader</span>
          </div>

<!--          <div  v-if="isLoading">
            <div class="full-screen overlay">
              <div class="center">
                <img  src="@/assets/image2.png" alt="loading image">
              </div>
            </div>

          </div>-->

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
                                <h3 class="nk-block-title page-title text-left">Add a New Role</h3>
                            </div>
                        </div>
                    </div>
                    <div  class="card card-bordered card-preview">
                        <div class="card-body">
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Role Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="roles" class="form-control" placeholder="Add a unique role">
                                </div>
                            </div>
                            <h3 class="text-center">Add Permission</h3>

                            <div class="row">
                                <div v-for="permission in allPermissions" :key="permission" class="text-left col-md-8 offset-4">
                                    <input type="checkbox" v-model="selectedCheckboxes" :value="permission.id" v-bind:id="permission.id" ><label>{{ permission.name }} </label><br><br>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3" >
                                    <button class="btn btn-info" @click="addRole()">Add</button>
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
        name: "rolesAdd.vue",
        components: {
            Header,
            Menu
        },

        data() {
            return {
                refCount: 0,
                isLoading : false,
                success_message : '',
                error_message   : '',
                token           : '',
                rolesDetails      : '',
                roles_ID          :  '',
                allRoles  :'',
                allPermissions  :'',
                roles_info:'',
                roles:'',
                selectedCheckboxes:[],
                isIndex:'',
                filter : {
                    isAdmin : 1
                }
            }
        },

        methods: {

          setLoading(isLoading) {
            if (isLoading) {
              this.refCount++;
              this.isLoading = true;
            } else if (this.refCount > 0) {
              this.refCount--;
              this.isLoading = (this.refCount > 0);
            }
          },

            addRole(){
                let _that = this;

                axios.post('admin/roles',
                    {
                        name: this.roles,
                        permission: this.selectedCheckboxes
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    console.log(response.data);
                    if (response.data.status_code == 200) {
                        _that.success_message = "Add a role with permission!";
                        _that.$router.push('/admin/roleList');
                    } else {
                        _that.success_message = "";
                        _that.error_message = response.data.error;
                    }

                }).catch(function (error) {
                    console.log(error);
                });
            },

            getAllPermission() {
                let _that = this;
                _that.isLoading = true;
                axios.get('admin/permissions',
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                      _that.isLoading = false;
                        if (response.data.status_code === 200) {
                            _that.allPermissions = response.data.permission_list;
                        } else {
                            _that.success_message = "";
                            _that.error_message = response.data.error;
                        }
                    })
            },

        },

        created() {

            this.getAllPermission();
        }
    }
</script>

<style scoped>
.loader-overlay {
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.7);
  z-index: 999;
  cursor: pointer;
span.text {
  display: inline-block;
  position: relative;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  color: #fff;
}
.loader {
  animation: loader-animate 1.5s linear infinite;
  clip: rect(0, 80px, 80px, 40px);
  height: 80px;
  width: 80px;
  position: absolute;
  left: calc(50% - 40px);
  top: calc(50% - 40px);
&:after {
   animation: loader-animate-after 1.5s ease-in-out infinite;
   clip: rect(0, 80px, 80px, 40px);
   content: '';
   border-radius: 50%;
   height: 80px;
   width: 80px;
   position: absolute;
 }
}
@keyframes loader-animate {
  0% {
    transform: rotate(0deg)
  }
  100% {
    transform: rotate(220deg)
  }
}
@keyframes loader-animate-after {
  0% {
    box-shadow: inset #fff 0 0 0 17px;
    transform: rotate(-140deg);
  }
  50% {
    box-shadow: inset #fff 0 0 0 2px;
  }
  100% {
    box-shadow: inset #fff 0 0 0 17px;
    transform: rotate(140deg);
  }
}
}
</style>
