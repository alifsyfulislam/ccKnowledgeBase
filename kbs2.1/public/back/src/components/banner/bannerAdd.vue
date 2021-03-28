<template>
    <div class="right-sidebar-content-wrapper position-relative overflow-hidden" v-if="isAddCheck">
        <div class="right-sidebar-content-area px-2">
            <div class="form-wrapper">
                <h2 class="section-title text-uppercase mb-20">Add New Banner</h2>

                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="categoryName">Banner Title <span class="required">*</span></label>
                            <input class="form-control" type="text" v-model="bannerData.title" id="categoryName" placeholder="Enter Banner Title" required>
                            <span id="categoryNameError" class="small text-danger category_name" role="alert">
                                {{ error_messages[0] }}
                            </span>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label  class="d-block">Image</label>
                            <input type="file" id="files" ref="files" @change="onLogoFileChange" >
                        </div>
                    </div>

                    <div class="col-md-12" v-if="logo_url">
                        <div class="form-group" >
                            <img v-if="logo_file.type != 'video/mp4' && logo_file.type != 'audio/ogg' &&  logo_file.type != 'video/quicktime'" class="preview" style="height:250px; width: auto" :src="logo_url"/>

                            <video class="preview" v-else controls>-->
                                <source :src="logo_url" type="video/mp4">
                                <source :src="logo_url" type="video/ogg">
                                Your browser does not support the video tag.
                            </video>
                        </div>
                    </div>


                    <div class="col-md-12">
                        <div class="form-group mb-0">
                            <label>Roles <span class="required">*</span><span id="roleIdError_2" class="text-danger small"></span></label>
                            <ul class="list-unstyled permission-list m-0 p-0">
                                <li v-for="a_user in user_roles" :key="a_user.id" class="text-left pb-2">
                                    <div v-if="roleAccess.includes(a_user.id)" class="d-flex align-items-center">
                                        <label class="mb-0 ml-2"><input  checked type="checkbox" :value="a_user.id"  v-model="roleAccess"> {{ a_user.name }} </label>
                                    </div>
                                    <div v-else class="d-flex align-items-center">
                                        <label class="mb-0 ml-2"><input type="checkbox" v-model="roleAccess" :value="a_user.id"> {{ a_user.name }} </label>
                                    </div>

                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="fileStatus">Status<span class="required">*</span></label>
                            <select id="fileStatus" class="form-control" v-model="bannerData.status">
                                <option value="0">Inactive</option>
                                <option value="1">Active</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-group text-right">
                    <button class="btn common-gradient-btn ripple-btn px-50" @click="bannerAdd()">Add</button>
                </div>
            </div>

        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import $ from "jquery";

    export default {

        name: "bannerAdd",
        props: ['isAddCheck'],
        data() {
            return {
                success_message  : '',
                error_messages   : [],

                bannerData : {
                    title : '',
                    status: 1
                },

                logo_file        : '',
                logo_url         : '',
                user_roles : '',
                roleAccess          : [],

            }
        },
        methods: {
            getUserRoles()
            {
                let _that =this;
                axios.get('roles',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },
                        params : {
                            isAdmin : 1,
                            without_pagination : 1
                        },
                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){

                            _that.user_roles = response.data.role_list;

                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },

            onLogoFileChange(e) {
                this.logo_file = e.target.files[0];
                this.logo_url = URL.createObjectURL(this.logo_file);
            },


            //category add
            bannerAdd(){

                let _that = this;
                let formData = new FormData();

                formData.append('banner_file', _that.logo_file);
                formData.append('title', _that.bannerData.title);
                formData.append('role_id', _that.roleAccess);
                formData.append('status', _that.bannerData.status);

                // console.log(_that.banner_file.type);
                // console.log(_that.bannerData);
                // console.log(formData);

                console.log(this.logo_file);

                axios.post('banners', formData,
                    {
                        headers: {
                            'Content-Type'  : 'multipart/form-data',
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                        console.log(response)
                        if (response.data.status_code === 200){

                            _that.bannerData          = '';
                            _that.error_messages        = '';
                            _that.success_message       = "Banner Added Successfully";
                            _that.$emit('banner-slide-close', _that.success_message);
                        }
                        else if(response.data.status_code === 400){
                            _that.success_message       = "";
                            _that.error_message         = "";
                        // _that.showServerError(response.data.errors);

                        }
                        else{
                            _that.success_message       = "";
                            _that.error_message         = response.data.message;
                        }
                }).catch(errors => console.log(errors));



            },
        },

        created(){
            this.getUserRoles();
        }
    }
</script>

<style scoped>

</style>
