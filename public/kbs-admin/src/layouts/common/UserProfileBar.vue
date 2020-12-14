<template>
  <div class="user-profile-bar-wrapper fixed-top px-15 py-30 py-md-50">
    <div class="user-profile-logo text-center mb-25">
      <img class="img-fluid" src="@/assets/img/user-image.jpg" alt="root@ccpro">
    </div>
    <h2 class="user-title m-0 text-center">root@ccpro</h2>

    <!-- upb-section-wrapper -->
    <div class="upb-section-wrapper pt-20 pt-md-25">
      <div class="upb-section-title text-uppercase mb-20 md-md-50">Document</div>
      <ul class="upb-section-items">
        <li><a href="#"><i class="fas fa-file-pdf"></i> <span>User Manual</span></a></li>
        <li><a href="#"><i class="fas fa-file-pdf"></i> <span>PC Dialer User Instruction</span></a></li>
        <li><a href="#"><i class="fas fa-clipboard-list"></i> <span>Open Ticket</span></a></li>
      </ul>
    </div>
    <!-- upb-section-wrapper end -->

    <!-- upb-section-wrapper -->
    <div class="upb-section-wrapper pt-20 pt-md-25">
      <div class="upb-section-title text-uppercase mb-20 md-md-50">User</div>
      <ul class="upb-section-items">
        <li><a href="#"><i class="fas fa-unlock-alt"></i> <span>Change Password</span></a></li>
        <li><a href="#" @click="logout"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
      </ul>
    </div>
    <!-- upb-section-wrapper end -->
  </div>
</template>

<script>
export default {
  name: "UserProfileBar",

  methods :{
    logout()
    {
      localStorage.removeItem('authToken');
      this.$router.push('/admin');
      //localStorage.setItem('authToken');
    }
  }
}
</script>

<style scoped>

</style>