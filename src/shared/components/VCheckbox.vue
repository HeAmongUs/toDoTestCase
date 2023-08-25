<template>
  <div
    class="checkbox"
    :class="{ unchecked: !modelValue, animation: wasChange && !modelValue }"
    @click="$emit('update:modelValue', !modelValue)"
  >
    <div
      class="box"
      :class="{ checked: modelValue, animation: wasChange && modelValue }"
    ></div>
    <div v-if="label" class="white select-no" :class="labelClass">
      {{ label }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from "vue";

defineEmits(["update:modelValue"]);

interface Props {
  modelValue: boolean;
  label?: string;
  labelClass?: string;
}

const props = defineProps<Props>();

const wasChange = ref(false);
const unwatchWasChange = watch(
  () => props.modelValue,
  () => {
    wasChange.value = true;
    unwatchWasChange();
  }
);
</script>

<style lang="scss">
.checkbox {
  position: relative;
  width: 16px;
  height: 16px;
  display: flex;
  align-items: center;
  cursor: pointer;

  .checked {
    background: var(--primary);

    &::after {
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 14px;
      width: 100%;
      height: 100%;
      content: "✔";
      font-weight: bold;
      color: var(--primary);
    }
  }

  .box {
    min-width: 100%;
    position: relative;
    width: 100%;
    height: 100%;
    border: 2px solid #667085;
    background: #fff;
    border-radius: 2px;
    transition: 0.3s;

    &.checked {
      border: 2px solid var(--primary);
    }

    &:hover {
      border: 2px solid var(--primary);
    }
  }
}
</style>
