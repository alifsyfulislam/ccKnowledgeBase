<template>
  <div class="sidebar-wrapper bg-white">
    <div class="logo-wrapper text-center py-25 px-10">
      <img class="big-image" src="@/assets/img/gplex-logo.png" alt="gplex">
      <img class="small-image" src="@/assets/img/gplex-logo-2.png" alt="gplex">
    </div>

    <nav class="sidebar-menu-wrapper text-left" >
      <ul class="main-items mb-0 pl-10 py-30 color-variation-menu-items list-unstyled">
        <li>
          <router-link :to="{ name: 'dashboard'}">
            <span class="anim">
                <span class="anim">
                    <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 17.5 20" style="enable-background:new 0 0 17.5 20;" xml:space="preserve">
                        <g>
                            <path id="Icon_material-dashboard_1_" class="st0" d="M1.3,10.8h6.6V2.6H1.3V10.8z M1.3,17.4h6.6v-5H1.3V17.4z M9.6,17.4h6.6V9.2
                                H9.6V17.4z M9.6,2.6v5h6.6v-5H9.6z"/>
                        </g>
                    </svg>
                </span>
            </span>
            <span class="menu-title">
                Dashboard
            </span>
          </router-link>
        </li>

        <li>
          <router-link :to="{ name: 'customerList'}">
            <span class="anim">
                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 17.5 20" style="enable-background:new 0 0 17.5 20;" xml:space="preserve">
                    <g>
                        <path id="Icon_awesome-user-tie_1_" class="st0" d="M8.8,10c2.5,0,4.5-2,4.5-4.5s-2-4.5-4.5-4.5S4.2,3,4.2,5.5S6.2,10,8.8,10z
                            M12.1,11.2l-1.7,6.8l-1.1-4.8l1.1-2H7.1l1.1,2l-1.1,4.8l-1.7-6.8c-2.5,0.1-4.5,2.2-4.5,4.7v1.5c0,0.9,0.8,1.7,1.7,1.7l0,0H15
                            c0.9,0,1.7-0.8,1.7-1.7l0,0v-1.5C16.7,13.4,14.7,11.3,12.1,11.2z"/>
                    </g>
                </svg>
            </span>
            <span class="menu-title">
                User
            </span>
          </router-link>
        </li>

        <li>
          <router-link :to="{ name: 'categoryList'}">
            <span class="anim">
                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 17.5 20" style="enable-background:new 0 0 17.5 20;" xml:space="preserve">
                    <g>
                        <path id="Icon_awesome-share-alt_1_" class="st0" d="M13,12.1c-0.7,0-1.4,0.2-2,0.7l-3.4-2.1c0.1-0.5,0.1-0.9,0-1.4L11,7.2
                            c1.4,1.1,3.4,0.9,4.5-0.5s0.9-3.4-0.5-4.5s-3.4-0.9-4.5,0.5C9.9,3.5,9.7,4.4,9.9,5.4L6.5,7.5C5.1,6.4,3.1,6.6,2,8s-0.9,3.4,0.5,4.5
                            c1.2,0.9,2.8,0.9,4,0l3.4,2.1c-0.4,1.7,0.7,3.4,2.4,3.8c1.7,0.4,3.4-0.7,3.8-2.4c0.4-1.7-0.7-3.4-2.4-3.8
                            C13.5,12.1,13.2,12.1,13,12.1z"/>
                    </g>
                </svg>
            </span>
            <span class="menu-title">Category</span>
          </router-link>
        </li>

        <li>
          <router-link :to="{ name: 'articleList'}">
            <span class="anim">
                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 17.5 20" style="enable-background:new 0 0 17.5 20;" xml:space="preserve">
                    <g>
                        <path id="Icon_ionic-ios-help-buoy_1_" class="st0" d="M8.8,2C4.4,2,0.9,5.6,0.9,10s3.6,7.9,7.9,7.9s7.9-3.6,7.9-7.9
                            C16.7,5.6,13.2,2,8.8,2C8.8,2,8.8,2,8.8,2z M10.9,3.4c2.1,0.7,3.8,2.3,4.5,4.5L12,8.1c-0.3-0.5-0.8-1-1.3-1.3L10.9,3.4z M3.9,5.1
                            c0.8-0.8,1.7-1.4,2.8-1.7l0.2,3.4C6.4,7.1,6,7.6,5.6,8.1L2.2,7.9C2.6,6.8,3.2,5.9,3.9,5.1z M6.7,16.5c-2.1-0.7-3.8-2.3-4.5-4.5
                            l3.4-0.2c0.3,0.5,0.8,1,1.3,1.3L6.7,16.5z M8.8,12.6c-1.4,0-2.6-1.2-2.6-2.6s1.2-2.6,2.6-2.6s2.6,1.2,2.6,2.6
                            C11.4,11.4,10.2,12.6,8.8,12.6z M13.7,14.8c-0.8,0.8-1.7,1.4-2.8,1.7l-0.2-3.4c0.5-0.3,1-0.8,1.3-1.3l3.4,0.2
                            C15,13.1,14.4,14,13.7,14.8L13.7,14.8z"/>
                    </g>
                </svg>
            </span>
            <span class="menu-title">Article</span>
          </router-link>
        </li>
        <li>
          <router-link :to="{ name: 'faqList'}">
            <span class="anim">
                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 17.5 20" style="enable-background:new 0 0 17.5 20;" xml:space="preserve">
                    <g>
                        <g>
                            <path id="Path_112_1_" class="st0" d="M14.9,7.4H7.3C6.6,7.4,6,8,6,8.7V14c0,0.7,0.6,1.3,1.3,1.3h4.3c0.1,0,0.2,0,0.3,0.1l2.2,2
                                c0.1,0.1,0.3,0.1,0.3-0.1v-1.7c0-0.2,0.1-0.3,0.3-0.3h0c0.7,0,1.4-0.6,1.4-1.3V8.7C16.2,8,15.6,7.4,14.9,7.4
                                C14.9,7.4,14.9,7.4,14.9,7.4z"/>
                        </g>
                        <g>
                            <path id="Path_113_1_" class="st0" d="M5.6,5.9h6.1V3.7c0-0.6-0.5-1.1-1.1-1.1H2.4C1.8,2.5,1.3,3,1.3,3.7v5.6
                                c0,0.6,0.5,1.1,1.1,1.1h2.1V7C4.5,6.4,5,5.9,5.6,5.9z"/>
                        </g>
                    </g>
                </svg>
            </span>
            <span class="menu-title">FAQ</span>
          </router-link>
        </li>
        <li>
          <router-link :to="{ name: 'roleList'}">
            <span class="anim">
                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 17.5 20" style="enable-background:new 0 0 17.5 20;" xml:space="preserve">
                    <g>
                        <path id="Icon_simple-crunchyroll_1_" class="st0" d="M3.2,10.8C3,7.3,5.6,4.2,9.2,3.9s6.7,2.4,7,5.9c0,0.2,0,0.4,0,0.5V9.9
                            c0-4.1-3.3-7.4-7.4-7.4S1.4,5.9,1.4,9.9s3.3,7.4,7.4,7.4h0.5C5.9,17.1,3.3,14.2,3.2,10.8L3.2,10.8z M12.8,11.2
                            c-1.1,0-2.1-0.9-2.1-2c0-0.9,0.5-1.6,1.4-1.9c-0.6-0.3-1.3-0.5-2.1-0.5c-2.5,0-4.5,2-4.5,4.5s2,4.5,4.5,4.5s4.5-2,4.5-4.5
                            c0-0.3,0-0.6-0.1-0.9C14.1,10.9,13.5,11.2,12.8,11.2z"/>
                    </g>
                </svg>
            </span>
            <span class="menu-title">Roles</span>
          </router-link>
        </li>

        <li>
          <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle collapsed">
            <span class="anim">
                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 17.5 20" style="enable-background:new 0 0 17.5 20;" xml:space="preserve">
                    <g>
                        <path id="Icon_awesome-skiing_1_" class="st0" d="M13.8,5.4c0.8,0,1.4-0.6,1.4-1.4s-0.6-1.4-1.4-1.4c-0.8,0-1.4,0.6-1.4,1.4
                            S13,5.4,13.8,5.4z M15.9,15.6c-0.3-0.3-0.7-0.3-1,0c0,0,0,0,0,0c-0.3,0.3-0.9,0.4-1.3,0.3l-3.9-2l1.4-2.1c0.4-0.5,0.3-1.3-0.2-1.7
                            L9.8,8.8L6.7,7.3C6.6,7.9,6.8,8.5,7.2,8.9L9.4,11l-1.3,2l-5.7-2.9c-0.3-0.2-0.8,0-0.9,0.3c-0.2,0.3,0,0.8,0.3,0.9l0,0L13,17.1
                            c0.3,0.2,0.7,0.2,1.1,0.2c0.7,0,1.3-0.3,1.8-0.7C16.2,16.3,16.2,15.9,15.9,15.6C15.9,15.6,15.9,15.6,15.9,15.6z M4.8,5.3L4.5,5.9
                            c0.4,0.2,0.9,0.1,1.2-0.1l1.4,0.7c0,0,0,0,0,0l3.3,1.6l0.9-0.4l0.2,0.5c0.1,0.3,0.4,0.6,0.7,0.8l1.7,0.8c0.5,0.2,1,0,1.2-0.4
                            c0.2-0.4,0-1-0.4-1.2l-1.5-0.8L12.7,6c-0.3-1-1.4-1.5-2.3-1.2c0,0-0.1,0-0.1,0L7.9,5.8L6.1,4.9c0-0.4-0.2-0.8-0.6-1L5.2,4.6h0
                            l-1-0.2c-0.1,0-0.1,0-0.1,0C4,4.5,4,4.5,4.1,4.6c0,0,0,0,0,0L4.8,5.3z"/>
                    </g>
                </svg>
            </span>
            <span class="menu-title">Quizz</span>
          </a>
          <ul class="collapse list-unstyled sub-items" id="pageSubmenu">

          <li>
              <router-link :to="{ name: 'quizList'}">
                  <span class="menu-sub-title">Quizzes</span>
              </router-link>
          </li>

          <li>
             <router-link :to="{ name: 'quizFormList'}">
                <span class="menu-sub-title">Quiz Forms</span>
             </router-link>
          </li>



<!--            <li>
              <a href="#"><span class="menu-sub-title">Quiz Form Fields</span></a>
            </li>-->


          </ul>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
export default {
name: "Menu.vue"
}
</script>

<style scoped>

</style>
