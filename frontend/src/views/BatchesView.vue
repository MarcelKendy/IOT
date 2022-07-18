<template>
  <div :class="margin">
    <batches-component />
  </div>
</template>

<script>
import BatchesComponent from '../components/BatchesComponent';

export default {
  name: 'BatchesView',

  components: {
    BatchesComponent,
  },
  methods: {
    margin_calculate() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 'ma-2';
        case 'sm':
          return 'ma-5';
        case 'md':
          return 'ma-7';
        case 'lg':
          return 'ma-14';
        case 'xl':
          return 'ma-16';
        default:
          return 'ma-10';
      }
    },
  },
  computed: {
    margin() {
      return this.margin_calculate();
    },
  },
};
</script>
