<template>
    <div class="col-md-12 wrapper d-flex align-items-stretch">
        <Menu></Menu>

        <!-- Page Content  -->
        <div class="col-md-9" style="margin-left:40px; ">

            <Header></Header>

            <div class="row">
                <div class="col-md-12">
                    <div v-if="success_message" class="alert alert-success" role="alert">
                        {{ success_message }}
                    </div>
                    <div v-if="error_message" class="alert alert-danger" role="alert">
                        {{ error_message }}
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h4 class="card-title ">
                                        Roles List
                                    </h4>
                                </div>

                                <div class="col-sm-9 text-right">
                                    <router-link :to="{ name: 'roleAdd'}" class="btn btn-primary">
                                        + Add New
                                    </router-link>
                                </div>

                            </div>

                            <div class="row mt-4">
                                <div class="col">
                                    <div class="table-responsive text-nowrap">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th>Role Type</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            <tr v-for="a_role in userRoles" :key="a_role">
                                                <td>{{ a_role.name  }}</td>

                                                <td>
                                                    <router-link :to="{ name: 'roleEdit', params: { id: a_role.id }}" class="btn btn-info">
                                                        Edit
                                                    </router-link>

                                                    <a v-if="a_role.name!= 'Super Admin'" href="#" class="btn btn-danger ml-1" data-toggle="modal"  :data-target="'#deleteModal_'+ a_role.id">Delete</a>

                                                    <div class="modal col-md-offset-2 fade" :id="'deleteModal_'+ a_role.id" role="dialog">
                                                        <div class="modal-dialog">

                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h4 class="modal-title">Confirmation for Deleting Category</h4>
                                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="col-md-12">
                                                                        <div class="col-md-10">
                                                                            <h6>Are You Sure to delete?</h6>
                                                                        </div>
                                                                    </div>

                                                                </div>

                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                                                    <button @click="deleteRole(a_role.id)" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </td>

                                            </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div><!--col-->
                            </div><!--row-->
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
        name: "rolesList",
        components: {
            Header,
            Menu
        },
        data (){
            return {
                userRoles : '',
            }
        },
        methods: {
            getRolesList(){
                let _that =this;

                axios.get('admin/roles',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            console.log(response.data.role_list);
                            _that.success_message = "";
                            _that.userRoles = response.data.role_list;
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },

          deleteRole(roleId) {
            let _that = this;

            axios.delete('admin/roles/delete',
                {
                  data:
                      {
                        id      : roleId
                      },
                  headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                  },
                }).then(function (response) {

              if (response.data.status_code == 200)
              {
                _that.getRolesList();
                _that.error_message   = '';
                _that.success_message = "Role Deleted Successfully";
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
        },
        created() {
            this.getRolesList();
        }
    }
</script>

<style scoped>

</style>
