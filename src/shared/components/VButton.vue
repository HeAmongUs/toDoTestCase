<template>
  <button class="v-button" :class="`v-button_${variant}`">
    <slot>
      {{ text }}
    </slot>
  </button>
</template>

<script setup lang="ts">
import type { Nullable, Variant } from "@/shared/types";

interface Props {
  variant?: Variant;
  text?: Nullable<string>;
}
withDefaults(defineProps<Props>(), {
  variant: "tonal",
  text: null,
});
</script>

<style lang="scss">
.v-button {
  border-radius: 100px;
  font-size: 14px;
  line-height: 24px;
  height: 44px;
  width: fit-content;
  padding: 10px 20px;
  border: none;

  &:hover {
    cursor: pointer;
  }

  &:focus {
    outline: none;
  }

  &_tonal {
    background: var(--primary);
    color: white;
  }

  &_outlined {
    background: transparent;
    color: var(--primary);
    border: 2px solid var(--primary);
  }

  &_text {
    background: transparent;
    color: var(--primary);
  }
}
</style>
