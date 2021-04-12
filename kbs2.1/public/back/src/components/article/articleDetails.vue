<template>
    <div class="main-wrapper d-flex">
        <!-- sidebar -->
        <Menu></Menu>
        <!-- sidebar end -->

        <div class="main-content-wrapper w-100 position-relative overflow-auto bg-white" >
            <!-- Topbar -->
            <Header></Header>

            <!-- Topbar End -->

            <!-- Content Area -->
            <div class="content-area">
                <div class="content-title-wrapper px-15 py-10 d-md-flex justify-content-between align-items-center">
                    <h2 class="content-title text-uppercase m-0">Article Details</h2>
                    <router-link :to="{ name: 'articleList'}" class="btn common-gradient-btn ripple-btn btn-xs m-1 px-15 py-2">
                        <i class="fas fa-arrow-left"></i> Back
                    </router-link>
                </div>


                <div class="content-wrapper bg-white" v-if="aArticle">
                    <div class="data-content-area px-15 py-10">
                        <h3 class="font-weight-bold">Articles Details Page</h3>
                        <div>
                            <small class="font-16"><strong>Category: </strong>{{aArticle.category ? aArticle.category.name : 'N/A'}}</small>
                        </div>
                        <p class="font-16"><strong>Tags: </strong>{{aArticle.tag}}</p>

                        <div class="ta-wrapper d-flex align-items-center py-10 my-15">
                            <div class="avatar mr-10">
                                <img class="img-fluid" src="../../assets/img/avatar.png" style="height: 50px; width: 50px" alt="avatar">
                            </div>
                            <div class="tc-wrapper">
                                <h5 v-cloak class="my-0 pb-1">{{aArticle.user.first_name}} {{aArticle.user.last_name}}</h5>
                                <p class="mb-0">Post on: {{aArticle.created_at}}</p>
                            </div>
                        </div>


                        <div class="col-md-12 article-lang-switcher" v-if="aArticle.bn_title != 'n/a'">
                            <ul class="nav nav-tabs" id="myTab">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabEnglish">English</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabBangla">Bangla</a>
                                </li>
                            </ul>
                        </div>

                        <div class="col-md-12">
                            <div class="tab-content pt-3" id="myTabContent">
                                <div class="tab-pane fade active show" id="tabEnglish" v-if="aArticle">
                                    <div class="ta-content-wrapper">
                                        <h3 class="pb-10">{{aArticle.en_title}}</h3>
                                    </div>
                                    <div class="ta-content-wrapper" v-for="a_article_content in aArticle.contents">
                                        <div v-if="a_article_content.en_body != 'n/a' && a_article_content.role_id.includes(userInformation.roles[0].id)" v-html="a_article_content.en_body"></div>
                                    </div>
                                </div>


                                <!--bangla-->
                                <div class="tab-pane fade" id="tabBangla" v-if="aArticle.contents.bn_title != 'n/a'">
                                    <div class="ta-content-wrapper">
                                        <h3 class="pb-10">{{aArticle.bn_title}}</h3>
                                    </div>
                                    <div class="ta-content-wrapper" v-for="a_article_content in aArticle.contents">
                                        <div v-if="a_article_content.bn_body != 'n/a' && a_article_content.role_id.includes(userInformation.roles[0].id)" v-html="a_article_content.bn_body"></div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <br/>

                        <div v-if="aArticle.media.length > 0">
                            <h5 class="mb-0 font-weight-bold pl-2 pb-3">Refferences</h5>
                            <ul class="pl-25 pb-2">
                                <li v-for="a_file in aArticle.media" :key="a_file.id">
                                    <a :href="a_file.url">{{a_file.url | formatFileName }}</a>
                                </li>
                            </ul>
                        </div>

                        <!-- Content Area End -->

                        <div class="action-modal-wraper" v-if="success_message">
                            <span>{{ success_message }}</span>
                        </div>
                        <div class="action-modal-wraper-error" v-if="error_message">
                            <span>{{ error_message }}</span>
                        </div>

                        <div v-if="aArticle.commentable_status">
                            <h5 class=" pl-3 pb-10">Discussions</h5>
                        </div>

                        <div v-if="aArticle.commentable_status">
                            <!-- Comment Section Start -->
                            <div class="comment-box">
                                <div class="comment-input-box d-flex">
                                    <div class="featured-image avatar mr-10">
                                        <img class="img-fluid rounded-circle" src="../../assets/img/avatar.png" style="height: 50px; width: 50px" alt="avatar">
                                    </div>
                                    <div class="comment-input w-100">
                                        <input type="hidden" v-model="aArticle.id">
                                        <input type="hidden" v-model="userInformation.id">
                                        <textarea v-model="comment_body" placeholder="Write your comment..." class="form-control px-25 py-10"></textarea>
                                        <input hidden type="radio" checked value="0" v-model="status">
                                    </div>
                                </div>
                                <div class="replied-btn-wrapper text-right pt-10">
                                    <button class="btn btn-primary common-gradient-btn px-25 py-2 rounded-pill" @click="addComment()">Submit</button>
                                </div>
                            </div>
                            <!-- Comment Section End -->

                            <!-- Reply Section Start -->
                            <div class="reply-box mt-15" v-for="a_comment in comments" :key="a_comment.id">
                                <div class="reply-input-box d-flex">
                                    <div class="featured-image avatar mr-10">
                                        <img class="img-fluid rounded-circle" src="../../assets/img/avatar.png" style="height: 50px; width: 50px" alt="avatar">
                                    </div>
                                    <div class="reply-text w-100 px-10 py-2">
                                        <div>
                                            <small>Posted on: {{a_comment.created_at}}</small>
                                        </div>
                                        <div>
                                            <small> Status :
                                                <input type="hidden" v-model="a_comment.id">
                                                <label for="status_inactive"><input id="status_inactive" type="radio" v-model="a_comment.status" value="0" @change="changeCommentStatus($event, a_comment.id)"/>Inactive</label>
                                                <label for="status_active"><input id="status_active" type="radio" v-model="a_comment.status" value="1" @change="changeCommentStatus($event, a_comment.id)"/>Active</label>
                                            </small>
                                        </div>
                                        <h6 class="font-weight-bold">{{a_comment.user.first_name ? a_comment.user.first_name+' '+ a_comment.user.last_name : a_comment.user_id}}</h6>
                                        <p>{{a_comment.comment_body}}</p>
                                    </div>
                                </div>

                                <div class="replied-box mt-10 ml-60" v-if="a_comment.status==1">

                                    <div class="replied-input-box">
                                        <div class="d-flex mt-15">
                                            <div class="featured-image avatar mr-10">
                                                <img class="img-fluid rounded-circle" src="../../assets/img/avatar.png" style="height: 40px; width: 40px" alt="avatar">
                                            </div>
                                            <div class="reply-input w-100">
                                                <input placeholder="reply..." class="form-control px-25 py-10">
                                            </div>
                                        </div>
                                        <div class="reply-btn-wrapper ml-60 mt-2 mb-2 text-right">
                                            <button class="btn-primary btn common-gradient-btn py-1 px-25 rounded-pill" @click="addReply(a_comment.id,reply_body,reply_status)">Reply</button>
                                        </div>
                                    </div>

                                    <!--                            <div class="d-flex">-->
                                    <!--                                <div class="featured-image avatar mr-10">-->
                                    <!--                                    <img class="img-fluid rounded-circle" src="../../assets/img/avatar.png" style="height: 40px; width: 40px" alt="avatar">-->
                                    <!--                                </div>-->
                                    <!--                                <div class="reply-text w-100 px-10 py-2">-->
                                    <!--                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate, veniam expedita eaque cumque accusamus nemo dolores saepe dolore nobis itaque dicta nisi ipsum doloremque? Dolorem expedita libero beatae culpa? Consequuntur?</p>-->
                                    <!--                                </div>-->
                                    <!--                            </div>-->
                                </div>
                            </div>
                            <!--                     Reply Section End-->
                        </div>
                    </div>
                </div>
            </div>
            <!-- Content Area End -->
        </div>

        <!-- Common Right SideBar End -->
    </div>
