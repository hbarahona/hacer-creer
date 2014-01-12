//HEADER******************************************************
void header(String titulo_activity) {
  fill(55);
  noStroke();
  rect(0, 0, width, 45);
  fill(80);
  quad(5, 40, 5, 5, 200, 5, 175, 40);
  quad(530, 40, 565, 5, width, 5, width, 40);
  //Dibujar el timeline
  noStroke();
  flechanav(570, 7, f[0]);
  flechanav(620, 7, f[1]);
  flechanav(670, 7, f[2]);
  flechanav(720, 7, f[3]);
  flechanav(770, 7, f[4]);
  flechanav2(820, 7, f[5]);
  //Textos
  textAlign(LEFT);
  fill(255);
  if (mouseY>7 && mouseY<37 && mouseX>25 && mouseX<152) {
    fill(color2);
    if (mousePressed) {
      activity = 0;
      UI = true;
      flagInicio = true;
    }
  }
  textFont(titulo, 24);
  text("Hacer-creer", 25, 30);
  fill(255);
  textFont(bajada, 14);
  text(titulo_activity, 205, 30);
  //Interacción
  for (int i=0;i<6;i++) {
    if (activity-1!=i) {
      f[i]=200;
    }
    if (activity-1==i) {
      f[i]=color2;
    }
  }
  if (mouseY>7 && mouseY<37) {
    if (mouseX>555 && mouseX<605) {
      f[0] = color(0, 255, 0);
      if (mousePressed) {
        activity=1;
        UI = true;
        op=0;
        animUp=20;
        toggle1.setState(true);
      }
    }
    if (mouseX>605 && mouseX<655) {
      f[1]  = color(0, 255, 0);
      if (mousePressed) {
        activity=2;
        UI = true;
        a2_llenar=0;
        a2_entrar=0;
        Ani.to(this, anim_salir, "a2_entrar", 1, Ani.QUAD_OUT);
      }
    }
    if (mouseX>655 && mouseX<705) {
      f[2]  = color(0, 255, 0);
      if (mousePressed) {
        activity=3;
        UI = true;
        curva_anim = 0;
        a3_entrar=0;
        Ani.to(this, anim_salir, "a3_entrar", 1, Ani.QUAD_OUT);
      }
    }
    if (mouseX>705 && mouseX<755) {
      f[3]  = color(0, 255, 0);
      if (mousePressed) {
        activity=4;
        UI = true;
        a4_entrar=10;
        Ani.to(this, 1, "a4_entrar", 0, Ani.SINE_OUT);
      }
    }
    if (mouseX>755 && mouseX<805) {
      f[4]  = color(0, 255, 0);
      if (mousePressed) {
        activity=5;
        UI = true;
      }
    }
    if (mouseX>805 && mouseX<880) {
      f[5]  = color(0, 255, 0);      
      if (mousePressed) {
        activity=6;
        UI = true;
      }
    }
  }
}
void flechanav(int posx, int posy, color col) {
  //noStroke();
  stroke(30);
  fill(col);
  pushMatrix();
  beginShape();
  vertex(posx, posy);
  vertex(posx+47, posy);
  vertex(posx+17, posy+30);
  vertex(posx-30, posy+30);
  vertex(posx, posy);
  endShape(CLOSE);
  popMatrix();
}
void flechanav2(int posx, int posy, color col) {
  //noStroke();
  stroke(30);
  fill(col);
  pushMatrix();
  beginShape();
  vertex(posx, posy);
  vertex(posx+50, posy);
  vertex(posx+65, posy+15);
  vertex(posx+40, posy+30);
  vertex(posx-30, posy+30);
  vertex(posx, posy);
  endShape(CLOSE);
  popMatrix();
}

//PANTALLA 1******************************************************
void figuraFondo(int[] ordinal, color cX, float o) {
  fill(cX, o/2);
  if (o>1) {
    stroke(0, o/2);
  }
  beginShape();
  for (int i = 0; i<ordinal.length; i++) {
    float inclinacion = radians(360/ordinal.length*i);
    float aux = ordinal[i];
    float map = map(aux, 0, max_visitas, 0, tamano*zoom);
    vertex(map*cos(inclinacion)+offx, map*sin(inclinacion)+offy);
  }
  endShape(CLOSE);
  stroke(0, Aristas);
}

