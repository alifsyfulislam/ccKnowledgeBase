<template>
    <div>
        <div class="topbar-wrapper px-15 bg-white">
            <div class="top-bar-content d-flex align-items-center justify-content-between py-10">
                <div class="sidebar-navbar">
                    <i class="fas fa-bars"></i>
                </div>

                <div class="topbar-user-info-area">
                    <div class="d-flex align-items-center justify-content-end">
                        <div class="user-name">{{user_info.first_name+' '+user_info.last_name}}</div>
                        <div class="user-image px-15">
                            <img class="img-fluid" src="@/assets/img/user-image.jpg" alt="root@ccpro">
                        </div>
                        <div class="user-profile-navbar">
                            <i class="fas fa-stream"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <UserProfileBar></UserProfileBar>
    </div>

</template>

<script>

import $ from 'jquery'
import '@/assets/js/jquery.treenav.js'

// Sub Menu]
$(document).children('a').on('click', '.item-has-children', function (event) {
    event.preventDefault();
    $(this).toggleClass('submenu-open').next('.sub-menu').slideToggle(200).end().parent('.item-has-children').siblings('.item-has-children').children('a').removeClass('submenu-open').next('.sub-menu').slideUp(200);
});


// Left Sidebar show hide
$(document).on('click', '.sidebar-navbar > i', function () {
    $('.sidebar-wrapper').toggleClass('left-sidebar-hide');
});

// Right Side user profile show hide
$(document).on('click', '.user-profile-navbar > i', function () {
    $('.user-profile-bar-wrapper').toggleClass('user-profile-bar-show');
});

// Right Side Common Forms
$(document).on('click', '.right-side-common-form, .right-side-close-btn', function () {
    $('.right-sidebar-wrapper').toggleClass('right-side-common-form-show');
    $('body').toggleClass('open-side-slider');
});


import UserProfileBar from './UserProfileBar.vue'

export default {
    name: "Header.vue",
    data() {
        return {
            success_message : '',
            error_message   : '',
            token: '',
            user_info : ''
        }
    },

    components: {
        UserProfileBar
    },
    created() {
        this.user_info = JSON.parse(localStorage.getItem("userInformation"));
    }
}
</script>

<style scoped>

</style>
