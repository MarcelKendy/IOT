<template>
  <div :class="margin">
    <v-alert
      icon="mdi-information"
      color="blue"
      border="left"
      elevation="7"
      dark
      prominent
    >
      <v-img
        width="32"
        style="display: inline-block"
        class="mr-3"
        src="@/assets/images/iot/ufv.png"
      ></v-img
      ><strong>PROJETO DA DISCIPLINA SIN 492</strong>
      <v-spacer></v-spacer>
      <span
        >Demonstração de um possível projeto vinculado a mecanismos IOT para
        atender as necessidades de um nicho rural</span
      >
      <v-spacer class="mb-6"></v-spacer>
      <v-list class="students-list mb-10">
        <v-list-item>
          <strong>Alunos:</strong>
        </v-list-item>
        <v-list-item
          :href="`https://api.whatsapp.com/send/?phone=${item.phone}`"
          v-for="item in students"
          :key="item.registration"
          class="students-list-item"
        >
          <v-list-item-avatar width="32">
            <v-img :src="require('@/assets/images/iot/' + item.photo)"></v-img>
          </v-list-item-avatar>
          <v-list-item-title class="ml-5">
            <strong>{{ item.name }}</strong>
            <v-list-item-subtitle>
              Matrícula: <strong>{{ item.registration }}</strong>
            </v-list-item-subtitle>
          </v-list-item-title>
        </v-list-item>
      </v-list>
    </v-alert>
  </div>
</template>

<script>
export default {
  name: 'AboutView',

  components: {},
  data: () => ({
    students: [
      {
        name: 'Marcel Kendy Rabelo Matsumoto',
        registration: 5200,
        photo: 'marcel.jpg',
        phone: '5534988753671'
      },
      {
        name: 'Raphael Weiner Peres dos Santos',
        registration: 5224,
        photo: 'raphael.jpg',
        phone: '553499669431'
      },
      {
        name: 'João Pedro Pereira da Silva',
        registration: 5199,
        photo: 'joao.jpg',
        phone: '553491323200'
      },
    ],
  }),
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
.students-list-item {
  transition: 0.3s
}
.students-list-item:hover {
  transition: 0.3s;
  background-color: rgba(0, 0, 0, 0);
  box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px,
    rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px,
    rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px !important;
}
.students-list {
  background-color: rgba(0, 0, 0, 0);
}
</style>