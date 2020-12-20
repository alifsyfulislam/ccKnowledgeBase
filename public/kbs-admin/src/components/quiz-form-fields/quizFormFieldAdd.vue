<template>
    <div class="right-sidebar-wrapper with-upper-shape fixed-top px-20 pb-30 pb-md-40 pt-70" v-if="isAdd===true">
        <div class="close-bar d-flex align-items-center justify-content-end">
            <button class="right-side-close-btn ripple-btn-danger" @click="clearAllChecker">
                <img src="../../assets/img/cancel.svg" alt="cancel">
            </button>
        </div>

        <div class="right-sidebar-content-wrapper position-relative overflow-hidden" >
            <div class="right-sidebar-content-area px-2">

                <div class="form-wrapper">
                    <h2 class="section-title text-uppercase mb-20">Add New Quiz Field in <span class="text-info">{{quizform_details.name}}</span></h2>

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
                                <label for="quizFormID">Quiz Form ID <span class="required">*</span></label>
                                <input id="quizFormID" type="text" readonly v-model="selectedFormID" class="form-control" placeholder="">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormName">Quiz Form Name <span class="required">*</span></label>
                                <input id="quizFormName" type="text" readonly v-model="quizform_details.name" class="form-control" placeholder="">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldLabel">Field Label <span class="required">*</span></label>
                                <input id="quizFormFieldLabel" type="text" v-model="quizFormFieldData.quizlabelName" class="form-control" placeholder="Enter Label Name">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldName">Field Name <span class="required">*</span></label>
                                <input id="quizFormFieldName" type="text" v-model="quizFormFieldData.quizfieldName" class="form-control" placeholder="Enter Field Name">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldID">Field ID <span class="required">*</span></label>
                                <input id="quizFormFieldID" type="text" v-model="quizFormFieldData.quizfieldID"  class="form-control" placeholder="Enter Field ID">
<!--                                <input id="quizFormFieldName" type="text" v-model="quizform_details.quizfieldName" class="form-control form-control-lg" placeholder="Enter Field Name">-->
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldClass">Field Class <span class="required">*</span></label>
                                <input id="quizFormFieldClass" type="text" v-model="quizFormFieldData.quizfieldClass"  class="form-control" placeholder="Enter Field Class">
<!--                                <input id="quizFormFieldName" type="text" v-model="quizform_details.quizfieldName" class="form-control form-control-lg" placeholder="Enter Field Name">-->
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldType">Field Type <span class="required">*</span></label>
                                <select id="quizFormFieldType" class="form-control" v-model="quizFormFieldData.quizfieldType">
                                    <option disabled>--Select A Type--</option>
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

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldOptionValue">Field Option Value <span class="required">*</span></label>
                                <input id="quizFormFieldOptionValue" type="text" v-model="quizFormFieldData.quizfieldOptionValue"  class="form-control" placeholder="Enter Field Option Value">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldOptionDefaultValue">Field Option Default Value <span class="required">*</span></label>
                                <input id="quizFormFieldOptionDefaultValue" type="text" v-model="quizFormFieldData.quizfieldDefaultValue"  class="form-control" placeholder="Enter Field Option Default Value">
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldMaxValue">Field Max Value <span class="required">*</span></label>
                                <input id="quizFormFieldMaxValue" type="number" v-model="quizFormFieldData.quizfieldMaxValue"  class="form-control" placeholder="Enter Max Number">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldSortValue">Field Sort Value <span class="required">*</span></label>
                                <input id="quizFormFieldSortValue" type="number" v-model="quizFormFieldData.quizfieldSortValue"  class="form-control" placeholder="Enter Sort Number">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quizFormFieldRequired">Field Required <span class="required">*</span></label>


                                <select id="quizFormFieldRequired" class="form-control" v-model="quizFormFieldData.quizfieldRequired">
                                    <option disabled>--Select Status--</option>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group text-left">
                                <button class="btn common-gradient-btn ripple-btn px-50" @click="quizformfieldStore()">Add</button>
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
            isAdd                   : false,
            isSearch                : false,

            success_message         : '',
            error_message           : '',
            token                   : '',
            quizform_details        :'',
            selectedFormID          : '',

            isFormFieldList         : false,


            quizFormFieldData       : {
                quizformfieldID     : '',
                quizlabelName       :'',
                quizfieldName       :'',
                quizfieldID         :'',
                quizfieldClass      :'',
                quizfieldType       :'--Select A Type--',
                quizfieldOptionValue:'',
                quizfieldDefaultValue:'',
                quizfieldMaxValue   :'',
                quizfieldSortValue  :'',
                quizfieldRequired   :'--Select Status--',
            },

        }
    },

    methods: {
        clearAllChecker() {

            this.isAdd = false;
            this.isFormFieldList = false;

            this.$emit('quiz-form-field-data', this.isFormFieldList);

        },
        quizformfieldStore() {
            let _that = this;
            axios.post('admin/quiz-form-fields',
                {
                    quiz_form_id    : _that.selectedFormID,
                    f_label         : _that.quizFormFieldData.quizlabelName,
                    f_name          : _that.quizFormFieldData.quizfieldName,
                    f_id            : _that.quizFormFieldData.quizfieldID,
                    f_class         : _that.quizFormFieldData.quizfieldClass,
                    f_type          : _that.quizFormFieldData.quizfieldType,
                    f_option_value  : _that.quizFormFieldData.quizfieldOptionValue,
                    f_default_value : _that.quizFormFieldData.quizfieldDefaultValue,
                    f_max_value     : _that.quizFormFieldData.quizfieldMaxValue,
                    f_sort_order    : _that.quizFormFieldData.quizfieldSortValue,
                    f_required      : _that.quizFormFieldData.quizfieldRequired,
                },
                {
                    headers: {
                        'Authorization': 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (response) {
                if (response.data.status_code == 201) {

                    _that.error_message    = '';
                    _that.success_message  = "Field Added Successfully";

                    _that.isFormFieldList = true;
                    _that.$emit('quiz-form-field-data', _that.isFormFieldList);
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
        quizformDetails() {
            let _that       = this;
            let quizformID  = _that.selectedFormID;

            axios.get("admin/quiz-forms/"+quizformID,
                {
                    headers: {
                        'Authorization': 'Bearer ' + localStorage.getItem('authToken')
                    },
                })
                .then(function (response) {
                    if (response.data.status_code === 200) {
                        _that.quizform_details= response.data.quiz_form_info
                    } else {
                        _that.success_message = "";
                        _that.error_message = response.data.error;
                    }
                })
        },
    },
    created() {
        this.isAdd = this.isAddFieldCheck;
        this.selectedFormID = this.quizFormId;
        this.quizformDetails();
    }
}
</script>

<style scoped>

</style>
