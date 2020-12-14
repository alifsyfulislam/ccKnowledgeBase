<template>
    <div class="col-md-12 wrapper d-flex align-items-stretch">
        <Menu></Menu>

        <!-- Page Content  -->
        <div id="content" style="margin-left:50px; ">

            <Header></Header>

            <div class="col-md-12">
                <div v-if="success_message_2" class="alert alert-warning" role="alert">
                    {{ success_message_2 }}
                </div>
                <div v-else class="hide" role="alert"></div>
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
                                <h3 class="nk-block-title page-title text-left">Edit Quiz Form</h3>
                            </div>
                        </div>
                    </div>
                    <div  class="card card-bordered card-preview">
                        <div class="card-body">

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="quizform_details.name" class="form-control form-control-lg" placeholder="">
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-md-3" >
                                    <button class="btn btn-info" @click="quizformUpdate()">Save</button>
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
    import Menu from '@/layouts/common/Menu.vue'
    import Header from '@/layouts/common/Header.vue'
    export default {
        name: "quizFormEdit",
        components: {
            Header,
            Menu
        },
        data(){
            return {
                formData:{
                    name: '',
                },
                success_message : '',
                error_message   : '',
                quizform_ID:'',
                quizform_details:''
            }
        },
        methods:{
            quizformUpdate() {

                let _that = this;
                let quizformID = this.quizform_ID;

                axios.put('admin/quiz-forms/update',
                    {
                        id    : quizformID,
                        name  : this.quizform_details.name,
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    if (response.data.status_code == 200)
                    {
                        _that.error_message    = '';
                        _that.success_message  = "Updated Successfully";
                        _that.$router.push('/admin/quizFormList');
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
            quizformDetails() {
                let _that = this;
                let quizformID = this.quizform_ID;

                axios.get("admin/quiz-forms/"+quizformID,
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if (response.data.status_code === 200) {
                            console.log(response.data.quiz_form_info)
                            _that.quizform_details= response.data.quiz_form_info
                        } else {
                            _that.success_message = "";
                            _that.error_message = response.data.error;
                        }
                    })
            },
        },
        created() {
            this.quizform_ID = this.$route.params.id;
            this.quizformDetails();
        }
    }
</script>

<style scoped>

</style>