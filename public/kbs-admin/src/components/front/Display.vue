<template>
    <div>
        <nav id="topNav" class="navbar fixed-top navbar-toggleable-md navbar-inverse bg-dark text-light">
            <a class="navbar-brand mx-auto text-light" href="/kbs/display">KBS</a>
        </nav>

        <div class="container-fluid app">
            <div class="row">
                <div class="col-md-12 text-left">
                    <button style="font-size:20px;cursor:pointer;" class="text-dark mt-2 mb-2" @click="openNav()">&#9776; Categories</button>
                </div>
            </div>
        </div>


        <div class="container">
            <div class="row">
                <div class="offset-3 col-md-6">
                    <div class="input-group">
                        <input type="text" class="form-control text-left" v-model="formdata.search" v-on:keyup.enter="searchData()" placeholder="Ex: Coronavirus disease (COVID-19) pandemic"/>
                        <button type="button" class="btn btn-info" @click="searchData()" ><img src="../../assets/search-flat.png" style="height: 25px;width: 25px"/></button>
                    </div>
                </div>




                <div class="col-md-12">

                    <div id="mySidenav" class="sidenav">
                        <button class="closebtn" @click="closeNav()">&times;</button>

                        <div v-for="(a_category) in allCategories" :key="a_category" >
                            <a href="" @click.prevent="categorySearch(a_category.id)" class="text-light">{{a_category.name}}</a>
                            <div v-for="a_child in a_category.children_recursive" class="p-2" :key="a_child">
                                <a href=""  @click.prevent="categorySearch(a_child.id)" class="text-light">{{a_child.name}}</a>
                            </div>
<!--                            <div v-for="a_child in allChildrens" :key="a_child">-->
<!--                                <a href=""  @click.prevent="categorySearch(a_child.id)" class="text-light" v-if="a_child.parent_id == a_category.id">{{a_child.name}}</a>-->
<!--                            </div>-->
                        </div>
                    </div>
                </div>


                <div class="offset-1 col-md-10">
                    <div class="table-responsive mt-3 mb-3">
                        <div v-for="a_article in allArticles" :key="a_article" class="text-left">
                            <h4 class="text-info">{{a_article.en_title}}</h4>
                            <small class="text-secondary">Post on: {{a_article.created_at}}</small>,<small class="text-secondary">Tags: {{a_article.tag}}</small>
                            <p>{{a_article.en_short_summary}}</p>
                            <br/>
                            <hr/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'


    export default {
        name: "Display",
        data(){
            return{
                formdata:{
                    search:''
                },
                allCategories: "",
                allArticles: "",
                allChildrens: [],
            }
        },
        methods:{
            categorySearch(v) {
                let _that = this;
                console.log(v);
                let category_ID = v;
                axios.get('article/category/'+category_ID)
                    .then(function (response) {
                        console.log(response);
                        _that.allArticles = response.data.article_list;
                    })
            },
            searchData(){
                let _that = this;
                axios.post('article/search', {
                    query_string      : this.formdata.search,
                }).then((response)=>{
                    console.log(response.data.article_list);
                    _that.allArticles = response.data.article_list
                })
            },
            openNav() {
                document.getElementById("mySidenav").style.width = "250px";
            },

            closeNav() {
                document.getElementById("mySidenav").style.width = "0";
            },
            getCategoryList()
            {
                let _that =this;
                axios.get('category-list', { cache: false })
                    .then(function (response) {
                        console.log(response)
                        if(response.data.status_code === 200){
                            _that.allCategories = response.data.category_list;
                            console.log(_that.allCategories);
                            // _that.allCategories.forEach(val=>{
                            //     // console.log(val.parent_id);
                            //     val.children_recursive.forEach(childVal=>{
                            //         console.log(childVal);
                            //         _that.allChildrens.push(childVal)
                            //     });
                            //
                            // })
                        }
                        else{
                            _that.success_message = "";
                            _that.error_message   = response.data.error;
                        }
                    })
            },
        },
        created(){
            this.getCategoryList();
        }
    }
</script>

<style scoped>
    .app{
        margin-top: 60px;
    }

    .sidenav {
        min-height: 100vh;
        width: 0;
        position: fixed;
        z-index: 1;
        top: 55px;
        left: 0;
        background-color: #343A40;
        overflow-x: hidden;
        transition: 0.5s;
        padding-top: 60px;
    }

    .sidenav div {
        padding: 5px 0px 0px 20px;
        text-decoration: none;
        font-size: 18px;
        color: #ffffff;
        display: block;
        transition: 0.3s;
        text-align: left;
    }

    .sidenav div:hover {
        color: #f1f1f1;
    }

    .sidenav .closebtn {
        position: absolute;
        top: 0;
        right: 25px;
        font-size: 36px;
        margin-left: 50px;
    }

    @media screen and (max-height: 450px) {
        .sidenav {padding-top: 15px;}
        .sidenav a {font-size: 18px;}
    }
</style>