<template>
    <div class="step-form-wrapper">
        <div v-if="step === 1">
            <h1 class="mb-20">Step One</h1>
            <button class="btn common-gradient-btn ripple-btn px-50" @click.prevent="next()">Next <i class="fas fa-chevron-right"></i></button>
        </div>

        <div v-if="step === 2">
            <h1 class="mb-20">Step Two</h1>
            
            <button class="btn common-gradient-btn ripple-btn px-35 mr-10" @click.prevent="prev()"><i class="fas fa-chevron-left"></i> Previous</button>
            <button class="btn common-gradient-btn ripple-btn px-50" @click.prevent="next()">Next <i class="fas fa-chevron-right"></i></button>
        </div>

        <div v-if="step === 3">
            <h1 class="mb-20">Step Three</h1>
            
            <button class="btn common-gradient-btn ripple-btn px-35 mr-10" @click.prevent="prev()"><i class="fas fa-chevron-left"></i> Previous</button>
            <button class="btn common-gradient-btn ripple-btn px-50" @click.prevent="submit()"><i class="far fa-save"></i> Save</button>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            step:1
        }
    },

    methods:{
        prev() {
            this.step--;
        },
        next() {
            this.step++;
        },
        submit() {
            alert('Submit to blah and show blah and etc.');      
        }
    }
}
</script>

<style scoped>

</style>