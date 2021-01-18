<template>
    <div class="tag-input" @click="inputFocus($event)">
        <div v-for="(tag, index) in tags" :key="index" class="tag-group">
            <span class="tag tag-primary" @dblclick="updateTag(tag,index)">{{tag}}</span>
            <span class="tag tag-delete tag-secondary" @click="removeTag(index)">X</span>
        </div>
        <input type="text" class="tag-control form-control" placeholder="Add a new tag" v-model="tagValue" @input="autoWidth($event), createTag($event)"
        @keyup.enter="createTag($event)">
    </div>
</template>

<script>
export default {
    name: "TagComponent",

    data(){
        return{
            tagValue : '',
            tagList : [],
            tagSeparator: ' '
        }
    },
    computed: {
        tags:{
            get(){
                return this.tagList
            },
            set(val){
                this.tags = val
            }
        }
    },
    methods: {
        inputFocus(e){
            if (!e.target.querySelector('input.tag-control')) return;
            e.target.querySelector('input.tag-control').focus()
        },
        autoWidth(e){
            const tagControlHidden = document.createElement('div')
            tagControlHidden.classList.add('tag-control','tag-control-hidden')

            const tagString = this.tagValue || e.target.getAttribute('placeholder') || ''
            tagControlHidden.innerHTML = tagString.replace(/ /g, '&nbsp;').trim()
            document.body.appendChild(tagControlHidden);

            e.target.style.setProperty('width', Math.ceil(window.getComputedStyle(tagControlHidden).width
                .replace('px','')) + 1 + "px")
            tagControlHidden.remove()
        },
        createTag(e){
            if (this.tagValue.includes(this.tagSeparator) || e.key === 'Enter'){
                this.tagList.push(this.tagValue.replace(this.tagSeparator, '').trim())
            }
            this.autoWidth(e)
            console.log(this.tagList);
        },
        removeTag(i){
            this.tags.splice(i,1)
        },
        updateTag(tag,index){
            this.tagValue = tag;
            this.removeTag(index)
        }
    },

}
</script>

<style scoped>

</style>
