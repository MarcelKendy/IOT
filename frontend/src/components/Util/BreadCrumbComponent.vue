<template>
  <div>
    <v-btn-toggle v-model="route">
      <v-btn
        small
        :class="dark_theme ? 'white--text' : ''"
        :color="dark_theme ? 'rgb(0,0,70)' : 'blue lighten-4'"
        :disabled="item.disabled"
        :to="item.href"
        v-for="item in items"
        :key="item.text"
        :value="item.text"
      >
        <v-icon left :color="dark_theme ? 'white' : 'black'">
          {{ item.icon }}
        </v-icon>
        <strong>{{ item.text }}</strong>
      </v-btn>
    </v-btn-toggle>
  </div>
</template>

<script>
export default {
  name: 'BreadCrumbComponent',
  props: ['activeRoute'],
  data: () => ({
    items: [],
    route: '',
  }),
  watch: {
    activeRoute: function () {
      this.route = this.activeRoute;
      this.defineBreadCrumb();
    },
  },
  created() {
    this.route = this.activeRoute;
    this.defineBreadCrumb();
  },
  computed: {
    dark_theme() {
      try {
        return this.$store.state.user.configs.theme == 0;
      } catch (err) {
        return false;
      }
    },
  },
  methods: {
    defineBreadCrumb() {
      switch (this.activeRoute) {
        case 'Home':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: true,
              href: '/',
            },
          ];
          break;
        case 'Dashboard':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Dashboard',
              icon: 'mdi-monitor-dashboard',
              disabled: true,
              href: '/dashboard',
            },
          ];
          break;
        case 'Comissões':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Comissões',
              icon: 'mdi-view-list',
              disabled: true,
              href: '',
            },
          ];
          break;
        case 'Checklist':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Checklist',
              icon: 'mdi-view-list',
              disabled: true,
              href: '/checklist',
            },
          ];
          break;
        case 'Usuários':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Usuários',
              icon: 'mdi-account-group',
              disabled: true,
              href: '/usuarios',
            },
          ];
          break;
        case 'Acessos':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Acessos',
              icon: 'mdi-lock',
              disabled: true,
              href: '/acessos',
            },
          ];
          break;
        case 'Uploads':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Upload',
              icon: 'mdi-file-upload',
              disabled: true,
              href: '/uploads',
            },
          ];
          break;
        case 'Associados':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Associados',
              icon: 'mdi-account-group',
              disabled: true,
              href: '/associates',
            },
          ];
          break;
        case 'Perfil':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Perfil',
              icon: 'mdi-account',
              disabled: true,
              href: '/perfil',
            },
          ];
          break;
        case 'Sobre':
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Sobre',
              icon: 'mdi-information',
              disabled: true,
              href: '/about',
            },
          ];
          break;
        default:
          this.items = [
            {
              text: 'Home',
              icon: 'mdi-view-dashboard',
              disabled: false,
              href: '/',
            },
            {
              text: 'Página não encontrada',
              icon: 'mdi-close',
              disabled: true,
              href: '/',
            },
          ];
          break;
      }
    },
  },
};
</script>

<style>
</style>
