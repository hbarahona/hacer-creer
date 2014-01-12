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
float animInicio3 = 0;
float animInicio4 = 0;
float animInicio5 = 0;
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
float animTexto1 = 0;

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
Boolean toggleChile = true;
Boolean toggleAbierto = false;

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
float anim5_3=0;
int totalUrs = 0;
float nivel=0;

//PANTALLA 6 *********************
int cantidad2=150;
boolean flag6=true;
float[] randoms = new float[cantidad2];
float[] randoms2 = new float[cantidad2];
float[] ruidosx = new float[cantidad2];
float[] ruidosy = new float[cantidad2];
int prendido=0;

//GLOBALES *********************
PFont chico;
PFont texto;
PFont bajada;
PFont titulo;
PFont inicio;
color[] f = new color[6];

float activity = 0;
//Textos
String lipsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
String pantalla0 = "Bienvenido. ";
String pantalla0_2 = "Este software se enmarca en el proyecto para optar al título de “Diseñador Gráfico” de Ricardo Ossandón Valle. \n\nA través del recorrido por distintas pantallas podrás ver  tu comportamiento de navegación Web, esto tiene por objetivo determinar tu nivel de endogamia de navegación y a su vez, mostrarte el sesgo en la obtención de información al que podrías estar sometido. \n\nTodos los datos aquí utilizados y mostrados son tuyos, privados y confidenciales. No son enviados ni subidos a internet ni a otro computador. \nProbablemente Google Inc. sí los conoce. \n\nLa dirección del proyecto y el diseño y desarrollo front-end (la parte visible) son responsabilidad de Ricardo Ossandón Valle, licenciado en Diseño, mención Diseño Gráfico Universidad de Chile. El back-end (las funciones internas y la comunicación con la base de datos) fue desarrollado por Héctor Barahona Gallardo, actual estudiante de Licenciatura en Ciencias de la Computación en la Universidad de Santiago de Chile. Santiago de Chile, enero de 2014.";
String pantalla1 = "Para desplazarte por las distintas pantallas usa la barra de botones superior. \nPara interactuar con cada gráfico usa la barra de botones ubicada a la derecha \n \nEste gráfico muestra tus diez sitios más visitados durante el último mes. Puedes activar la grilla para conocer el detalle por día. \nSi uno o dos sitios son muy superiores al resto, significa que tienes un mayor nivel de endogamia (mucha reiteración en un campo muy sesgado).";
String pantalla2 = "Estos gráficos muestran la forma en la que accediste a cada uno de estos sitios. Para conocer detalles haz clic sobre alguno de ellos.";
String pantalla2_2 = "-Si las flechas predominan hacia la DERECHA significa que estás muy seguro de la información que requieres desde internet.\n-Si las flechas predominan hacia ABAJO o hacia la IZQUIERDA significa que te dejas llevar por lo que aparece frente a ti, tu navegación está determinada por lo que las páginas (abajo) o el software (izquierda) te dispone. \n-Si las flechas predominan hacia ARRIBA significa que el software hace cosas a tus espaldas, te despliega información que tú ni siquiera requeriste. ¡Cuidado!";
String pantalla3 = "Este gráfico muestra el destino al que te lleva cada uno de tus sitios más visitados. Haz click en los sitios de la columna superior para ver ‘a dónde’ te han llevado.";
String pantalla3_2 = "Un sitio que fomente la endogamia, el sesgo y la reiteración sólo te conducirá hacia él mismo. Por el contrario, un sitio que abra nuevas posibilidades de navegación será el que te lleve hacia otros sitios.";
String pantalla4 = "Este gráfico te muestra de forma holística los 100 sitios Web más visitados de Chile o del mundo (según la selección en el costado derecho) y si has accedido o no a ellos (si nunca has accedido a un sitio, éste se mostrará en naranjo; si has accedido al menos una vez, éste se mostrará en calipso).";
String pantalla4_2 = "Una predominancia del color naranjo significa que te estás perdiendo algo muy popular, aunque recuerda que los sitios más visitados no siempre ofrecen el mejor contenido.";
String pantalla5 = "En base a todo lo anterior, este software determinará el nivel de endogamia en tu navegación Web. Esta operación se basa en 3 razones (expresadas en los anillos que ves abajo) que determinarán tu nivel total de endogamia (en una escala de 0 a 10).";
String pantalla5_2 = "Este número representa el sesgo en la información que recibes desde internet; un mayor valor significa que es menos probable que recibas información fuera del eco-sistema digital que te has creado, lo cual implica una visión parcializada o incluso puntualizada de la realidad.\n(Más de 5 ya es considerado endogámico).";
String pantalla5_3 = "error!";
String pantalla5_4 = "error!";
String pantalla6 = "Para concluir, te invito a que compartas esta experiencia. Quiero saber qué te pareció, aceptar sugerencias, aclarar dudas, leer opiniones distintas a la mía. El internet actual está siendo constantemente construido por cada uno de nosotros.\n¡Muchas gracias por tu tiempo! Para compartir, haz click en la red de nodos arriba de este texto. Para salir, haz click en la X ubicada en la esquina superior derecha del programa.";




