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
                                        User List
                                    </h4>
                                </div>

                                <div class="col-sm-9 text-right">
                                    <router-link :to="{ name: 'customerAdd'}" class="btn btn-primary">
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
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Email</th>
                                                <th>Role</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            <tr v-for="a_user in userList"   :key="a_user">
                                                <td >{{ a_user.id  }}</td>
                                                <td >{{ a_user.username  }}</td>
                                                <td >{{ a_user.email  }}</td>
                                                <td >{{ ((a_user.roles).length > 0 ) ?  a_user.roles[0].name : ''  }}</td>

                                                <td >
                                                    <router-link :to="{ name: 'customerEdit', params: { id: a_user.id }}" class="btn btn-info ">
                                                        Edit
                                                    </router-link>

                                                    <a href="#" class="btn btn-danger" data-toggle="modal"  :data-target="'#deleteModal_'+ a_user.id">Delete</a>

                                                    <div class="modal col-md-offset-2 fade" :id="'deleteModal_'+ a_user.id" role="dialog">
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
                                                                    <button @click="deleteUser(a_user.id)" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
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
        name: "customerList.vue",
        components: {
            Header,
            Menu
        },

        data() {
            return {
                success_message : '',
                error_message   : '',
                token           : '',
                categoryList    : '',
                articleList     : '',
                userList        : '',
                userRole        : '',

                filter : {
                    isAdmin     : 1,
                    status      : '',
                }
            }
        },
        methods: {
            clearFilter()
            {
                this.filter.category_id = "";
                this.filter.status   = "";
                this.filter.en_title = "";
                this.filter.tag      = "";
                this.success_message = "";
                this.error_message   = "";
                this.getUsersList();
            },

            getUsersList()
            {
                let _that =this;

                axios.get('admin/users',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                      console.log(response.data.user_list.data);
                        if(response.data.status_code === 200){
                          let tempUserData = [];
                          (response.data.user_list.data).forEach( user => {
                            if ((user.roles).length > 0)
                            {
                              if((user.roles[0].name) != 'Super Admin')
                              {
                                tempUserData.push(user);
                              }
                            }
                            else
                            {
                              tempUserData.push(user);
                            }
                          });
                          _that.userList   = tempUserData;
                          _that.success_message = "";
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },

            deleteUser(userId) {
                let _that = this;

                axios.delete('admin/users/delete',
                    {
                        data:
                            {
                                id  : userId
                            },
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    }).then(function (response) {

                    if (response.data.status_code == 200)
                    {
                        _that.getUsersList();
                        _that.error_message   = '';
                        _that.success_message = response.data.messages;
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
            this.getUsersList();
        }
    }
</script>

<style scoped>

</style>
