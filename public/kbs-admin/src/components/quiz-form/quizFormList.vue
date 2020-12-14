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
                                        Quiz Form List
                                    </h4>
                                </div>

                                <div class="col-sm-9 text-right">
                                    <router-link :to="{ name: 'quizFormAdd'}" class="btn btn-primary">
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
                                                <th>Name</th>
                                                <th>Quiz Form Field</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            <tr v-for="a_quiz_form in quizformsList" :key="a_quiz_form">
                                                <td>{{ a_quiz_form.id  }}</td>
                                                <td>{{ a_quiz_form.name  }}</td>

                                                <td>
                                                    <router-link :to="{ name: 'quizFormFieldAdd', params: { id: a_quiz_form.id }}" class="btn btn-secondary m-1">
                                                        Add
                                                    </router-link>

                                                    <router-link :to="{ name: 'quizFormFieldList', params: { id: a_quiz_form.id }}" class="btn btn-primary m-1">
                                                        View
                                                    </router-link>
                                                </td>

                                                <td>
                                                    <router-link :to="{ name: 'quizFormEdit', params: { id: a_quiz_form.id }}" class="btn btn-info ">
                                                        Edit
                                                    </router-link>

                                                    <a href="#" class="btn btn-danger" data-toggle="modal"  :data-target="'#deleteModal_'+ a_quiz_form.id">Delete</a>

                                                    <div class="modal col-md-offset-2 fade" :id="'deleteModal_'+ a_quiz_form.id" role="dialog">
                                                        <div class="modal-dialog">

                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h4 class="modal-title">Confirmation for This Deleting Quiz From</h4>
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
                                                                    <button @click="quizformDelete(a_quiz_form.id)" type="button" class="btn btn-success" data-dismiss="modal">Delete</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </td>

                                            </tr>

                                            </tbody>
                                        </table>
                                    </div>
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
        name: "quizFormList.vue",
        components: {
            Header,
            Menu
        },

        data() {
            return {
                quizformsList:'',
                quizformField_all:''
            }
        },
        methods: {

            getQuizFormList(){
                let _that =this;

                axios.get('quiz-forms',
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            // console.log(response.data.quiz_form_list.data);
                            _that.quizformsList = response.data.quiz_form_list.data;
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },

            quizformDelete(quizformID) {

              let _that = this;

              axios.delete('admin/quiz-forms/delete',
                    {
                        data:
                            {
                                id      : quizformID
                            },
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    }).then(function (response) {

                    if (response.data.status_code == 200)
                    {
                        _that.getQuizFormList();
                        _that.error_message   = '';
                        _that.success_message = "Delete Quiz Form Successfully";
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
            this.getQuizFormList();
        }
    }
</script>

<style scoped>

</style>