void rectasPuntos(int[] ordinal, color cX) { //Listo
  fill(cX, op*3);
  for (int i = 0; i<ordinal.length; i++) {
    float inclinacion = radians(360/ordinal.length*i);
    float map_rectas = map(ordinal[i], 0, max_visitas, 2, tamano*zoom);
    float map_puntos = map(ordinal[i], 0, max_visitas, 1, 5.5*zoom);
    stroke(0, og*op/160);
    line(map_rectas*cos(inclinacion)+offx, map_rectas*sin(inclinacion)+offy, offx, offy);
    stroke(0, op);
    ellipse(map_rectas*cos(inclinacion)+offx+animUp*cos(inclinacion)*3, map_rectas*sin(inclinacion)+offy+animUp*sin(inclinacion)*3, map_puntos, map_puntos);
  }
}

void hover(int[] ordinal, String topSitios) { //LISTO
  for (int i = 0; i<ordinal.length; i++) {
    float inclinacion = radians(360/ordinal.length*i);
    float map_hover = map(ordinal[i], 0, max_visitas, 0, tamano*zoom);
    float map_puntos = map(ordinal[i], 0, max_visitas, 1, 5.5*zoom);
    if (dist(mouseX, mouseY, map_hover*cos(inclinacion)+offx, map_hover*sin(inclinacion)+offy+sin(inclinacion)*2.5) < map_puntos+1) {
      textAlign(LEFT);
      fill(0);
      textFont(texto, 11);
      text(topSitios+", "+ordinal[i], mouseX+3, mouseY-2);
    }
  }
}

void grafApoyo(int[] ordinal, int a, color cX, float o) {
  //Este if es para optimizar memoria
  if (o>0) {
    int suma = 0;
    for (int i=0;i<ordinal.length;i++) {
      suma=suma+ordinal[i];
    }
    //float sumap = map(suma, 0, max_visit_mes, 0, 220);

    float sumap = map(suma, 0, mesVisitaMaxima(), 0, 300);
    noStroke();
    fill(cX, 150);
    rect(1210-sumap*o/255, 110+25*a, o/255*sumap, 20);
    if (o>100) {
      fill(0);
      textFont(chico, 9);
      textAlign(RIGHT);
      text(sumaOrdinales(ordinal), 1207, 120+25*a);
    }
  }
}
//Acá suma los valores por día de cada Array (retorna el valor total del mes/array) 
int sumaOrdinales(int[] ordinal) {
  int suma=0;
  for (int i=0;i<ordinal.length;i++) {
    suma=suma+ordinal[i];
  }
  return suma;
}

