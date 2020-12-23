<template>
    <div class="container">
        <div class="row">
            <div class="col-md-12 p-3 m-3">
                <h2 class="text-center font-weight-bold p-3">Quiz List</h2>
                <div class="table-responsive d-flex justify-content-center">
                    <table class="table table-bordered table-striped">
                        <tr class="bg-info text-light">
<!--                            <th class="p-3">Quiz ID</th>-->
                            <th>Quiz Name</th>
                            <th>Duration</th>
                            <th>Number of Questions</th>
                            <th>Total Marks</th>
                            <th>Action</th>
                        </tr>
                        <tr v-for="a_quiz in allQuizzes" :key="a_quiz.id">
<!--                            <td>{{ a_quiz.id }}</td>-->
                            <td>{{ a_quiz.name }}</td>
                            <td>{{ a_quiz.duration }}</td>
                            <td>{{ a_quiz.number_of_questions }}</td>
                            <td>{{ a_quiz.total_marks }}</td>
                            <td>
                                <button class="btn btn-success">Start</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    export default {
        name: "Quiz",
        data(){
            return{
                itemA: '0' ,
                allQuizzes : ''
            }
        },
        methods:{
            checkStatus(e){
                this.itemA = e;
                console.log(e);
            },
            getQuizList()
            {
                let _that =this;
                axios.get('quiz-list', { cache: false })
                    .then(function (response) {
                        console.log(response.data.quiz_form_list);
                        if(response.data.status_code === 200){
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
