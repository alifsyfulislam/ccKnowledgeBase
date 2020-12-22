<template>
    <div v-for="a_quiz in allQuizzes" :key="a_quiz.id">
        <div>{{a_quiz.name}}</div>
    </div>
</template>

<script>
    import axios from 'axios'
    export default {
        name: "Quiz",
        data(){
            return{
                allQuizzes : ''
            }
        },
        methods:{
            getQuizList()
            {
                let _that =this;
                axios.get('quiz-list', { cache: false })
                    .then(function (response) {
                        console.log(response.data.quiz_form_list);
                        if(response.data.status_code === 302){
                            _that.allQuizzes = response.data.quiz_form_list;

                        }
                    })
            },
        },
        created(){
           this.getQuizList();
        }
    }
</script>

<style scoped>

</style>
