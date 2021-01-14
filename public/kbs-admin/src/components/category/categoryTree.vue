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
            <div class="content-area" >
                <div class="content-title-wrapper px-15 py-10">
                    <h2 class="content-title text-uppercase m-0">Category List</h2>
                </div>
                <div class="content-wrapper bg-white">
                    <!-- list top area -->
                    <div class="list-top-area px-15 py-10 d-sm-flex justify-content-between align-items-center">
                        <div class="adding-btn-area d-md-flex align-items-center">
                            <div>
                                <button class="btn common-gradient-btn ripple-btn new-agent-session right-side-common-form mx-10 m-w-140 px-15 mb-10 mb-md-0"
                                        @click="isAddCheck=true" v-if="checkPermission('category-create')">
                                    <i class="fas fa-plus"></i>
                                    Add Category
                                </button>
                            </div>
                        </div>

                        <div class="reload-download-expand-area">
                            <ul class="list-inline d-inline-flex align-items-center justify-content-end mb-0 w-100">
                                <li>
                                    <button class="reload-btn">
                                        <div class="d-flex jsutify-content-center align-items-center">
                                            <i class="fas fa-sync"></i> <span class="hide-on-responsive">Reload</span>
                                        </div>
                                    </button>
                                </li>

                                <li>
                                    <a v-if="isExportCheck"
                                       :href=downloadUrl class="download-btn" title="Download CSV">
                                        <i class="fas fa-download"></i> <span class="hide-on-responsive">Download CSV</span>
                                    </a>
                                </li>

                                <li><button class="screen-expand-btn"><i class="fas fa-expand-arrows-alt"></i> <span class="hide-on-responsive">Full Screen</span></button></li>
                            </ul>
                        </div>
                    </div>
                    <!-- list top area end -->
                    <!-- Content Area -->
                    <div class="data-content-area px-15 py-10">
                        <Loading v-if="isLoading===true"></Loading>



                        <ul id="demo">
                            <tree-item v-if="isTree" class="item" :item="treeData" @make-folder="makeFolder" @add-item="addItem"></tree-item>
                        </ul>



                    </div>
                    <!-- Content Area End -->
                </div>
            </div>
            <!-- Content Area End -->
        </div>
        <!-- Common Right SideBar -->
        <div class="action-modal-wraper" v-if="success_message">
            <span>{{ success_message }}</span>
        </div>

        <div class="action-modal-wraper-error" v-if="error_message">
            <span>{{ error_message }}</span>
        </div>
        <!--        work-->
        <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70">
            <div class="close-bar d-flex align-items-center justify-content-end">
                <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                    <img src="../../assets/img/cancel.svg" alt="cancel">
                </button>
            </div>
            <!--            add data-->
            <CategoryAdd v-if="isAddCheck" :isAddCheck="isAddCheck" @category-slide-close="getAddDataFromChild"></CategoryAdd>
            <!--            edit data-->
            <CategoryEdit v-if="isEditCheck" :isEditCheck="isEditCheck" :categoryId="category_id" @category-slide-close="getEditDataFromChild"></CategoryEdit>
            <!--            delete data -->
            <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isDeleteCheck">
                <div class="right-sidebar-content-area px-2">

                    <div class="form-wrapper">
                        <h2 class="section-title text-uppercase mb-20">Delete</h2>

                        <div class="row mt-50 mt-md-80">
                            <div class="col-md-12">
                                <figure class="mx-auto text-center">
                                    <img class="img-fluid mxw-100" src="../../assets/img/delete-big-icon.svg" alt="delete-big">
                                </figure>
                                <p class="text-center"> Confirmation for Deleting Category</p>
                                <div class="form-group d-flex justify-content-center align-items-center">
                                    <button type="button" class="btn btn-danger rounded-pill ripple-btn px-30 mx-2" @click="deleteCategory()"><i class="fas fa-trash"></i> Confirm</button>
                                    <button type="button" class="btn btn-outline-secondary rounded-pill px-30 mx-2" @click="removingRightSideWrapper(), isDeleteCheck=false"><i class="fas fa-times-circle" ></i> Cancel</button>
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
import axios from 'axios'
import Menu from '@/layouts/common/Menu'
import Header from '@/layouts/common/Header'
import CategoryAdd from "@/components/category/categoryAdd";
import CategoryEdit from "@/components/category/categoryEdit";
import Loading from "@/components/loader/loading";
import TreeItem from "./TreeItem";
import $ from "jquery";


$(document).on('click','.screen-expand-btn',()  => {
    $('.content-wrapper').toggleClass('expandable-content-area');
});


