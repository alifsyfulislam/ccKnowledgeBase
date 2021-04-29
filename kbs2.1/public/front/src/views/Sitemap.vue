<template>
    <div v-if="isLoading" >

        <section class="topics-area py-50 py-md-60">
            <div class="container">

                <div class="row justify-content-md-center">
                    <div class="col-lg-8">
                        <h1 class="section-title bottom-bar text-center mb-10 pb-20">URL List</h1>
                    </div>
                </div>

                <ul class="mb-30 mt-30">
                    <li v-for="(a_page,index) in url_list" :key="index">
                        <a :href="a_page" target="_blank" onclick="return false;">{{a_page}}</a>
                    </li>
                </ul>

                <div class="row justify-content-md-center">
                    <div class="col-lg-8">
                        <h1 class="section-title bottom-bar text-center mb-10 pb-20">Back-end API List</h1>
                    </div>
                </div>

                <ul class="mb-30 mt-30" v-for="(url,index) in sitemap_list" :key="index">
                    <li v-for="(map_url,mapindex) in url" :key="mapindex">
                        <a :href="map_url.loc" target="_blank" onclick="return false;">{{map_url.loc}}</a>
                    </li>
                </ul>
            </div>
        </section>
    </div>
</template>
<script>
    import Loader from "../components/Loader";
    import axios from 'axios'

    export default {
        name: "Sitemap",

        components:{
            Loader
        },

        data(){
            return{
                sitemap_list : '',
                url_list    : '',
                isLoading : false
            }
        },

        methods:{
            getSitemapList(){
                let _that = this;
                axios.get('genrate-sitemap')
                    .then(function (res) {
                        _that.isLoading = true;

                        _that.sitemap_list = res.data.map_info;
                        console.log( _that.sitemap_list)
                    })
            },

            getRoutesList(routes, pre) {
                return routes.reduce((array, route) => {
                    const path = `${pre}${route.path}`;

                    if (route.path !== '*') {
                        array.push(path);
                    }

                    if (route.children) {
                        array.push(...getRoutesList(route.children, `${path}/`));
                    }

                    return array;
                }, []);
            }
        },

        created() {
            this.getSitemapList();
            this.url_list= this.getRoutesList(this.$router.options.routes, 'https://kbs.com');
        }
    }
</script>

<style scoped>

</style>