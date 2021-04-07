<template>
    <div v-if="isLoading" >
        <ul v-for="url in sitemap_list" :key="url">
            <li v-for="map_url in url" :key="map_url">
                <a :href="map_url.loc" target="_blank">{{map_url.loc}}</a>
            </li>
        </ul>
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
                        // console.log(typeof _that.sitemap_list)
                    })
            }
        },

        created() {
            this.getSitemapList();
        }
    }
</script>

<style scoped>

</style>