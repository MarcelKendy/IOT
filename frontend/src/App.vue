<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer" app dark>
      <v-img
        height="216px"
        :src="require('./assets/images/iot/circuitsbg2.png')"
        gradient="to bottom left, rgba(3,50,24,.1), rgba(43,200,174,.1)"
        dark
        class="pt-5 text-center"
      >
        <v-avatar size="120px">
          <v-img
            alt="Avatar"
            :src="require('./assets/images/iot/ufv.png')"
          ></v-img>
        </v-avatar>

        <v-list-item class="mt-1">
          <v-list-item-content>
            <v-list-item-title
              style="font-family: 'Quicksand', sans-serif; font-size: 24px"
            >
              <strong>Projeto IOT</strong>
            </v-list-item-title>
            <v-list-item-subtitle>
              Universidade Federal de Viçosa
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-img>

      <v-divider color="black"></v-divider>

      <v-list dense nav active-class="bg-active">
        <v-list-item
          v-for="item in items"
          :key="item.title"
          :to="item.to"
          class="item-nav"
        >
          <v-list-item-icon>
            <v-img
              v-if="item.img"
              width="10"
              :src="require('./assets/images/iot/' + item.img)"
            ></v-img>
            <v-icon v-else color="rgb(18,150,145)">{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-list-item class="item-nav" to="/about">
          <v-list-item-icon>
            <v-icon color="rgb(18,150,145)">mdi-information</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Sobre</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  <!-- src="./assets/images/iot/background.jpg"   -->
    <v-app-bar
      class="slow"
      :shrink-on-scroll="shrink_app_bar || drawer"
      app
      shrink
      color="rgba(3,130,37,.9)"
      dark
      src="./assets/images/iot/irrigation.jpg"
      fade-img-on-scroll
      scroll-threshold="200"
    >
      <template v-slot:img="{ props }">
        <v-img
          v-bind="props"
          gradient="to top left, rgba(0,135,57,.5), rgba(0,50,100,.5)"
        ></v-img>
      </template>

      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>

      <v-img
        class="ma-2"
        max-width="32"
        src="./assets/images/iot/ufv.png"
      ></v-img>
      <strong style="font-size: 24px" class="font-quicksand mx-2 mt-1"
        >Projeto de IOT</strong
      >

      <v-spacer></v-spacer>

    </v-app-bar>

    <v-main class="font-quicksand bg-black">
      <router-view></router-view>
    </v-main>
    <footer-component></footer-component>
  </v-app>
</template>
<script>
import FooterComponent from './components/FooterComponent.vue';

export default {
  components: { FooterComponent },
  data: () => ({
    drawer: false,
    shrink_app_bar: true,
    items: [
      {
        title: 'Dashboard',
        icon: 'mdi-monitor-dashboard',
        to: '/',
      },
      {
        title: 'Áreas',
        icon: 'mdi-map-marker-radius',
        to: '/batches',
      },
      {
        title: 'Culturas',
        icon: 'mdi-sprout',
        to: '/cultures',
      },
      {
        title: 'Parâmetros',
        icon: 'mdi-sprinkler-variant',
        to: '/parameters',
      },
    ],
  }),
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        document.title = 'IOT - ' + to.name || 'IOT';
      },
    },
  },
  mounted() {
    let _this = this
    setTimeout(() => {
      _this.shrink_app_bar = false
    }, 3000)
  },
  methods: {},
  computed: {},
};
</script>
<style scoped>
/*
font-family: 'Asap Condensed', sans-serif;
font-family: 'Bebas Neue', cursive;
font-family: 'Concert One', cursive;
font-family: 'Courgette', cursive;
font-family: 'Dancing Script', cursive;
font-family: 'Fredoka One', cursive;
font-family: 'Pacifico', cursive;
font-family: 'Parisienne', cursive;
font-family: 'Patrick Hand', cursive;
font-family: 'Permanent Marker', cursive;
font-family: 'Press Start 2P', cursive;
font-family: 'Quicksand', sans-serif;
font-family: 'Satisfy', cursive;
font-family: 'Shadows Into Light', cursive;
font-family: 'Yanone Kaffeesatz', sans-serif;
*/
.slow {
  transition: 0.3s;
}
</style>
<style src="./assets/css/globalStyle.css"></style>

