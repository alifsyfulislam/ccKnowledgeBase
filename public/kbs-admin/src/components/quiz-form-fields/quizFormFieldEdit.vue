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
                    <h2 class="section-title text-uppercase mb-20">Quiz Form Field Edit</h2>

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
                            <div class="form-group">
                                <label for="quizFormID">Quiz Form ID <span class="required">*</span></label>
                                <input id="quizFormID" type="text" readonly v-model="quizFormFieldDetails.quiz_form_id" class="form-control" placeholder="">
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldLabel">Field Label <span class="required">*</span></label>
                                <input id="quizFormFieldLabel" type="text" v-model="quizFormFieldDetails.f_label" class="form-control" placeholder="Enter Label Name">
                                <span id="fieldLabelError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldName">Field Name <span class="required">*</span></label>
                                <input id="quizFormFieldName" type="text" v-model="quizFormFieldDetails.f_name" class="form-control" placeholder="Enter Field Name">
                                <span id="fieldNameError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldID">Field ID <span class="required">*</span></label>
                                <input id="quizFormFieldID" type="text" v-model="quizFormFieldDetails.f_id"  class="form-control" placeholder="Enter Field ID">
                                <span id="fieldIDError" class="text-danger small"></span>
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldClass">Field Class <span class="required">*</span></label>
                                <input id="quizFormFieldClass" type="text" v-model="quizFormFieldDetails.f_class"  class="form-control" placeholder="Enter Field Class">
                                <span id="fieldClassError" class="text-danger small"></span>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldType">Field Type <span class="required">*</span></label>
                                <select id="quizFormFieldType" class="form-control" v-model="quizFormFieldDetails.f_type">
                                    <option value="" disabled>--Select A Type--</option>
                                    <option value="Text">Text</option>
                                    <option value="Email">Email</option>
                                    <option value="Password">Password</option>
                                    <option value="Number">Number</option>
                                    <option value="Textarea">Textarea</option>
                                    <option value="Radio">Radio</option>
                                    <option value="Checkbox">Checkbox</option>
                                    <option value="Select/Dropdown">Select/Dropdown</option>
                                </select>
                                <span id="fieldTypeError" class="text-danger small"></span>
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldOptionValue">Field Option Value</label>
                                <input id="quizFormFieldOptionValue" type="text" v-model="quizFormFieldDetails.f_option_value"  class="form-control" placeholder="Enter Field Option Value">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldOptionDefaultValue">Question Answer</label>
                                <input id="quizFormFieldOptionDefaultValue" type="text" v-model="quizFormFieldDetails.f_default_value"  class="form-control" placeholder="Enter Field Option Default Value">
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldMaxValue">Field Max Value</label>
                                <input id="quizFormFieldMaxValue" type="number" v-model="quizFormFieldDetails.f_max_value"  class="form-control" placeholder="Enter Max Number">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldSortValue">Field Sort Value</label>
                                <input id="quizFormFieldSortValue" type="number" v-model="quizFormFieldDetails.f_sort_order"  class="form-control" placeholder="Enter Sort Number">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldRequired">Field Required <span class="required">*</span></label>


                                <select id="quizFormFieldRequired" class="form-control" v-model="quizFormFieldDetails.f_required">
                                    <option disabled>--Select Status--</option>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="form-group text-left">
                                <button class="btn common-gradient-btn ripple-btn px-50" @click="quizFormFieldUpdate">Update</button>
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
    import $ from "jquery";

    export default {

        name: "quizFormFieldEdit.vue",
        components: {
        },
        props: ['isEditCheck', 'quizFormFieldId'],

        data() {
            return {
                isMounted : false,
                isEdit : false,
                success_message : '',
                error_message   : '',
                token           : '',
                selectedId:'',
                quizFormFieldDetails:'',
                roles:'',
                userRoles:'',
                filter : {
                    isAdmin : 1
                }
            }
        },

        methods: {

            showServerError(errors){

                $('#fieldLabelError').html("");
                $('#fieldNameError').html("");
                $('#fieldIDError').html("");
                $('#fieldClassError').html("");
                $('#fieldTypeError').html("");

                $('#quizFormFieldLabel').css({'border-color': '#ced4da'});
                $('#quizFormFieldName').css({'border-color': '#ced4da'});
                $('#quizFormFieldID').css({'border-color': '#ced4da'});
                $('#quizFormFieldClass').css({'border-color': '#ced4da'});
                $('#quizFormFieldType').css({'border-color': '#ced4da'});

                errors.forEach(val=>{

                    if (val.includes("f label") === true){

                        $('#fieldLabelError').html(val)
                        $('#quizFormFieldLabel').css({'border-color': '#FF7B88'});
                    }else if(val.includes("f name") === true){
                        $('#fieldNameError').html(val)
                        $('#quizFormFieldName').css({'border-color': '#FF7B88'});

                    }else if(val.includes("f id") === true){
                        $('#fieldIDError').html(val)
                        $('#quizFormFieldID').css({'border-color': '#FF7B88'});

                    }else if(val.includes("f class") === true){
                        $('#fieldClassError').html(val)
                        $('#quizFormFieldClass').css({'border-color': '#FF7B88'});

                    }else if(val.includes("f type") === true){
                        $('#fieldTypeError').html(val)
                        $('#quizFormFieldType').css({'border-color': '#FF7B88'});
                    }

                })
            },

            quizFormFieldUpdate() {
                let _that = this;
                let quizFormFieldID = _that.selectedId;

                axios.put('admin/quiz-form-fields/update',
                    {
                        id                      : quizFormFieldID,
                        quiz_form_id            :_that.quizFormFieldDetails.quiz_form_id,
                        f_label                 :_that.quizFormFieldDetails.f_label,
                        f_name                  :_that.quizFormFieldDetails.f_name,
                        f_id                    :_that.quizFormFieldDetails.f_id,
                        f_class                 :_that.quizFormFieldDetails.f_class,
                        f_type                  :_that.quizFormFieldDetails.f_type,
                        f_option_value          :_that.quizFormFieldDetails.f_option_value,
                        f_default_value         :_that.quizFormFieldDetails.f_default_value,
                        f_max_value             :_that.quizFormFieldDetails.f_max_value,
                        f_sort_order            :_that.quizFormFieldDetails.f_sort_order,
                        f_required              :_that.quizFormFieldDetails.f_required,
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
                        _that.$emit('quiz-form-field-data', _that.quizFormFieldDetails);
                        document.body.classList.remove('open-side-slider');
                    }else if(response.data.status_code === 400){

                        _that.success_message = "";
                        _that.error_message   = "";
                        _that.showServerError(response.data.errors);

                    }else{
                        _that.success_message  = "";
                        _that.error_message    = response.data.message;
                    }

                }).catch(function (error) {
                    console.log(error);
                });

            },

            getQuizFormFieldDetails() {
                let _that = this;
                let quizFormFieldID = _that.selectedId;
                axios.get("admin/quiz-form-fields/"+quizFormFieldID,
                    {
                        headers: {
                            'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                        },
                    })
                    .then(function (response) {
                        if (response.data.status_code === 200) {
                            _that.quizFormFieldDetails = response.data.quiz_form_field_info;
                        } else {
                            _that.success_message = "";
                            _that.error_message = response.data.error;
                        }
                    })
            },

            clearAllChecker()
            {
                this.isEdit = false;
                this.$emit('quiz-form-field-data', this.isEdit);
            },
        },

        created() {
            this.selectedId = this.quizFormFieldId;
            this.isEdit = this.isEditCheck;
            this.getQuizFormFieldDetails();
        }
    }
</script>

<style scoped>

</style>