//PANTALLA 2******************************************************
void grafchico(int x, int y, String nombre, int[][] datos) {
  String cruz = "0";
  //Comprobar hover
  if (mouseX > x && mouseX < x+tamgc && mouseY > y-15 && mouseY < y+tamgc) {
    fill(0, 128, 255);
    rect(x-3, y-18, tamgc+6, tamgc+21);
    fill(20);
    cruz = nombre;
    if (mousePressed) {
      gg_titulo = nombre.substring(0, 1)+nombre.substring(1, nombre.length()).toLowerCase();
      gg_datos = datos;
      a2_llenar=0.01;
      Ani.to(this, anim_entrar, "a2_llenar", 1, Ani.QUAD_OUT);
    }
  }
  else {
    fill(60, 255*a2_entrar);
  }
  noStroke();
  //Dibujar el fondo y la grilla
  rect(x-(50*(1-a2_entrar)), y, tamgc, tamgc, 0, 0, 7, 7);
  if (cruz == nombre) {
    stroke(150);
  }
  else
  {
    stroke(0);
  }
  line(x+margen, y+tamgc/2, x+tamgc-margen, y+tamgc/2);
  line(x+tamgc/2, y+margen, x+tamgc/2, y+tamgc-margen);
  //Dibujar las magnitudes
  int a1 = max(datos[0]);
  int a2 = max(datos[1]);
  int a3 = max(datos[2]);
  int a4 = max(a1, a2, a3);
  //Dibujar formas
  strokeWeight(2);
  for (int i=0;i<datos.length;i++) {
    stroke(255*(i-1), 128+128*i, 255);
    fill(255*(i-1), 255*i, 255, 50);
    beginShape();
    for (int j=0;j<datos[0].length;j++) {
      //Vertices figura
      float inclinacion = radians(90*j);
      float aux = datos[i][j];
      float map = map(aux, 0, a4, 0, tamgc/2-margen);
      vertex(map*cos(inclinacion)+x+tamgc/2, map*sin(inclinacion)+y+tamgc/2);
    }
    endShape(CLOSE);
  }
  strokeWeight(1);
  //Dibujar circulos externos
  ellipseMode(RADIUS);
  for (int i=0;i<datos.length;i++) {
    stroke(255*(i-1), 128+128*i, 255, 180);
    for (int j=0;j<datos[0].length;j++) {
      float inclinacion = radians(90*j);
      float aux = datos[i][j];
      float map = map(aux, 0, a4, 0, tamgc/2-margen);
      //stroke(0, 50);
      noFill();
      //ellipse(x+tamgc/2, y+tamgc/2, tamgc/2/5*(i+1)-margen, tamgc/2/5*(i+1)-margen);
      arc(x+tamgc/2, y+tamgc/2, map, map, inclinacion-PI*1/8, inclinacion+PI*1/4);
    }
  }
  fill(30);
  noStroke();
  rect(x, y-15, tamgc*a2_entrar, 15);
  textAlign(LEFT);
  fill(255);
  textFont(chico, 9);
  text(nombre, x+margen, y-4);
}

//GRAFICO GRANDE

void gg(int x, int y, String nombre, int[][] datos) {
  //bg
  fill(50);
  rect(x, y-85, tamgg, 85);
  for (int i=0;i<2;i++) {
    fill(30);
    rect(x, y+121*i*2, tamgg, 121); 
    fill(50);
    rect(x, y+121*(i*2+1), tamgg, 121);
  }
  //Nombre web
  textFont(titulo, 24);
  fill(255, 255*a2_llenar);
  text(gg_titulo, x+margengg, y-35);
  //Textos
  textFont(texto, 11);
  if (a2_llenar>0) {
    fill(255);
  }
  text(a2_1, x+margengg, y+121*0+16, tamgg-margengg*2, 30);
  text(a2_2, x+margengg, y+121*1+16, tamgg-margengg*2, 30);
  text(a2_3, x+margengg, y+121*2+16, tamgg-margengg*2, 30);
  text(a2_4, x+margengg, y+121*3+16, tamgg-margengg*2, 30);
  //Dibujar barras grices de fondo
  for (int i=0;i<datos.length;i++) {
    fill(200);
    stroke(0);
    for (int j=0;j<datos[0].length;j++) {
      rect(x+margengg, y+45+i*25+j*121, tamgg-2*margengg, 20);
    }
  }
  //Dibujar barras con magnitudes
  noStroke();
  for (int i=0;i<datos.length;i++) {
    //Esto es para calular la suma y en base a eso sacar el 100%
    int suma=0;
    for (int j=0;j<datos[i].length;j++) {
      suma=suma+datos[i][j];
    }
    for (int j=0;j<datos[0].length;j++) {
      fill(255*(i-1), 128+128*i, 255);
      float aux = datos[i][j];
      float map = map(aux, 0, suma, 0, tamgg-2*margengg);
      rect(x+1+margengg, y+46+i*25+j*121, a2_llenar*map, 19);
      //Escribir el %
      float porc_float = map(aux, 0, suma, 0, 100);
      int porc_int = round(porc_float);
      textFont(texto, 11);
      fill(0, 255*a2_llenar);
      text(porc_int+"%", x+20+map, y+60+i*25+j*121);
    }
  }
}

