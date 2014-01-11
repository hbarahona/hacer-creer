import controlP5.*;
ControlP5 cp5;
CheckBox checkbox, checkbox2;
Toggle toggle1, toggle2;
Slider slider1, slider2;
import de.looksgood.ani.*;
boolean first_time = true;

//PANTALLA 0 *********************
boolean flagInicio=true;
int[] w = new int[500];
int[] h = new int[500];
float animInicio1 = 0;
float animInicio2 = 0;
float animInicioCaer = 0;
int contador = 0;

//PANTALLA 1 *********************
int Aristas = 35;
float zoom = 1;
float og = 0;
float op = 80;
int fuentes = 0;
float animUp = 0;
boolean UI = true;
float o1 = 0;
float o2 = 0;
float o3 = 0;
float o4 = 0;
float o5 = 0;
float o6 = 0;
float o7 = 0;
float o8 = 0;
float o9 = 0;
float o10 = 0;

//PANTALLA 2 *********************
String gg_titulo = "Nombre Web";
int[][] gg_datos = new int[3][4];
float a2_llenar = 0;
float a2_entrar = 0;
String a2_1 = "Este es el porcentaje de veces que accediste a esta Web ESCRIBIENDO SU URL EN LA BARRA DE DIRECCIONES.";
String a2_2 = "Este es el porcentaje de veces que accediste a esta Web SIGUIENDO UN VÍNCULO (desde este mismo sitio o desde otro).";
String a2_3 = "Este es el porcentaje de veces que accediste a esta Web POR UNA SUGERENCIA de tu navegador.";
String a2_4 = "Este es el porcentaje de veces que este sitio Web se ABRIÓ DE MANERA AUTOMÁTICA.";
//PANTALLA 3 *********************
float curva_anim = 0;
float a3_entrar = 0;
//PANTALLA 4 *********************
boolean flagChileContador = true;
boolean flagMundoContador = true;
Boolean[] chileContador = new Boolean[110];
Boolean[] mundoContador = new Boolean[110];
float a4_entrar = 10;

//PANTALLA 5 *********************
int visitasTotales = 0;
int r1 = 0;
int r2 = 0;
int r3 = 0;
float rr1 = 0;
float rr2 = 0;
float rr3 = 0;
float anim5=0;
float anim5_2=0;

//GLOBALES *********************
PFont chico;
PFont texto;
PFont bajada;
PFont titulo;
PFont inicio;

float activity = 0;
//Textos
String lipsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
String pantalla0 = "";

