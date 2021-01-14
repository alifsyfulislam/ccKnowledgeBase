<template>
    <div>
        <li>
            <div :class="{bold: isFolder}" @click="toggle" @dblclick="makeFolder">{{ item.name }}
                <span v-if="isFolder">[{{ isOpen ? '-' : '+' }}]</span>
            </div>
            <ul v-show="isOpen" v-if="isFolder">
                <tree-item
                    class="item" v-for="(child, index) in item.parent_recursive"
                    :key="index" :item="child"
                    @make-folder="$emit('make-folder', $event)"
                    @add-item="$emit('add-item', $event)">
                </tree-item>
                <li class="add" @click="$emit('add-item', item)">+</li>
            </ul>
        </li>
    </div>
</template>

<script>
export default {
    name: "TreeItem",

    props: ['item'],

    data: function()
    {
        return {
            isOpen: false
        };
    },
    computed: {
        isFolder: function()
        {
            return this.item.parent_recursive && this.item.parent_recursive.length;
        }
    },
    methods: {
        toggle: function()
        {
            if (this.isFolder) {
                this.isOpen = !this.isOpen;
            }
        },
        makeFolder: function()
        {
            if (!this.isFolder) {
                this.$emit("make-folder", this.item);
                this.isOpen = true;
            }
        }
    },
    mounted()
    {
        // console.log(this.item)
    }
}
</script>

<style scoped>

</style>
