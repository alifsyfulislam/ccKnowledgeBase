<template>
    <div class="modal fade" id="profileDetails" tabindex="-1" aria-labelledby="profileDetailsLabel" aria-hidden="true">
      <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-body profile-content p-20">
                <h4 class="user-title text-center pb-30 my-0">Jhon Doe</h4>

                <div class="form-group border-bottom pb-3">
                    <strong>Email:</strong> jhondoe@kbs.com
                </div>

                <div class="form-group border-bottom pb-3">
                    <strong>Roles:</strong> User
                </div>

                <div class="form-group border-bottom pb-3 mb-0">
                    <strong>Skills:</strong> Joy Bangla, Joy Mama
                </div>
            </div>
          </div>
      </div>
    </div>
</template>

<script>
export default {

}
</script>

<style>
  .header {
      z-index: 1039;
  }

  .user-title {
    font-size: 24px;
    font-weight: 600;
    color: #000;
  }
</style>