</template>

<script>
    import Header from "@/layouts/common/Header";
    import Menu from "@/layouts/common/Menu";
    import axios from "axios";

    export default {
        name: "articleDetails.vue",
        components: {
            Header,
            Menu
        },
        filters:{
            formatFileName(fileName){
                let res;
                res = fileName.split('/')
                return res[res.length - 1];;
            }
        },
        data(){

            return{

                articleID: '',
                articleSlug: '',
                aArticle: '',
                articleCounter: [],
                allCategoryArticle: '',
                categoryHasArticle: [],
                allArticle: '',
                query_string: '',
                roleAccess : [],
                userInformation : '',
                comment_body : '',
                status : 0,
                success_message : '',
                error_message   : '',
                comments : '',
            }

        },

        methods: {
            changeCommentStatus(event, commentID){
                let _that = this;
                let optionText = event.target.value;
                console.log(commentID);
                let formData = new FormData();
                formData.append('id', commentID);
                formData.append('status', optionText);
                axios.post('comment-status',formData,{
                    headers: {
                        'Authorization' : 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (res) {
                    console.log(res.data.status_code);
                    if (res.data.status_code == 200){
                        _that.getCommentListWithArticle()
                        _that.success_message = "Comment ststus changed";
                        _that.setTimeoutElements();
                    }
                })

            },
            setTimeoutElements()
            {
// setTimeout(() => this.isLoading = false, 3e3);
                setTimeout(() => this.success_message = "", 2e3);
                setTimeout(() => this.error_message = "", 2e3);
            },

            addComment(){
                let _that = this;

                let formData = new FormData();
                formData.append('post_id', _that.aArticle.id);
                formData.append('user_id', _that.userInformation.id);
                formData.append('comment_body', _that.comment_body);
                formData.append('status', _that.status);

                axios.post('comments',formData,{
                    headers: {
                        'Authorization' : 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (res) {
                    console.log(res.data.status_code);
                    if (res.data.status_code == 200){
                        _that.getCommentListWithArticle()
                        _that.success_message = "Comment added successfully";
                        _that.comment_body='';
                        _that.setTimeoutElements();
                    }
                })
            },

            getCommentListWithArticle(){
                let _that = this;

                axios.get('article-comments/'+_that.articleID,{
                    headers: {
                        'Authorization' : 'Bearer '+localStorage.getItem('authToken')
                    }
                }).then(function (res) {
                    _that.comments = res.data.comments;
                    console.log(res.data.comments)
                })
            },

            articleSearch(v){
                let _that = this;
                console.log(v);
                let articleSlug = v;
                axios.get('article-details/'+articleSlug)
                    .then(function (response) {
                        _that.aArticle = response.data.article_info;
                        console.log(_that.aArticle);
                    })
            },

            searchData(){
                let _that = this;
                _that.$router.push({ name: 'Search', params: { query_string: _that.query_string } });
            },

            getRecentArticleList(){
                let _that = this;
                axios.get('article-list')
                    .then(function (response) {
                        _that.allArticle = response.data.article_list;
                    })
            },

            getCategoryArticleList()
            {
                let _that =this;
// let articleCounter = 0;
                axios.get('category-article-list', { cache: false })
                    .then(function (response) {
                        if(response.data.status_code === 200){
                            _that.allCategoryArticle = response.data.category_list;
                            _that.allCategoryArticle.forEach(val =>{
                                if (val.article.length!=0){
                                    _that.categoryHasArticle.push(val);
                                }
                            })
                        }
                    })
            },

        },

        created() {
            this.articleID = this.$route.params.id;
            this.articleSlug = this.$route.params.slug;
            this.articleSearch(this.articleSlug);
            this.getCategoryArticleList();
            this.getRecentArticleList();
            this.getCommentListWithArticle(this.articleID)
            this.userInformation = JSON.parse(localStorage.getItem("userInformation"));
        }
    }

</script>

<style scoped>

</style>
