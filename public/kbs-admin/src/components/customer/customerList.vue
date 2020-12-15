<template>
    <div class="col-md-12 wrapper d-flex align-items-stretch">
        <Menu></Menu>
        <div class="main-content-wrapper w-100 position-relative overflow-auto bg-white" >
            <!-- Topbar -->
            <Header></Header>

            <!-- Topbar End -->

            <!-- Content Area -->
            <div class="content-area">
                <div class="content-title-wrapper px-15 py-10">
                    <h2 class="content-title text-uppercase m-0">Customer List</h2>
                </div>

                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center">
                            <div class="d-flex align-items-center">
                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="isAddCheck=true">
                                    <i class="fas fa-plus"></i>
                                    Add User
                                </button>
<!--                                <button class="btn common-gradient-btn  new-agent-session  mx-10 m-w-140 px-15 mb-10 mb-md-0" @click="clearFilter()">-->
<!--                                    <i class="fa fa-refresh"></i>-->
<!--                                    Refresh-->
<!--                                </button>-->
                            </div>
<!--                            <div class="search-box-wrapper d-flex align-items-center mb-10 mb-md-0">-->
<!--                                <button class="btn common-gradient-btn ripple-btn search-btn right-side-common-form text-white" @click="isSearch=true">-->
<!--                                    <i class="fas fa-search"></i> <span class="ml-1">Search</span>-->
<!--                                </button>-->
<!--                            </div>-->
                        </div>
                    </div>

                    <!-- list top area end -->


                    <!-- Content Area -->
                    <div class="data-content-area px-15 py-10">
                        <!-- Table Data -->
                        <div class="table-responsive">
                            <table class="table table-bordered gsl-table">
                                <thead>
                                <tr>
                                    <th class="text-center">SL</th>
                                    <th class="text-center">First Name</th>
                                    <th class="text-center">Last Name</th>
                                    <th class="text-center">Email</th>
                                    <th class="text-center">Enroll Date</th>
                                    <th class="text-center">Action</th>
                                </tr>
                                </thead>
                                <tbody>

                                <tr v-for="(a_user,index) in userList" :key="a_user.id">
                                    <td class="text-center">{{++index}}</td>
                                    <td class="text-center">{{ a_user.first_name }}</td>
                                    <td class="text-center">{{ a_user.last_name }}</td>
                                    <td class="text-center">{{ a_user.email }}</td>
                                    <td class="text-center">{{ a_user.created_at }}</td>

                                    <td class="text-center" style="min-width: 120px">

                                        <button class="btn btn-success ripple-btn right-side-common-form btn-xs m-1"  @click="customer_id = a_user.id, isEditCheck=true"><i class="fas fa-pen"></i></button>
                                        <button  class="btn btn-danger ripple-btn right-side-common-form btn-xs m-1" @click="customer_id = a_user.id, isDelete=true"><i class="fas fa-trash-restore-alt"></i></button>
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                        <!-- Table Data End -->
                    </div>

                    <!-- Content Area End -->
                </div>
            </div>

            <div class="action-modal-wraper" v-if="success_message">
                <span>{{ success_message }}</span>
            </div>

            <div class="action-modal-wraper-error" v-if="error_message">
                <span>{{ error_message }}</span>
            </div>

            <CustomerAdd v-if="isAddCheck" :isAddCheck= "isAddCheck" @customer-data="getUserDataFromAdd"></CustomerAdd>

            <CustomerEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :customerId="customer_id" @customer-edit-data="getCustomerDataFromEdit"></CustomerEdit>


            <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isDelete===true">
                <div class="close-bar d-flex align-items-center justify-content-end">
                    <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
                </div>

                <div class="right-sidebar-content-wrapper position-relative overflow-hidden">
                    <div class="right-sidebar-content-area px-2">

                        <div class="form-wrapper">
                            <h2 class="section-title text-uppercase mb-20">Customer Delete</h2>

                            <div class="row mt-50 mt-md-80">
                                <div class="col-md-12">
                                    <figure class="mx-auto text-center">
                                        <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                    </figure>
                                    <p class="text-center"> Confirmation for Deleting Customer</p>

                                    <div class="form-group d-flex justify-content-center align-items-center">
                                        <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteCustomer()"><i class="fas fa-trash"></i> Confirm</button>
                                        <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper()"><i class="fas fa-times-circle" ></i> Cancel</button>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <!-- Content Area End -->
        </div>
    </div>
</template>

<script>
    import Header from "@/layouts/common/Header";
    import Menu from "@/layouts/common/Menu";
    import CustomerAdd from "@/components/customer/customerAdd";
    import CustomerEdit from "@/components/customer/customerEdit";
    import axios from "axios";

    export default {
        name: "customerList.vue",
        components: {
            Header,
            Menu,
            CustomerAdd,
            CustomerEdit
        },

        data() {
            return {

                isAddCheck      : false,
                isEditCheck     : false,
                isDelete        : false,

                success_message : '',
                error_message   : '',
                token           : '',
                categoryList    : '',
                articleList     : '',
                userList        : '',
                userRole        : '',
                customer_id     : '',


                filter : {
                    isAdmin     : 1,
                    status      : '',
                }
            }
        },
        methods: {
            setTimeoutElements()
            {
                setTimeout(() => this.success_message = "", 3000);
                setTimeout(() => this.error_message = "", 3000);
            },

            deleteCustomer() {
                let _that = this;

                axios.delete('admin/users/delete',
                    {
                        data:
                            {
                                id      : _that.customer_id
                            },
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    }).then(function (response) {

                    if (response.data.status_code == 200)
                    {
                        _that.getUsersList();
                        _that.error_message   = '';
                        _that.isAddCheck      = false;
                        _that.isDelete        = false;
                        _that.isSearch        = false;

                        document.body.classList.remove('open-side-slider');
                        _that.success_message = "Successfully deleted the User";
                        _that.setTimeoutElements();

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


            removingRightSideWrapper()
            {
                this.isAddCheck = false;
                this.isDelete   = false;
                // this.isSearch   = false;
                document.body.classList.remove('open-side-slider');
            },

            clearAllChecker()
            {
                this.isAddCheck = false;
            },
            // clearFilter()
            // {
            //     this.filter.category_id = "";
            //     this.filter.status   = "";
            //     this.filter.en_title = "";
            //     this.filter.tag      = "";
            //     this.success_message = "";
            //     this.error_message   = "";
            //     this.getUsersList();
            // },

            getUserDataFromAdd (newData) {
                console.log(newData)
                //this.articleList.push(newData);
                this.isAddCheck = false;
                this.getUsersList();
                //this.inboundData.formData = newData
            },
            getCustomerDataFromEdit (newEditData) {
                console.log(newEditData)
                this.isEditCheck = false;
                this.getUsersList();
                //this.inboundData.formData = newData
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
                            console.log(_that.userList);
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
