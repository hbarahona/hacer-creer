void setup() {
  if (first_time) {
    first_time = false;
    //HECTOR ************************************************************************************

    obtenerDatos();        //Obtener datos de la Base de datos
    limpiarSegments();    //Limpia segmentsNoLimpio y los deja en segments
    limpiarUrls_CalcularVisitasTotales();
    ordenarDatos();     //Selecciona los 10 segments mas visitados
    calcularVisitaPorMes_SumaTransition();
    limpiarUrls_CalcularFromVisitTotales();
    Mes_Sitio();
    inicializar();
    //IMPRIMIRDATOS();
    max_visitas = diaVisitaMaxima();
    max_visit_mes = mesVisitaMaxima();

    //RICARDO ************************************************************************************  
    chico = loadFont("DroidSansMono-9.vlw");
    texto = loadFont("DroidSansMono-11.vlw");
    bajada = loadFont("Aller-Regular-14.vlw");
    titulo = loadFont("Aller-Bold-24.vlw");
    inicio = loadFont("Aller-Bold-72.vlw");
    size(1366, 680);
    smooth();
    if (frame != null) {
      frame.setResizable(true);
      //frame.setSize(1366, 680);
    };
    Ani.init(this);
    cp5 = new ControlP5(this);
    checkbox = cp5.addCheckBox("webs")
      .setPosition(width-100-30, 135)
        .setColorBackground(color(200))
          .setColorForeground(color1)
            .setColorActive(color2)
              .setColorLabel(color(255))
                .setSize(20, 20)
                  .setItemsPerRow(1)
                    .setSpacingRow(5)
                      .addItem(topSitios.get(0), 1)
                        .addItem(topSitios.get(1), 1)
                          .addItem(topSitios.get(2), 1)
                            .addItem(topSitios.get(3), 1)
                              .addItem(topSitios.get(4), 1)
                                .addItem(topSitios.get(5), 1)
                                  .addItem(topSitios.get(6), 1)
                                    .addItem(topSitios.get(7), 1)
                                      .addItem(topSitios.get(8), 1)
                                        .addItem(topSitios.get(9), 1)
                                          .hideLabels()
                                            ;
    toggle1 = cp5.addToggle("Puntos", true)
      .setPosition(width-100-30, 70)
        .setColorBackground(color(200))
          .setColorForeground(color1)
            .setColorActive(color2)
              .setColorLabel(color(255))
                .setSize(20, 20)
                  .setCaptionLabel("");
    ;
    toggle2 = cp5.addToggle("Grilla", false)
      .setPosition(width-100-30, 95)
        .setColorBackground(color(200))
          .setColorForeground(color1)
            .setColorActive(color2)
              .setColorLabel(color(255))
                .setSize(20, 20)
                  .setCaptionLabel("");
    ;
    slider1 = cp5.addSlider("Aristas")
      .setPosition(width-100-30, 405)
        .setRange(0, 120)
          .setSize(100, 20)
            .setColorBackground(color(200))
              .setColorForeground(color1)
                .setColorActive(color2)
                  .setCaptionLabel("");
    ;
    slider2 = cp5.addSlider("zoom")
      .setPosition(width-100-30, 455)
        .setRange(1, 10)
          .setSize(100, 20)
            .setColorBackground(color(200))
              .setColorForeground(color1)
                .setColorActive(color2)
                  .setCaptionLabel("");
    ;
  }

  //ACA SE CIERRA EL FIRST TIME!  

  if (activity==0) {
    Ani.to(this, 5, "animInicio1", 1, Ani.QUAD_OUT);
    toggle1.setVisible(false);
    toggle2.setVisible(false);
    checkbox.setVisible(false);
    slider1.setVisible(false);
    slider2.setVisible(false);
  }
  if (activity==1) {  
    strokeWeight(1);
    toggle1.setVisible(true);
    toggle2.setVisible(true);
    checkbox.setVisible(true);
    slider1.setVisible(true);
    slider2.setVisible(true);
  }
  if (activity==2) {
    strokeWeight(1);
    toggle1.setVisible(false);
    toggle2.setVisible(false);
    checkbox.setVisible(false);
    slider1.setVisible(false);
    slider2.setVisible(false);
  }
  if (activity==3) {
    strokeWeight(1);
    toggle1.setVisible(false);
    toggle2.setVisible(false);
    checkbox.setVisible(false);
    slider1.setVisible(false); 
    slider2.setVisible(false);
  }
  if (activity==4) {
    strokeWeight(1);
    toggle1.setVisible(false);
    toggle2.setVisible(false);
    checkbox.setVisible(false);
    slider1.setVisible(false);
    slider2.setVisible(false);
  }
  if (activity==5) {
    calcularRazones();
    ellipseMode(CENTER);  
    strokeCap(SQUARE);
    anim5 = 0;
    anim5_2 = 0;
    Ani.to(this, 1.5, "anim5", 1, Ani.SINE_IN);
    Ani.to(this, 1.5, 1.5, "anim5_2", 1, Ani.SINE_OUT);
    toggle1.setVisible(false);
    toggle2.setVisible(false);
    checkbox.setVisible(false);
    slider1.setVisible(false);
    slider2.setVisible(false);
  }
}

