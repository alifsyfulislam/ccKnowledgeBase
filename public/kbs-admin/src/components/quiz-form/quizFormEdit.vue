<template>

    <div v-cloak class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isEdit===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                <img src="../../assets/img/cancel.svg" alt="cancel">
            </button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Quiz Form Edit</h2>

                    <div class="row">
                        <div class="col-md-12">
                            <div v-if="success_message" class="alert alert-success" role="alert">
                                {{ success_message }}
                            </div>
                            <div v-if="error_message" class="alert alert-danger" role="alert">
                                {{ error_message }}
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormName">Quiz Form Name<span class="required">*</span></label>
                                <input class="form-control" v-on:keyup.enter="quizFormUpdate()" type="text" v-model="quizFormDetails.name"  id="quizFormName" placeholder="Enter first name here!!" required>
                            </div>
                        </div>


                        <div class="col-md-8">
                            <div class="form-group text-left">
                                <button class="btn common-gradient-btn ripple-btn px-50" @click="quizFormUpdate()">Update</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</template>

<script>
    import axios from "axios";

    export default {

        name: "quizFormEdit.vue",
        components: {
        },
        props: ['isEditCheck', 'quizFormId'],

        data() {
            return {
                isMounted : false,
                isEdit : false,
                success_message : '',
                error_message   : '',
                token           : '',
                selectedId:'',
                quizFormDetails:'',
                roles:'',
                userRoles:'',
                filter : {
                    isAdmin : 1
                }
            }
        },

        methods: {
            quizFormUpdate() {
                let _that = this;
                let quizFormID = _that.selectedId;

                axios.put('admin/quiz-forms/update',
                    {
                        id        : quizFormID,
                        name      : _that.quizFormDetails.name,
                    },
                    {
                        headers: {
                            'Authorization': 'Bearer '+localStorage.getItem('authToken')
                        }
                    }).then(function (response) {
                    if (response.data.status_code == 200)
                    {
                        _that.error_message    = '';
                        _that.success_message  = " Updated Successfully";
                        _that.$emit('quiz-form-edit-data', _that.quizFormDetails);
                        document.body.classList.remove('open-side-slider');
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

            getQuizFormDetails() {
                let _that = this;
                let quizFormID = this.selectedId;

                axios.get("admin/quiz-forms/"+quizFormID,
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if (response.data.status_code === 200) {
                            _that.quizFormDetails = response.data.quiz_form_info;
                        } else {
                            _that.success_message = "";
                            _that.error_message = response.data.error;
                        }
                    })
            },

            clearAllChecker()
            {
                this.isEdit = false;
                this.$emit('quiz-form-edit-data', this.isEdit);
            },
        },

        created() {
            this.selectedId = this.quizFormId;
            this.isEdit = this.isEditCheck;
            this.getQuizFormDetails();
        }
    }
</script>

<style scoped>

</style>