//Simbologia
void a2_simbologia(int x, int y) {
  fill(200, 255*a2_entrar);
  //Dibujar el fondo
  stroke(0);
  rect(x-(50*(1-a2_entrar)), y, tamgc*2+espaciado_vertical-1, tamgc, 0, 0, 7, 7);
  fill(30);
  noStroke();
  rect(x, y-15, (tamgc*2+espaciado_vertical)*a2_entrar, 15);
  textAlign(LEFT);
  fill(255);
  textFont(chico, 9);
  text("SIMBOLOGÍA", x+margen, y-4);
}
//PANTALLA 3***************************************************

void rect_from(int x, int y, String nombre) {
  stroke(0, 255*a3_entrar);
  fill(60, 255*a3_entrar);
  //Interactividad
  if (mouseX > x && mouseX < x+ancho_from && mouseY > y && mouseY < y+25) {
    stroke(60);
    fill(color1);
    if (mousePressed) {
      fill(color2);
      curva_anim = 0;
      a3_posx=x;
      Ani.to(this, .5, "curva_anim", 1, Ani.SINE_OUT);
    }
  }
  rect(x, y+40-a3_entrar*40, ancho_from, 25);
  //dibujar texto
  textAlign(CENTER);
  fill(255);
  textFont(texto, 11);
  text(nombre, x, y+9, ancho_from, 25);
}
void rect_to(int x, int y) {
  stroke(0, 255*a3_entrar);
  for (int i=0; i<11; i++) {
    fill(to_bg[i], 255*a3_entrar);
    rect(x+ancho_to*i, y-(30-a3_entrar*30), ancho_to, 25);
    textAlign(CENTER);
    fill(255);
    textFont(texto, 11);
    if (i<10) {
      text(topSitios.get(i), x+ancho_to*i, y+9, ancho_to, 25);
    }
    else {
      text("Otros", x+ancho_to*i, y+9, ancho_to, 25);
    }
  }
}

//Dibujar la curva desde el FROM
void curva_from(int x1, int y1, int x2, int y2) {
  int max = max(fromVisitTotales[a3_posx/99]);
  noFill();
  float factor_pronunciamiento = 4.5*mouseY;
  for (int i=0; i<11; i++) {
    noFill();
    int aux = fromVisitTotales[a3_posx/99][i];
    float map = map(aux, 0, max, 0, (ancho_to/2)-5);   
    float pronunciamiento = factor_pronunciamiento+300-50*(i+1);
    to_bg[i]=color(0, 200*fromVisitTotales[a3_posx/99][i]/max, 120*fromVisitTotales[a3_posx/99][i]/max);
    if (curva_anim<1) {
      stroke(to_bg[i], 255*curva_anim);
    }
    else {
      stroke(to_bg[i]);
    }
    for (int j=0; j<map; j++) {
      if (curva_anim<1) {     
        curva_sola(a3_posx+j/curva_anim+i*ancho_to/20, y1, x1+(ancho_to/map*j)+ancho_to*i, y2, pronunciamiento);
      }
      else {
        curva_sola(a3_posx+j+i*ancho_to/20, y1, x1+(ancho_to/map*j)+ancho_to*i, y2, pronunciamiento);
      }
    }
    //dibujar texto
    textAlign(CENTER);
    fill(20, 255*curva_anim);
    textFont(bajada, 14);
    text(fromVisitTotales[a3_posx/99][i], x1+ancho_to*(i+0.5), y2+32+8*curva_anim);
  }
}
void curva_sola(float x1, int y1, float x2, float y2, float pronunciamiento) {
  curve(x2, y1-pronunciamiento, x1, y1, x2, y2, x1, y2+pronunciamiento);
}

