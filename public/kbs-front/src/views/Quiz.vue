<template>
    <div>
        <section class="category-page-area py-50 py-md-60">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-5 text-left" v-if="allQuizzes">
                    <h4 class="mt-20">Quiz List</h4>
                    <div class="topics-category-categories my-20">
                        <ul class="nav nav-pills flex-column">
                            <li class="nav-item" v-for="a_quiz in allQuizzes" :key="a_quiz.id">
                                <a class="nav-link" :class="[(itemA == a_quiz.id) ? 'active':'']" href="#" @click.prevent="checkStatus(a_quiz.id)">
                                    <h6>{{a_quiz.name}}</h6>
                                    <!--                                    :class = "(categoryID==a_cat_art.id)?'active':''"-->
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        </section>
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
