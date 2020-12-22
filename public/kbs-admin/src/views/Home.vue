<template>
  <div class="home">
    <TestIndex />
  </div>
</template>

<script>
// @ is an alias to /src

import TestIndex from '@/components/TestIndex.vue'

export default {
  name: 'Home',
  components: {
    TestIndex
  }
}
</script>