//PANTALLA 4***************************************************
void chileContador() {
  if (flagChileContador) {
    flagChileContador =false;
    for (int i=0;i<13;i++) {
      for (int j=0; j<8; j++) {
        for (int k=0; k<urlComparar.size(); k++) {
          if (chileLimpio[i*8+j].equals(urlComparar.get(k))) {
            chileContador[i*8+j]=true;
            break;
          }
          else {
            chileContador[i*8+j]=false;
          }
        }
      }
    }
  }
}
void chile(float x1, int y1, int margen) {
  noStroke();
  textAlign(CENTER);
  for (int i=0;i<13;i++) {
    for (int j=0; j<8; j++) {
      //chileLimpio[i*8+j] = chileLimpio[i*8+j].toUpperCase();
      if (chileContador[i*8+j]==true) {
        fill(color1, 255-(25.5*a4_entrar));
        rect(x1+j*(sizex+a4_margen), y1+i*(sizey+a4_margen), sizex+a4_margen, sizey+a4_margen-a4_entrar*(i+2*j));           
        fill(255, 3*(anim_chile-30));
        text(chile[i*8+j], x1+j*(sizex+a4_margen), y1+i*(a4_margen+sizey)+10, sizex, sizey);
      }
      else {
        fill(color3, 255-(25.5*a4_entrar));
        rect(x1+j*(sizex+a4_margen), y1+i*(sizey+a4_margen), sizex+a4_margen, sizey+a4_margen-a4_entrar*(i+2*j));
      }

      fill(255, 3*(anim_chile-30));
      text(chile[i*8+j], x1+j*(sizex+a4_margen), y1+i*(a4_margen+sizey)+10, sizex, sizey);
    }
  }
}

void mundoContador() {
  if (flagMundoContador) {
    flagMundoContador =false;
    for (int i=0;i<13;i++) {
      for (int j=0; j<8; j++) {
        for (int k=0; k<urlComparar.size(); k++) {
          if (mundoLimpio[i*8+j].equals(urlComparar.get(k))) {
            mundoContador[i*8+j]=true;
            break;
          }
          else {
            mundoContador[i*8+j]=false;
          }
        }
      }
    }
  }
}
void mundo(float x1, int y1, int margen) {
  noStroke();
  textAlign(CENTER);
  for (int i=0;i<13;i++) {
    for (int j=0; j<8; j++) {
      if (mundoContador[i*8+j]==true) {
        fill(color1, 255*mundo_op);
        rect(x1+j*(sizex+a4_margen), y1+i*(sizey+a4_margen), sizex+a4_margen, sizey+a4_margen);           
        fill(255, 3*(anim_chile-30)*mundo_op);
        text(mundo[i*8+j], x1+j*(sizex+a4_margen), y1+i*(a4_margen+sizey)+10, sizex, sizey);
      }
      else {
        fill(color3, 255*mundo_op);
        rect(x1+j*(sizex+a4_margen), y1+i*(sizey+a4_margen), sizex+a4_margen, sizey+a4_margen);
      }

      fill(255, 3*(anim_chile-30)*mundo_op);
      text(mundo[i*8+j], x1+j*(sizex+a4_margen), y1+i*(a4_margen+sizey)+10, sizex, sizey);
    }
  }
}








//Interacción
void mouseReleased() {
  if (activity==4) {
    if (mouseX > width-100-30 && mouseX < width && mouseY > 70 && mouseY < 115) {
      if (mundo_op==0) {
        toggleChile = false;
        Ani.to(this, .5, "mundo_op", 1, Ani.BOUNCE_IN);
      } 
      else {
        toggleChile = true;
        Ani.to(this, .5, "mundo_op", 0, Ani.BOUNCE_IN);
      }
    }
    if (mouseX > width-100-30 && mouseX < width && mouseY > 145 && mouseY < 190) {
      if (anim_chile==140) {
        toggleAbierto = false;
        Ani.to(this, .5, "anim_chile", 25, Ani.SINE_OUT);
        Ani.to(this, .5, "a4_x", 450, Ani.SINE_OUT);
      } 
      else {
        toggleAbierto = true;
        Ani.to(this, .5, "anim_chile", 140, Ani.SINE_OUT); 
        Ani.to(this, .5, "a4_x", 25, Ani.SINE_OUT);
      }
    }
  }
  if (activity==6) {
    if (mouseX>50 && mouseX<width-50 && mouseY>50 && mouseY<height-150) {
      link("http://hacercreer.wordpress.com/2014/01/12/comentarios-opiniones-y-sugerencias/");
    }
  }
}
void funcionToggleChile() {
  if (mouseX > width-100-30 && mouseX < width && mouseY > 70 && mouseY < 115) {
    fill(color2);
  }
  else {
    fill(color1);
  }
  if (toggleChile==false) {
    rect(width-100-30, 95, 100, 20);
  }
  else {
    rect(width-100-30, 70, 100, 20);
  }

  if (mouseX > width-100-30 && mouseX < width && mouseY > 145 && mouseY < 190) {
    fill(color2);
  }
  else {
    fill(color1);
  }
  if (toggleAbierto==true) {
    rect(width-100-30, 145, 100, 20);
  }
  else {
    rect(width-100-30, 170, 100, 20);
  }
}

