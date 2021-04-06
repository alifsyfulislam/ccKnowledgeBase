<template>
    <div id="breakingNews" class="ticker box bg-white mt-1">
        <article class="media d-flex align-items-center py-10 pl-15">
            <span class="breaking-news media-left">Breaking News</span>
            <div class="media-content">
                <transition name="fade" tag="div" mode="out-in">
                    <a class="news" href="#" v-if="news[0]" key="0">There has been a massive explosion at the cheese factory</a>
                    <a class="news" href="#" v-if="news[1]" key="1">Bob is on fire</a>
                    <a class="news" href="#" v-if="news[2]" key="2">Look its Superman!</a>
                </transition>
            </div>
        </article>
    </div>
</template>

<script>
export default {
    name: "breakingnews.vue",
    data() {
        return {
            tickerLocation: 0,
            news: [
                true,
                false,
                false,
            ]
        }
    },
    created: function() {
        setInterval(this.updateTicker, 5000);
    },
    methods: {
        updateTicker: function() {
            var removed = this.news.pop();
            this.news.unshift(removed);
        }
    }
}
</script>

<style scoped>

.breaking-news {
    background-color: #ff7b88;
    color: #ffffff;
    border-radius: 0 50px 50px 0;
    padding: 5px 10px;
    min-width: 127px;
}

.media-content {
    padding: 5px;
    display: block;
    overflow: hidden;
}

.news {
    color: #666666;
    display: block;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}

.fade-enter-active, .fade-leave-active {
    transition: opacity 1s;
}

.fade-enter, .fade-leave-to {
    opacity: 0
}
</style>