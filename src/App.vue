<template>
  <div class="container">
    <div class="d-flex justify-center">
      <product-list-widget />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import ProductListWidget from "@/widgets/ProductListWidget.vue";

export default defineComponent({
  name: "App",
  components: {
    ProductListWidget,
  },
});
</script>
