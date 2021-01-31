<template>
    <div>
        <li class="nav-item">
<!--            :id="'treeLevel'+item.id"-->
            <div :class="{bold: isFolder}">
                <router-link class="nav-link" :to="{ name: 'CategoryList', params: { categoryID: item.slug }}">
                    {{ item.name }}
                    <span v-if="isFolder" @click="toggle">[{{ isOpen ? '-' : '+' }}]</span>
                </router-link>
            </div>

            <ul v-show="isOpen" v-if="isFolder">
                <span v-for="(child, index) in item.children_recursive" :key="index">
                    <tree-view class="item" :item="child"></tree-view>
                </span>
            </ul>
        </li>
    </div>
</template>

<script>
// import $ from 'jquery'
// import axios from "axios";

export default {
    name: "TreeView",
    props: {
        item: Object,
    },
    data: function() {
        return {
            isOpen: false,
            pressedCategoryIdHistory : [],
        };
    },
    computed: {
        isFolder: function() {
            return this.item.children_recursive && this.item.children_recursive.length;
        }
    },
    methods: {
        toggle: function() {
            if (this.isFolder) {
                this.isOpen = !this.isOpen;
            }
        },
    },
    created() {
        // console.log(this.categorySlug);
    }
}
</script>

<style scoped>

</style>
