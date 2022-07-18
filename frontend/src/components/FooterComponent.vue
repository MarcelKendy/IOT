<template>
  <v-footer dark padless>
    <v-card class="flex" flat tile>
      <v-img
        src="../assets/images/iot/background.jpg"
        :gradient="
          $route.name != 'Landing'
            ? dark_theme
              ? 'to bottom left, rgba(43,12,127,.6), rgba(0,180,85,.7)'
              : 'to bottom left, rgba(173,12,227,.6), rgba(0,260,145,.4)'
            : 'to bottom left, rgba(43,92,107,.6), rgba(0,10,55,.7)'
        "
        dark
        class="pt-5 text-center"
        max-height="82"
      >
        <div
          v-for="item in items"
          :key="item.destination"
          style="width: 100px; display: inline"
        >
          <v-tooltip
            id="tooltip"
            top
            :color="dark_theme ? 'grey darken-3' : ''"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                class="mx-10"
                text
                target="_blank"
                :href="item.destination"
                v-bind="attrs"
                v-on="on"
              >
              
              </v-btn>
            </template>
            <span>{{ item.title }}</span>
          </v-tooltip>
          <span v-if="item.icon">{{ item.title }}</span>
        </div>
      </v-img>
      <v-card-text class="py-2 white--text text-center">
        {{ new Date().getFullYear() }} —
        <strong>Universidade Federal de Viçosa - Sistemas de Informação</strong> —
        CRP
      </v-card-text>
    </v-card>
  </v-footer>
</template>

<script>
export default {
  name: 'FooterComponent',

  data: () => ({
    link_modal: false,
    items: [],

    items_links: [],
  }),
  computed: {
    dark_theme() {
      return true;
    },
  },
};
</script>
<style scoped>
.effect {
  transition: 0.2s;
}
.effect:hover {
  background-color: aquamarine;
  box-shadow: 0px 2px 10px 1px rgb(39, 58, 59), 0px 0px 0px 0px;
}
.effect-dark {
  transition: 0.2s;
}
.effect-dark:hover {
  background-color: rgb(48, 89, 75);
  box-shadow: 0px 2px 10px 1px rgb(36, 101, 106), 0px 0px 0px 0px;
}
</style>