<template>
    <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isAdd===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker"></button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Add New Quiz Form</h2>

                    <div class="row">
                        <div class="col-md-12">
                            <div v-if="success_message" class="alert alert-success" role="alert">
                                {{ success_message }}
                            </div>
                            <div v-if="error_message" class="alert alert-danger" role="alert">
                                {{ error_message }}
                            </div>
                        </div>

                        <div class="col-md-9">
                            <div class="form-group">
                                <label for="quizFormName">Quiz Form Name <span class="required">*</span></label>
                                <input class="form-control" type="text" v-model="quizFormData.name" v-on:keyup.enter="quizFormAdd()"  id="quizFormName" placeholder="Enter quiz form name here!!" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group text-left">
                                <button class="btn common-gradient-btn ripple-btn px-50" @click="quizFormAdd()">Add</button>
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
    // import $ from 'jquery'


    export default {
        name: "quizFormFieldAdd.vue",
        props: ['isAddFieldCheck','quizFormId'],
        components: {

        },

        data() {
            return {
                isAdd : false,
                isSearch        : false,

                success_message : '',
                error_message   : '',
                token           : '',
                userRoles       :'',

                quizFormData        : {
                    name  : '',
                },

            }
        },


        methods: {

            clearAllChecker()
            {
                this.isAdd = false;
                this.$emit('quiz-form-field-data', this.isAdd);

            },

            quizFormAdd() {
                let _that = this;

                axios.post('admin/quiz-forms',
                    {
                        name: this.quizFormData.name,
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    if (response.data.status_code == 201)
                    {
                        _that.error_message    = '';
                        _that.success_message  = "New Customer Added Successfully";
                        _that.$emit('quiz-form-field-data', _that.quizFormData);
                        document.body.classList.remove('open-side-slider')
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
            this.isAdd = this.isAddFieldCheck;
            console.log(this.quizFormId);
        }
    }
</script>

<style scoped>

</style>
