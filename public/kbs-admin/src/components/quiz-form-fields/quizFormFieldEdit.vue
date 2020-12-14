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
            </div>


            <div class="row">
                <div class="col-md-9">
                    <div class="nk-block-head nk-block-head-sm">
                        <div class="nk-block-between">
                            <div class="nk-block-head-content">
                                <h3 class="nk-block-title page-title text-left">Update Quiz Form Field</h3>
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
                                    <input type="text" readonly v-model="quizformfield_info.quiz_form_id" class="form-control form-control-lg" placeholder="">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Label Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="quizformfield_info.f_label" class="form-control form-control-lg" placeholder="Enter Label Name">
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Name</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="quizformfield_info.f_name" class="form-control form-control-lg" placeholder="Enter Field Name">
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field ID</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="quizformfield_info.f_id"  class="form-control form-control-lg" placeholder="Enter Field ID">
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Class</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="quizformfield_info.f_class" class="form-control form-control-lg" placeholder="Enter Field Class">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Type</label>
                                </div>
                                <div class="col-md-8">
                                    <select class="form-control" v-model="quizformfield_info.f_type">
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
                                    <input type="text" v-model="quizformfield_info.f_option_value"  class="form-control form-control-lg">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Default Value</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="quizformfield_info.f_default_value"  class="form-control form-control-lg">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Max Value</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text" v-model="quizformfield_info.f_max_value"  class="form-control form-control-lg">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Sort Value</label>
                                </div>
                                <div class="col-md-8">
                                    <input type="text"  v-model="quizformfield_info.f_sort_order" class="form-control form-control-lg" placeholder="Enter Field Sort Value">
                                </div>
                            </div>

                            <div class="row form-group">
                                <div class="col-md-4">
                                    <label class="form-label">Field Required</label>
                                </div>
                                <div class="col-md-8">
                                    <select class="form-control" v-model="quizformfield_info.f_required">
                                        <option>--Select Status--</option>
                                        <option value="1">Yes</option>
                                        <option value="0">No</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3" >
                                    <button class="btn btn-info" @click="quizformfieldUpdate()">Update</button>
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
        name: "quizFormFieldEdit.vue",
        components: {
            Header,
            Menu
        },

        data() {
            return {
                quizformfield_ID :'',
                quizformfield_info:'',
                quizformfield_details:'',
            }
        },
        methods: {

            quizformfieldUpdate() {
                let _that = this;
                let quizformfieldID = _that.quizformfield_ID;

                axios.put('admin/quiz-form-fields/update',
                    {
                        id               : quizformfieldID,
                        quiz_form_id     : _that.quizformfield_info.quiz_form_id,
                        f_label          : _that.quizformfield_info.f_label,
                        f_name           : _that.quizformfield_info.f_name,
                        f_id             : _that.quizformfield_info.f_id,
                        f_class          : _that.quizformfield_info.f_class,
                        f_type           : _that.quizformfield_info.f_type,
                        f_option_value   : _that.quizformfield_info.f_option_value,
                        f_default_value  : _that.quizformfield_info.f_default_value,
                        f_max_value      : _that.quizformfield_info.f_max_value,
                        f_sort_order     : _that.quizformfield_info.f_sort_order,
                        f_required       : _that.quizformfield_info.f_required,
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

            quizformfieldDetails(){
                let _that =this;
                let quizformfieldID = _that.quizformfield_ID
                axios.get('admin/quiz-form-fields/'+quizformfieldID,
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },

                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            _that.success_message = "";
                            _that.quizformfield_info = response.data.quiz_form_field_info;
                            console.log(_that.quizformfield_info);
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },
        },
        created() {
            this.quizformfield_ID = this.$route.params.id;
            this.quizformfieldDetails();
        }
    }
</script>

<style scoped>

</style>