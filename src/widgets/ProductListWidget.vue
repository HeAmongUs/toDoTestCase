<script setup lang="ts">
import LabelInput from "@/shared/components/LabelInput.vue";
import VButton from "@/shared/components/VButton.vue";
import { computed, Ref, ref, watch } from "vue";
import type { IProduct, IProductWithoutId } from "@/entries/product";
import VCheckbox from "@/shared/components/VCheckbox.vue";

const products: Ref<Array<IProduct>> = ref([]);
products.value =
  JSON.parse(localStorage.getItem("product-list-widget") || "{}")?.products ||
  ([] as Array<IProduct>);

watch(
  () => products.value,
  (v) => {
    localStorage.setItem(
      "product-list-widget",
      JSON.stringify({ products: v })
    );
  },
  { deep: true }
);

const newProduct: Ref<IProductWithoutId> = ref({
  completed: false,
});
function productPushHandler(toPushProduct: IProductWithoutId): void {
  if (toPushProduct.name) {
    products.value.push({
      id: new Date().getTime(),
      ...toPushProduct,
    });

    newProduct.value.name = null;
  }
}

const sortedProducts: Ref<Array<IProduct>> = computed(() =>
  [...products.value].sort((a, b) => {
    if (a.completed === b.completed) {
      return a.id - b.id;
    } else if (a.completed) return 1;
    return -1;
  })
);
</script>

<template>
  <div class="product-list-widget">
    <div class="card">
      <div class="card-title">
        <h5 class="card-title__title">
          Список <span class="text-line-through">задач</span> продуктов
        </h5>
      </div>
      <div class="card-text">
        <div class="d-flex align-center gap-4">
          <label-input
            v-model="newProduct.name"
            @keydown.enter="productPushHandler(newProduct)"
            label="Новый продукт"
          />
          <v-button @click="productPushHandler(newProduct)" text="Добавить" />
        </div>
        <ul class="product-list">
          <li
            class="product-list-item"
            v-for="product in sortedProducts"
            :key="product.id"
          >
            <v-checkbox v-model="product.completed" />
            <div
              class="product-list-item__name"
              :class="{ 'text-line-through': product.completed }"
            >
              {{ product.name }}
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<style lang="scss"></style>
