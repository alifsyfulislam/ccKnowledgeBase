<template>
  <div>
    <div class="counting-number text-light-blue">

      <ICountUp :delay="delay" :endVal="totalQuiz" :options="options" @ready="onReady"/>

    </div>
  </div>
</template>

<script>
import ICountUp from 'vue-countup-v2'
export default {
  name: "totalQuiz",
  props:['totalQuiz'],
  components:{
    ICountUp
  },
  data() {
    return {
<<<<<<< HEAD
      delay: 1000,
=======
      delay: 500,
>>>>>>> 736ae50711e9a188480c561bfb62d2cf617e40fd
      endVal: 0,
      options: {
        useEasing: true,
        useGrouping: true,
        separator: ',',
        decimal: '.',
        prefix: '',
        suffix: ''
      },
    }
  },
  methods:{
    onReady: function(instance, CountUp) {
      const that = this;
      instance.update(that.totalQuiz);
    },
  },
  created() {
    console.log(this.totalQuiz);
  }
}
</script>

<style scoped>

</style>
