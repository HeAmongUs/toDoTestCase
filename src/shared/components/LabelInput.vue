<template>
  <div class="input-wrapper" @click="focus()">
    <input
      ref="input"
      class="input"
      :value="lazyModelValue"
      :class="{ fulled: ![null, undefined, ''].includes(lazyModelValue as any) }"
      :type="type"
      @input="updateModelValue($event.target.value)"
    />
    <span v-if="label" class="label">{{ label }}</span>
  </div>
</template>

<script setup lang="ts">
import { Ref, ref, watch } from "vue";

const emits = defineEmits(["update:modelValue"]);
interface Props {
  modelValue: string | number | null;
  type?: string;
  label: string;
  borderRadius?: string;
}

const props = withDefaults(defineProps<Props>(), {
  modelValue: null,
  type: "text",
  label: "Label",
  borderRadius: "4px",
});

const input = ref();
const focus = (): void => {
  input.value.focus();
};

const lazyModelValue: Ref<Props["modelValue"]> = ref(null);
const updateModelValue = (v: Props["modelValue"]) => {
  lazyModelValue.value = v;
  emits("update:modelValue", v);
};

watch(
  () => props.modelValue,
  (value) => {
    lazyModelValue.value = value;
  },
  { immediate: true }
);
</script>

<style scoped lang="scss">
.input {
  padding: 20px 4px 0 16px;
  height: 56px;
  width: 100%;
  border: 1px solid var(--grey);
  border-radius: v-bind(borderRadius);

  &:focus {
    outline: none;
  }
}
.input-wrapper {
  position: relative;
  width: 100%;
  border-radius: v-bind(borderRadius);
  cursor: text;
  .input:focus,
  .input.fulled {
    transition: $transition-duration-default;
    & + .label {
      top: 5px;
      left: 0;
      border-bottom-right-radius: 4px;
      border-bottom-left-radius: 4px;
      height: 40%;
      transition: $transition-duration-default;
    }
  }
  .input:focus {
    border-color: var(--primary);
    & + .label {
      color: var(--primary);
    }
  }
  .label {
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    display: flex;
    align-items: center;
    margin-left: 16px;
    transition: font-size, left, top, $transition-duration-default;
    user-select: none;
    color: var(--grey);
  }
}
</style>
