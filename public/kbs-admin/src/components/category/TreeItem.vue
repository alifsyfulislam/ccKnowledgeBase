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
        toggle: function() {
            if (this.isFolder) {
                this.isOpen = !this.isOpen;
            }
        },
        makeFolder: function() {
            if (!this.isFolder) {
                this.$emit("make-folder", this.item);
                this.isOpen = true;
            }
        }
    },
    mounted() {
        // console.log(this.item.parent_recursive);
        // console.log(this.item[6].parent_recursive);

        // let { [Object.keys(this.item).pop()]: lastItem } = this.item;
        // console.log(lastItem + "got");

        // let objectLenght = [];
        //
        // console.log(objectLenght);
        let element = [];

        let parent_recursive = [];

        this.item.forEach((val,index) =>{

            if (val.parent_recursive != null){
                console.log(val.parent_recursive.name)
                // console.log(typeof val.parent_recursive);
                element[index] = {
                    name : val.name, children : parent_recursive[name] = val.parent_recursive.name
                };
            }else{
                element[index] = {
                    name : val.name, children : null
                };
            }


        })

        console.log(element);
    }
}
</script>

<style scoped>

</style>
