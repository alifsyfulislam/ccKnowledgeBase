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
                                <div class="col-sm-4">
                                    <h3 class="card-title ">
                                        Quiz Form Field List
                                    </h3>
                                </div>

                                <div class="col-sm-8 text-right">
                                    <router-link :to="{ name: 'quizFormFieldAdd', params: { id: quizform_ID }}" class="btn btn-secondary m-1">
                                        Add
                                    </router-link>
                                </div>

                            </div>

                            <div class="row mt-4">
                                <div class="col">
                                    <div class="table-responsive text-nowrap">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th>Quiz Form ID</th>
                                                <th>Label Name</th>
                                                <th>Field Type</th>
                                                <th>Required</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            <tr v-for="a_quiz_form_field in quizformfields" :key="a_quiz_form_field">
                                                <td>{{ a_quiz_form_field.id  }}</td>
                                                <td>{{ a_quiz_form_field.f_label  }}</td>
                                                <td>{{ a_quiz_form_field.f_type  }}</td>
                                                <td>{{ a_quiz_form_field.f_required==1 ? "Yes":"No" }}</td>

                                                <!--                                                <td>{{ a_quiz_form_field.slug  }}</td>-->

                                                <td>
                                                    <router-link :to="{ name: 'quizFormFieldEdit', params: { id: a_quiz_form_field.id }}" class="btn btn-primary m-1">
                                                        Edit
                                                    </router-link>



                                                    <a href="#" class="btn btn-danger m-1" data-toggle="modal"  :data-target="'#deleteModal_'+ a_quiz_form_field.id">Delete</a>

                                                    <div class="modal col-md-offset-2 fade" :id="'deleteModal_'+ a_quiz_form_field.id" role="dialog">
                                                        <div class="modal-dialog">

                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h6 class="modal-title">Confirmation for This Deleting Quiz From Field</h6>
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
                                                                    <button @click="quizformfieldDelete(a_quiz_form_field.id)" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
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
        name: "quizFormFieldList.vue",
        components: {
            Header,
            Menu
        },

        data() {
            return {
                selfID:'',
                quizform_ID :'',
                quizform_details:'',
                quizformfields:[],
                quizformfield_details:'',
            }
        },
        methods: {
            clearFilter()
            {

            },

            quizformfieldDetails(){
                let _that =this;
                axios.get('admin/quiz-form-fields',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },

                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                          console.log(response.data);
                            _that.success_message = "";
                            _that.quizformfield_details = response.data.quiz_form_field_list.data;
                            _that.quizformfield_details.forEach(val =>{
                                if (val.quiz_form_id == _that.quizform_ID){
                                    _that.quizformfields.push(val);
                                }
                            })
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },

            quizformfieldDelete(val) {
                let _that = this;
                console.log(val);

                axios.delete('admin/quiz-form-fields/delete',
                    {
                        data:
                            {
                                id      : val
                            },
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    }).then(function (response) {
                        console.log(response.data.status_code)

                    if (response.data.status_code == 200)
                    {
                        _that.$router.push('/quizformView');
                        // _that.getQuizFormList();
                        _that.error_message   = '';
                        _that.success_message = "Delete Quiz Form Field Successfully";
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
            this.quizform_ID = this.$route.params.id;
            this.quizformfieldDetails();
        }
    }
</script>

<style scoped>

</style>





