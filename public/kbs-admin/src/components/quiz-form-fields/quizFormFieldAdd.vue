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
                                <h3 class="nk-block-title page-title text-left">Add Quiz Form Field</h3>
                            </div>
                        </div>
                    </div>
                    <div  class="card card-bordered card-preview">
                        <div class="card-body">
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Quiz Form ID</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" readonly v-model="quizform_ID" class="form-control form-control-lg" placeholder="">
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Quiz Form Title</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" readonly v-model="quizform_details.name" class="form-control form-control-lg" placeholder="">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Label Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="formData.quizlabelName" class="form-control form-control-lg" placeholder="Enter Label Name">
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="formData.quizfieldName" class="form-control form-control-lg" placeholder="Enter Field Name">
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field ID</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="formData.quizfieldID"  class="form-control form-control-lg" placeholder="Enter Field ID">
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Class</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="formData.quizfieldClass" class="form-control form-control-lg" placeholder="Enter Field Class">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Type</label>
                                </div>
                                <div class="col-md-8">
                                    <select class="form-control" v-model="formData.quizfieldType">
                                        <option>--Select Type--</option>
                                        <option value="Text">Text</option>
                                        <option value="Email">Email</option>
                                        <option value="Password">Password</option>
                                        <option value="Number">Number</option>
                                        <option value="Textarea">Textarea</option>
                                        <option value="Radio">Radio</option>
                                        <option value="Checkbox">Checkbox</option>
                                        <option value="Select/Dropdown">Select/Dropdown</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Option Value</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="formData.quizfieldOptionValue"  class="form-control form-control-lg" placeholder="Enter Field Option Value">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Default Value</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="formData.quizfieldDefaultValue"  class="form-control form-control-lg" placeholder="Enter Field Default Value">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Max Value</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="number" v-model="formData.quizfieldMaxValue"  class="form-control form-control-lg" placeholder="Enter Field Max Value">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Sort Value</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="number"  v-model="formData.quizfieldSortValue" class="form-control form-control-lg" placeholder="Enter Field Sort Value">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Required</label>
                                </div>
                                <div class="col-md-8">
                                    <select class="form-control" v-model="formData.quizfieldRequired">
                                        <option>--Select Status--</option>
                                        <option value="1">Yes</option>
                                        <option value="0">No</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3" >
                                    <button class="btn btn-info" @click="quizformfieldStore()">Save</button>
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
        name: "storeQuizFormField",
        components: {
            Header,
            Menu
        },
        data(){
            return {
                formData:{
                    quizformfieldID: '',
                    quizlabelName:'',
                    quizfieldName:'',
                    quizfieldID:'',
                    quizfieldClass:'',
                    quizfieldType:'--Select Type--',
                    quizfieldOptionValue:'',
                    quizfieldDefaultValue:'',
                    quizfieldMaxValue:'',
                    quizfieldSortValue:'',
                    quizfieldRequired:'--Select Status--',
                },
                success_message : '',
                error_message   : '',
                quizform_ID:'',
                quizform_details:''
            }
        },
        methods:{
            quizformfieldStore() {
                let _that = this;
                axios.post('admin/quiz-form-fields',
                    {
                        quiz_form_id            :this.quizform_ID,
                        f_label                 :this.formData.quizlabelName,
                        f_name                  :this.formData.quizfieldName,
                        f_id                    :this.formData.quizfieldID,
                        f_class                 :this.formData.quizfieldClass,
                        f_type                  :this.formData.quizfieldType,
                        f_option_value          :this.formData.quizfieldOptionValue,
                        f_default_value         :this.formData.quizfieldDefaultValue,
                        f_max_value             :this.formData.quizfieldMaxValue,
                        f_sort_order            :this.formData.quizfieldSortValue,
                        f_required              :this.formData.quizfieldRequired,
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    console.log(response.data.status_code)
                    if (response.data.status_code == 201)
                    {
                        console.log(response.data.status_code)
                        _that.$router.push('/admin/quizFormList');
                        _that.error_message    = '';
                        _that.success_message  = "Updated Successfully";

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