export default {
    name: "categoryTree.vue",


    template: "",


    components: {
        Header,
        Menu,
        CategoryAdd,
        CategoryEdit,
        Loading,
        TreeItem
    },

    data() {
        return {
            isTree : false,

            // treeData : {
            //     name: "My Tree",
            //     parent_recursive: [
            //         { name: "hello" },
            //         { name: "wat" },
            //         {
            //             name: "child folder",
            //             parent_recursive: [
            //                 {
            //                     name: "child folder",
            //                     parent_recursive: [{ name: "hello" }, { name: "wat" }]
            //                 },
            //                 { name: "hello" },
            //                 { name: "wat" },
            //                 {
            //                     name: "child folder",
            //                     parent_recursive: [{ name: "hello" }, { name: "wat" }]
            //                 }
            //             ]
            //         }
            //     ]
            // },

            treeData : '',




            isLoading           : false,

            isEditCheck         : false,
            isAddCheck          : false,
            isDeleteCheck       : false,
            isExportCheck        :false,

            isSearch            : false,

            category_id         : '',
            category_parent_id  : '',
            category_name       : '',
            success_message     : '',
            error_message       : '',
            token               : '',
            categoryList        : '',
            userInfo            : '',
            downloadUrl         : '/categories/export/',

            user_permissions : '',
            mappedPermission : '',

            filter      : {
                isAdmin         : 1,
                name            : ''
            },

            pagination  :{
                from            : '',
                to              : '',
                first_page_url  : '',
                last_page       : '',
                last_page_url   : '',
                next_page_url   :'',
                prev_page_url   : '',
                path            : '',
                per_page        : 10,
                total           : ''
            },

        }
    },
    methods: {

        makeFolder: function(item)
        {
            this.set(item, "parent_recursive", []);
            this.addItem(item);
        },

        addItem: function(item)
        {
            item.parent_recursive.push({
                name: "new stuff"
            });
        },

        removingRightSideWrapper()
        {
            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;

            document.body.classList.remove('open-side-slider');
            $('.right-sidebar-wrapper').toggleClass('right-side-common-form-show');
        },

        clearAllChecker()
        {
            this.isAddCheck         = false;
            this.isEditCheck        = false;
            this.isDeleteCheck      = false;
        },

        getAddDataFromChild (status)
        {
            this.success_message = status;
            this.getCategoryList();
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },

        getEditDataFromChild (status)
        {
            this.success_message = status;
            this.getCategoryList();
            this.removingRightSideWrapper();
            this.setTimeoutElements();
        },

        getCategoryList(pageUrl)
        {
            let _that = this;

            pageUrl = pageUrl == undefined ? 'admin/categories' : pageUrl;

            axios.get(pageUrl,
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    },
                    params :
                        {
                            isAdmin : 1
                        },
                })
                .then(function (response)
                {
                    if(response.data.status_code === 200)
                    {
                        _that.isTree = true;
                        _that.categoryList      = response.data.category_list.data;
                        // console.log(_that.categoryList);
                        _that.makeChildrenTree(_that.categoryList);
                        _that.pagination        = response.data.category_list;
                        _that.isLoading         = false;
                        _that.isExportCheck     = true;
                        // console.log(_that.pagination.total);
                    }
                    else
                    {
                        _that.success_message   = "";
                        _that.error_message     = response.data.error;
                    }
                });

        },

        makeChildrenTree(treeData){
            console.log(treeData)

            treeData.forEach((val,index) =>{
                if (val.parent_id!=0){
                    console.log(val + " "+ index)
                }
            })
            // let element = [];
            //
            // let parent_recursive = [];
            //
            // this.treeData.forEach((val,index) =>{
            //
            //     element[index] = {
            //         name : val.name, children : parent_recursive[index] = val.parent_recursive
            //     };
            //
            //
            // })
            //
            // console.log(element);
        },

        categoryUpdate(categoryId)
        {
            let _that = this;

            axios.put('admin/categories/update', {
                    id              : categoryId,
                    name            : this.category_name,
                    parent_id       : this.category_parent_id,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                if (response.data.status_code == 200) {
                    _that.getCategoryList();
                    _that.selectedCategory      = '';
                    _that.error_message         = '';
                    _that.success_message       = response.data.messages;

                }
                else {
                    _that.success_message       = "";
                    _that.error_message         = response.data.error;
                }
            }).catch(function (error) {
                console.log(error);
            });

        },

        deleteCategory()
        {
            let _that = this;

            axios.delete('admin/categories/delete',
                {
                    data:
                        {
                            id      : this.category_id
                        },
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                }).then(function (response) {

                if (response.data.status_code == 200) {
                    _that.getCategoryList();
                    _that.removingRightSideWrapper();
                    _that.error_message         = '';
                    _that.success_message       = "Category Deleted Successfully";
                    _that.setTimeoutElements();

                } else {
                    _that.success_message       = "";
                    _that.error_message         = response.data.error;

                }

            }).catch(function (error) {
                console.log(error);
            });
        },
        //alert message remove
        setTimeoutElements()
        {
            // setTimeout(() => this.isLoading = false, 3e3);
            setTimeout(() => this.success_message = "", 2e3);
            setTimeout(() => this.error_message = "", 2e3);
        },

        checkPermission(permissionForCheck)
        {
            if((this.mappedPermission).includes(permissionForCheck) === true) {
                return true;
            } else {
                return false;
            }
        },

    },
    created()
    {
        this.isLoading = true;
        this.getCategoryList();
        this.user_permissions = JSON.parse(localStorage.getItem("userPermissions"));
        this.mappedPermission = (this.user_permissions ).map(x => x.slug);
        this.downloadUrl = axios.defaults.baseURL+this.downloadUrl;
        this.getCategoryList();
    }
}
</script>

<style scoped>
.mhv-100 {
    min-height: 50vh;
}
</style>
