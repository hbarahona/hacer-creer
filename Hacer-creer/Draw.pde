void draw() {
  //translate(-mouseX,0);
  if (activity==0) {
    if (UI==true) {
      UI = false;
      setup();
    }
    if (flagInicio) {
      flagInicio = false;
      contador = 0;
      for (int i=0;i<cantidad;i++) {
        w[i] = int(random(width));
        h[i] = int(random(height));
      }
    }
    textAlign(CENTER);
    background(0);
    for (int i=0;i<cantidad;i++) {
      textFont(texto, 11);
      tamNodo= 1;
      int numPag = int(map(i, 0, cantidad, 0, mundo.length));
      for (int j=0;j<cantidad;j++) {
        if (dist(w[i], h[i], w[j], h[j])<55) {
          tamNodo = tamNodo+0.7;
          //Dibujar línea
          stroke(tamNodo*10, tamNodo*40, 255, animInicio1*(200-dist(mouseX, mouseY, w[i], h[i])));
          line(w[i]+((w[i]-mouseX)/15), h[i]+(animInicioCaer*i/100), w[j]+((w[j]-mouseX)/10), h[j]+(animInicioCaer*i/100));
        }
      }
      //Dibujar nodos y texto
      noStroke();
      fill(0, tamNodo*40, 255, 500-dist(mouseX, mouseY, w[i], h[i]));
      ellipse(w[i]+((w[i]-mouseX)/15), h[i]+(animInicioCaer*i/100), tamNodo*animInicio1, tamNodo*animInicio1);
      fill(0, tamNodo*40, 255, animInicio1*(300-dist(mouseX, mouseY, w[i], h[i])*10));
      text(mundo[numPag], w[i]+((w[i]-mouseX)/15)-3, h[i]-8);
    }
    //Texto grande
    if (contador<=150) {
      contador++;
      //Aquí había una pifea rara, por eso tiene que ir lo siguiente:
      animInicio2 = 0;
    }
    else {
      if (contador==151) {
        contador++;
        Ani.to(this, 5, "animInicio2", 1);
      }
      textFont(inicio, 72);
      fill(0, 200, 120, 255*animInicio2);
      text("Hacer-creer", width/2, (height/2-40)+(40*animInicio2)-250+(250*animInicio1));

      if (animInicio2>0.5 && mousePressed) {
        Ani.to(this, 1, "animInicioCaer", 100, Ani.CUBIC_OUT);
        Ani.to(this, 1, "animInicio1", 0, Ani.CUBIC_OUT);
      }
    }
  }
  if (activity==1) {
    if (UI==true) {
      UI = false;
      setup();
    }
    background(240);
    //background(165);
    //Textos
    fill(30);
    rect(1220, 0, 250, height);
    header("Pantalla 1");
    textAlign(LEFT);
    fill(0);
    textFont(texto, 11);
    text(lipsum, 25, 70, 300, 160);
    fill(255);
    text("PUNTOS", 1220+45, 85);
    text("GRILLA", 1220+45, 110);
    for (int i=0; i<10 ; i++) {
      text(topSitios.get(i).toUpperCase(), 1220+45, 150+25*i);
    }
    text("ARISTAS", 1220+15, 440);
    text("ZOOM", 1220+15, 490);

    //Circulos de grilla
    textFont(chico, 9);
    textAlign(CENTER);
    ellipseMode(RADIUS);
    stroke(0, og-(30*(zoom-1)));
    for (int i = 1;i<=10;i++) {
      noFill();
      ellipse(offx, offy, i*tamano/10, i*tamano/10);
      String valor = str(max_visitas*i/10);
      fill(0, og*4-(250*(zoom-1)));
      text(valor, offx+i*tamano/10, offy+10);
    }
    //Lineas grilla
    for (int i = 0; i<visitasMes3[0].length; i++) {
      float inclinacion = radians(360/visitasMes3[0].length*i);
      line(tamano*cos(inclinacion)+offx, tamano*sin(inclinacion)+offy, offx, offy);
      textAlign(CENTER, CENTER);
      textFont(chico, 9);
      fill(0, og*2-(10*(zoom-1)));
      text(i+1, (tamano+10)*cos(inclinacion)+offx, (tamano+10)*sin(inclinacion)+offy);
    }

    //Formas fondo
    stroke(0, Aristas);
    figuraFondo(visitasMes3[0], color (0, 255-25*0, 0), o1);
    figuraFondo(visitasMes3[1], color (0, 255-25*1, 0), o2);
    figuraFondo(visitasMes3[2], color (0, 255-25*2, 0), o3);
    figuraFondo(visitasMes3[3], color (0, 255-25*3, 0), o4);
    figuraFondo(visitasMes3[4], color (0, 255-25*4, 0), o5);
    figuraFondo(visitasMes3[5], color (0, 255-25*5, 0), o6);
    figuraFondo(visitasMes3[6], color (0, 255-25*6, 0), o7);
    figuraFondo(visitasMes3[7], color (0, 255-25*7, 0), o8);
    figuraFondo(visitasMes3[8], color (0, 255-25*8, 0), o9);
    figuraFondo(visitasMes3[9], color (0, 255-25*9, 0), o10);

    //Rectas y puntos //LISTO
    if (op>0) {
      for (int i=0;i<10;i++) {
        rectasPuntos(visitasMes3[i], color (0, 255-25*i, 0));//Arreglar color
      }
      for (int i=0;i<10;i++) {
        hover(visitasMes3[i], topSitios.get(i));
      }
    }
    //Grafico lateral de apoyo
    //    for (int i=0;i<10;i++) {
    //      grafApoyo(visitasMes3[i], i, color (0, 255-25*i, 0), 0);//Arreglar color
    //    }/*
    grafApoyo(visitasMes3[0], 1, color (0, 255-25*0, 0), o1);
    grafApoyo(visitasMes3[1], 2, color (0, 255-25*1, 0), o2);
    grafApoyo(visitasMes3[2], 3, color (0, 255-25*2, 0), o3);
    grafApoyo(visitasMes3[3], 4, color (0, 255-25*3, 0), o4);
    grafApoyo(visitasMes3[4], 5, color (0, 255-25*4, 0), o5);
    grafApoyo(visitasMes3[5], 6, color (0, 255-25*5, 0), o6);
    grafApoyo(visitasMes3[6], 7, color (0, 255-25*6, 0), o7);
    grafApoyo(visitasMes3[7], 8, color (0, 255-25*7, 0), o8);
    grafApoyo(visitasMes3[8], 9, color (0, 255-25*8, 0), o9);
    grafApoyo(visitasMes3[9], 10, color (0, 255-25*9, 0), o10);
  }
  if (activity==2) {
    if (UI == true) {
      UI = false;
      setup();
    }
    background(240);
    //Textos
    fill(30);
    rect(1220, 0, 250, height);
    header("Pantalla 2");
    textAlign(LEFT);
    fill(0);
    textFont(texto, 11);
    text(lipsum, 25, 70, 590, 80);

    //Dibujar gráficos
    //    for(int i=0; i<10; i++){
    //    grafchico(25+(tamgc+espaciado_vertical)*i%4, 170+(10+tamgc+15)*int(0/4), a2_primero, trans_primero);
    //    }
    grafchico(25+(tamgc+espaciado_vertical)*0, 170+(10+tamgc+15)*0, topSitios.get(0).toUpperCase(), transitionSitio1);
    grafchico(25+(tamgc+espaciado_vertical)*1, 170+(10+tamgc+15)*0, topSitios.get(1).toUpperCase(), transitionSitio2);
    grafchico(25+(tamgc+espaciado_vertical)*2, 170+(10+tamgc+15)*0, topSitios.get(2).toUpperCase(), transitionSitio3);
    grafchico(25+(tamgc+espaciado_vertical)*3, 170+(10+tamgc+15)*0, topSitios.get(3).toUpperCase(), transitionSitio4);
    grafchico(25+(tamgc+espaciado_vertical)*0, 170+(10+tamgc+15)*1, topSitios.get(4).toUpperCase(), transitionSitio5);
    grafchico(25+(tamgc+espaciado_vertical)*1, 170+(10+tamgc+15)*1, topSitios.get(5).toUpperCase(), transitionSitio6);
    grafchico(25+(tamgc+espaciado_vertical)*2, 170+(10+tamgc+15)*1, topSitios.get(6).toUpperCase(), transitionSitio7);
    grafchico(25+(tamgc+espaciado_vertical)*3, 170+(10+tamgc+15)*1, topSitios.get(7).toUpperCase(), transitionSitio8);
    grafchico(25+(tamgc+espaciado_vertical)*0, 170+(10+tamgc+15)*2, topSitios.get(8).toUpperCase(), transitionSitio9);
    grafchico(25+(tamgc+espaciado_vertical)*1, 170+(10+tamgc+15)*2, topSitios.get(9).toUpperCase(), transitionSitio10);
    a2_simbologia(25+(tamgc+espaciado_vertical)*2, 170+(10+tamgc+15)*2);
    gg(685, 155, topSitios.get(0).toUpperCase(), gg_datos);
  };
  if (activity==3) {
    if (UI == true) {
      UI = false;
      setup();
    }
    background(240);
    //Textos
    fill(30);
    rect(1220, 0, 250, height);
    header("Pantalla 3");
    textAlign(LEFT);
    fill(0);
    textFont(texto, 11);
    text(lipsum, 25, 70, 300, 80);
    text(lipsum, 350, 70, 300, 80);

    //Grafico   
    curva_from(25, 200, 50, 600);
    rect_to(25, 600);
    for (int i=0; i<topSitios.size();i++) {
      rect_from(25+ancho_from*i, 200-25, topSitios.get(i));
    }
  }
  if (activity==4) {
    if (UI == true) {
      UI = false;
      setup();
    }
    background(240);  
    //Textos
    fill(30);
    rect(1220, 0, 250, height);
    header("Pantalla 4");
    textAlign(LEFT);
    fill(0);
    textFont(texto, 11);
    text(lipsum, 25, 70, 400, 80);
    //fill(240, 60);
    //rect(0, 0, width, height);
    textFont(bajada, 14);
    sizey = a4_y;
    sizex = anim_chile;    
    if (mundo_op<1) {
      chileContador();
      chile(a4_x, 240, a4_margen);
    }
    if (mundo_op>0) {
      mundoContador();
      mundo(a4_x, 240, a4_margen);
    }
  }
  if (activity==5) {
    if (UI == true) {
      UI = false;
      setup();
    }
    background(240);
    strokeWeight(1);
    //Textos
    fill(30);
    rect(1220, 0, 250, height);
    header("Pantalla 5");
    textAlign(LEFT);
    fill(0);
    textFont(texto, 11);
    text(lipsum, 25, 70, 590, 80);

    strokeWeight(50);
    dibujarRazones(width/2, height/2, rr1, color(0,230,166));
    dibujarRazones(width/2+200, height/2, rr2, color(0,200,166));
    dibujarRazones(width/2+400, height/2, rr3, color(0,180,166));
  }
}
