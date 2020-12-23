<template>
    <div class="py-30 py-md-60">
        <div class="container">
            <div v-if="quizInfo">
                <div v-for="a_form_field in quizFormFieldInfo" :key="a_form_field.id">
                    <div>{{a_form_field.f_label}}</div>
                    <div v-if="a_form_field.f_type === 'Text'">
                        <input :max="a_form_field.f_max_value" :type="a_form_field.type" :name="a_form_field.f_name" :class="a_form_field.f_class" :id="a_form_field.f_id" :required="a_form_field.f_required==0? false: true"/>
                    </div>

                    <div v-if="a_form_field.f_type === 'Email'">
                        <input :max="a_form_field.f_max_value" :type="a_form_field.type" :name="a_form_field.f_name" :class="a_form_field.f_class" :id="a_form_field.f_id" :required="a_form_field.f_required==0? false: true"/>
                    </div>

                    <div v-if="a_form_field.f_type === 'Select/Dropdown'">
                        <select :name="a_form_field.f_name" :class="a_form_field.f_class" :id="a_form_field.f_id" :required="a_form_field.f_required==0? false: true">
                            <option selected disabled>Select one</option>
                            <option v-for="a_val in selectBoxOption" :key="a_val">{{a_val}}</option>
                        </select>
                    </div>

                    <div>
                        <button class="btn" :class="[(itemA == 0) ? 'd-none':'show btn-info']">Finish Exam</button>
                    </div>
                </div>

                <div class="mt-3">
                    <div v-for="a_form_field in quizFormFieldInfo" :key="a_form_field.id">
                        <div>
                            <div v-if="pagination.total > pagination.per_page" class="col-md-offset-4">
                                <ul class="pagination">
                                    <li :class="[{disabled:!pagination.prev_page_url},,(itemA == 1) ? 'd-none':'']" class="page-item mx-1">
                                        <a @click.prevent="getQuizFormField(pagination.prev_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Previous</a>
                                    </li>

                                    <li :class="[{disabled:!pagination.next_page_url},(itemA == 1) ? 'd-none':'']" class="page-item mx-1">
                                        <a @click.prevent="getQuizFormField(pagination.next_page_url)" href="#" class="px-3 bg-primary text-white py-2 rounded-sm">Next</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div v-else>
                go back to quiz page
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name: "StartExam",

    data(){
        return{
            quizInfo: '',
            quizFormFieldInfo:'',
            selectBoxOption:'',
            itemA : 0,

            pagination:{
                from: '',
                to: '',
                first_page_url: '',
                last_page: '',
                last_page_url: '',
                next_page_url:'',
                prev_page_url: '',
                path: '',
                per_page: 1,
                total: ''
            },
        }
    },

    methods:{
        getQuizFormField(pageUrl) {
            let _that = this;
            pageUrl = pageUrl == undefined ? '/quiz-form/field-list/'+_that.quizInfo.quiz_form_id+'?page=1' : pageUrl;

            axios.get(pageUrl)
                .then(function (response) {
                    _that.quizFormFieldInfo = response.data.quiz_form_field_list.data;
                    _that.pagination  = response.data.quiz_form_field_list;
                    _that.quizFormFieldInfo.forEach(val =>{
                        if (val.f_option_value !=null && val.f_option_value.search(',')){
                            let str = val.f_option_value;
                            str = str.split(",");
                            _that.selectBoxOption = Object.assign({}, str);
                        }
                        // console.log(_that.pagination);
                        if (pageUrl==_that.pagination.last_page_url){
                            console.log("end");
                            _that.itemA = 1;
                        }else {
                            _that.itemA = 0;
                        }
                    })
                })
        }
    },

    created() {
        this.quizInfo = JSON.parse(localStorage.getItem("quiz_info"));
        this.getQuizFormField();
    }
}
</script>

<style scoped>

</style>