//PANTALLA 5***************************************************
void calcularRazones() {
  //println(topSitios.get(1));
  //Visitas totales
  visitasTotales = 0;
  for (int i=0; i<visitas.size(); i++) {
    visitasTotales = visitasTotales+visitas.get(i);
  }
  //Calcular tops
  r1=0;
  for (int i=1;i<11;i++) {
    r1=r1+visitas.get(visitas.size()-i);
  }
  r2=0;
  for (int i=1;i<6;i++) {
    r2=r2+visitas.get(visitas.size()-i);
  }
  r3 = visitas.get(visitas.size()-1);
  //Calcular razones
  float razon1 = r1*10000/visitasTotales;
  float razon2 = r2*10000/visitasTotales;
  float razon3 = r3*10000/visitasTotales;
  razon1 = razon1/10000;
  razon2 = razon2/10000;
  razon3 = razon3/10000;
  //Convertir en radianes
  float deg1 = map(razon1, 0, 1, 0, 360);
  float deg2 = map(razon2, 0, 1, 0, 360);
  float deg3 = map(razon3, 0, 1, 0, 360);
  rr1 = radians(deg1);
  rr2 = radians(deg2);
  rr3 = radians(deg3);
}

void hover5(float rr, int x) {
  noStroke();
  fill(255, 200);
  rect(mouseX-2, mouseY-17, 420, 20);
  textAlign(LEFT);
  fill(0);
  textFont(texto, 11);
  float radMap = map(rr, 0, TWO_PI, 0, 1);
  radMap = int(radMap*pow(10, 2))/pow(10, 2);
  if (x==1) {
    text("Sólo 1 sitio es el "+round(radMap*100)+"% de las páginas totales que visitas", mouseX, mouseY-2);
  }
  else {
    text(x+" sitios hacen el "+round(radMap*100)+"% de las páginas totales que visitas", mouseX, mouseY-2);
  }
}

void dibujarRazones(int x, int y, float rr, color col) {
  noFill();
  stroke(40);
  strokeWeight(60);
  ellipse(x, y, 197, 197);
  strokeWeight(50);
  stroke(col);
  arc(x, y, 200, 200, -HALF_PI, (rr*anim5)-HALF_PI);
  stroke(200);
  arc(x, y, 200, 200, rr+0.05-HALF_PI, (PI+HALF_PI-0.05-(rr+0.05-HALF_PI))*anim5_2+(rr+0.05-HALF_PI));
  float radMap = map(rr, 0, TWO_PI, 0, 1);
  textFont(titulo, 24);
  textAlign(CENTER);
  fill(40);
  text(radMap*anim5*10, x, y+12);
}
void calularTotal() {
  float radMap1 = map(rr1, 0, TWO_PI, 0, 1); 
  float radMap2 = map(rr2, 0, TWO_PI, 0, 1); 
  float radMap3 = map(rr3, 0, TWO_PI, 0, 1);
  nivel = (radMap1+radMap2+radMap3)/3*10;
  nivel = int(nivel*pow(10, 2))/pow(10, 2);
}

