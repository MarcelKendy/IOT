<template>
  <div :class="margin">
    <v-img
      class="bg"
      :src="require('@/assets/images/iot/agro-iot.jpg')"
    ></v-img>
    <home-component />
  </div>
</template>

<script>
import HomeComponent from '../components/HomeComponent';

export default {
  name: 'HomeView',

  components: {
    HomeComponent,
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
<style scoped>
.bg {
  filter: brightness(80%);
  position: relative;
  overflow: hidden;
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  background: no-repeat center center;
  background-size: cover;
  transform: scale(1.1);
}
</style>