//ESTAS DEBERÁN BORRARSE--------------------------------------
void keyPressed() {
  if (key == '0') {
    activity = 0;
    UI = true;
    flagInicio = true;
    animInicio1 = 0;
    animInicioCaer = 0;
    contador = 0;
  }
  if (key == '1') {
    activity = 1;
    UI = true;
    op=0;
    animUp=20;
    toggle1.setState(true);
  }
  if (key == '2') {
    activity = 2;
    UI = true;
    a2_llenar=0;
    a2_entrar=0;
    Ani.to(this, anim_salir, "a2_entrar", 1, Ani.QUAD_OUT);
  }
  if (key == '3') {
    activity = 3;
    UI = true;
    curva_anim = 0;
    a3_entrar=0;
    Ani.to(this, anim_salir, "a3_entrar", 1, Ani.QUAD_OUT);
  }
  if (key == '4') {
    activity = 4;
    UI = true;
    a4_entrar=10;
    Ani.to(this, 1, "a4_entrar", 0, Ani.SINE_OUT);
  }
  if (key == '5') {
    activity = 5;
    UI = true;
  }
  if (key == '6') {
    activity = 6;
    UI = true;
  }
}
void controlEvent(ControlEvent theEvent) {
  if (checkbox.getItem(0).value()==1.0) {
    Ani.to(this, anim_entrar, "o1", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(0).value()==0.0) {
    Ani.to(this, anim_salir, "o1", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(1).value()==1.0) {
    Ani.to(this, anim_entrar, "o2", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(1).value()==0.0) {
    Ani.to(this, anim_salir, "o2", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(2).value()==1.0) {
    Ani.to(this, anim_entrar, "o3", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(2).value()==0.0) {
    Ani.to(this, anim_salir, "o3", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(3).value()==1.0) {
    Ani.to(this, anim_entrar, "o4", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(3).value()==0.0) {
    Ani.to(this, anim_salir, "o4", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(4).value()==1.0) {
    Ani.to(this, anim_entrar, "o5", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(4).value()==0.0) {
    Ani.to(this, anim_salir, "o5", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(5).value()==1.0) {
    Ani.to(this, anim_entrar, "o6", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(5).value()==0.0) {
    Ani.to(this, anim_salir, "o6", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(6).value()==1.0) {
    Ani.to(this, anim_entrar, "o7", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(6).value()==0.0) {
    Ani.to(this, anim_salir, "o7", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(7).value()==1.0) {
    Ani.to(this, anim_entrar, "o8", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(7).value()==0.0) {
    Ani.to(this, anim_salir, "o8", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(8).value()==1.0) {
    Ani.to(this, anim_entrar, "o9", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(8).value()==0.0) {
    Ani.to(this, anim_salir, "o9", 0, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(9).value()==1.0) {
    Ani.to(this, anim_entrar, "o10", 255, Ani.CUBIC_OUT);
  }
  if (checkbox.getItem(9).value()==0.0) {
    Ani.to(this, anim_salir, "o10", 0, Ani.CUBIC_OUT);
  }
  if (toggle2.value()==1) {
    Ani.to(this, anim_salir, "og", 100, Ani.QUAD_OUT);
  }
  if (toggle2.value()==0) {
    Ani.to(this, anim_salir, "og", 0, Ani.QUAD_OUT);
  }
  if (toggle1.value()==0) {
    Ani.to(this, anim_salir, "op", 0, Ani.QUAD_OUT);
    Ani.to(this, anim_salir, "animUp", 20, Ani.QUAD_OUT);
  }
  if (toggle1.value()==1) {
    Ani.to(this, anim_salir, "op", 80, Ani.QUAD_OUT);
    Ani.to(this, anim_salir, "animUp", 0, Ani.QUAD_OUT);
  }
}
//DE PANTALLA 4
//if (key == 'a') {
//  Ani.to(this, .5, "anim_chile", 140, Ani.SINE_OUT); 
//  Ani.to(this, .5, "a4_x", 25, Ani.SINE_OUT);
//}
//if (key == 'w') {
//  Ani.to(this, .5, "mundo_op", 1, Ani.BOUNCE_IN);
//}
//if (key == 'c') {
//  Ani.to(this, .5, "mundo_op", 0, Ani.BOUNCE_IN);
//}
//}
//void mousePressed() {
//  Ani.to(this, .5, "anim_chile", 25, Ani.SINE_OUT);
//  Ani.to(this, .5, "a4_x", 450, Ani.SINE_OUT);
//}

