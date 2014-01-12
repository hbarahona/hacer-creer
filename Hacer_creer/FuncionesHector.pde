void copiarHistorial() { // LISTO, SOLO COMPATIBLE CON CHROME
  byte Original[] = loadBytes(System.getProperty("user.home") + "/AppData/Local/Google/Chrome/User Data/Default/History");
  byte[] Copia = new byte[Original.length];
  saveBytes(filedb, Original);
}

void obtenerDatos() { //LISTO!!
  copiarHistorial();
  db = new SQLite(this, filedb);
  if ( db.connect()) {
    db.query(query);
    while (db.next ()) {
      urlsNoLimpios.append(db.getString("urls"));
      dia.append(db.getInt("dia"));    
      mes.append(db.getInt("mes"));
      fromVisitNoLimpios.append(db.getString("fromvisit"));
      transition.append(db.getInt("transition"));
    }
    db.query("SELECT segments.name FROM segments");
    while (db.next ()) {
      segmentsNoLimpios.append(db.getString("name"));
    }
    println(" - Datos cargados   Urls:"+ urlsNoLimpios.size()+"   Segments:"+segmentsNoLimpios.size());
  }
}

void limpiarSegments() {  //LISTO!!
  for (int i=0; i<segmentsNoLimpios.size(); i++) {
    println(segmentsNoLimpios.get(i));
    String[] aux=match(segmentsNoLimpios.get(i), regex);
    println(aux);
    if (aux!= null) {
      if (aux[2]=="" || aux[2].length()< 4 || aux[2].equals("google")) {
        if (aux[2].equals("google")) {
          aux[1]="Google "+aux[1];
        }
        if (!segments.hasValue(aux[1])) {
          segments.append(aux[1]);
        }
      }
      else {
        if (!segments.hasValue(aux[2])) {
          segments.append(aux[2]);
        }
      }
    }
  }
  println(" - Segment Limpios  Segments:"+segments.size());
  /*for (int i=0; i<segments.size(); i++) {
   println(i+1+") "+segments.get(i));
   }*/
}

void limpiarUrls_CalcularVisitasTotales() { //LISTO!!
  visitas.set(segments.size()-1, 0);
  for (int i=0; i<urlsNoLimpios.size(); i++) {
    String[] aux=match(urlsNoLimpios.get(i), regex);

    if (aux[2]=="" || aux[2].length()< 4 || aux[2].equals("google") ) {
      if (aux[2].equals("google") ) {
        aux[1]="Google "+aux[1];
      }
      url.append(aux[1]);
    }
    else {
      url.append(aux[2]);
    }
    for (int j=0; j<segments.size(); j++) {
      if (url.get(i).equals(segments.get(j))) {
        visitas.set(j, 1 + visitas.get(j));
        break;
      }
    }
    //println(i+1+") "+url.get(i)+"   "+urlsNoLimpios.get(i) );
  }
  println(" - Urls Limpios");
  println(" - Visitas Calculadas");
  /*for (int i=0; i<url.size(); i++) {
   println(i+1+") "+url.get(i));
   }*/
}

void ordenarDatos() {    //LISTO!!
  for (int i=1; i<11; i++) {
    for (int j=0; j<visitas.size()-1; j++) {
      if (visitas.get(j) > visitas.get(j+1)) {
        String aux=segments.get(j);
        segments.set(j, segments.get(j+1));
        segments.set(j+1, aux);

        int aux2=visitas.get(j);
        visitas.set(j, visitas.get(j+1));
        visitas.set(j+1, aux2);
      }
    }
    topSitios.append(segments.get(visitas.size()-i));
  }
  //  println(" - Los 10 Sitios Calculados");
  //  println(topSitios);
}

void Mes_Sitio() {
  transitionSitio1[0]=transitionMes1[0];
  transitionSitio1[1]=transitionMes2[0];
  transitionSitio1[2]=transitionMes3[0];

  transitionSitio2[0]=transitionMes1[1];
  transitionSitio2[1]=transitionMes2[1];
  transitionSitio2[2]=transitionMes3[1];

  transitionSitio3[0]=transitionMes1[2];
  transitionSitio3[1]=transitionMes2[2];
  transitionSitio3[2]=transitionMes3[2];

  transitionSitio4[0]=transitionMes1[3];
  transitionSitio4[1]=transitionMes2[3];
  transitionSitio4[2]=transitionMes3[3];

  transitionSitio5[0]=transitionMes1[4];
  transitionSitio5[1]=transitionMes2[4];
  transitionSitio5[2]=transitionMes3[4];

  transitionSitio6[0]=transitionMes1[5];
  transitionSitio6[1]=transitionMes2[5];
  transitionSitio6[2]=transitionMes3[5];

  transitionSitio7[0]=transitionMes1[6];
  transitionSitio7[1]=transitionMes2[6];
  transitionSitio7[2]=transitionMes3[6];

  transitionSitio8[0]=transitionMes1[7];
  transitionSitio8[1]=transitionMes2[7];
  transitionSitio8[2]=transitionMes3[7];

  transitionSitio9[0]=transitionMes1[8];
  transitionSitio9[1]=transitionMes2[8];
  transitionSitio9[2]=transitionMes3[8];

  transitionSitio10[0]=transitionMes1[9];
  transitionSitio10[1]=transitionMes2[9];
  transitionSitio10[2]=transitionMes3[9];
}



void calcularVisitaPorMes_SumaTransition() { //Listo!!!
  //println(mes);
  for (int i=0; i<url.size(); i++) {
    for (int j=0; j<topSitios.size(); j++) {
      if (url.get(i).equals(topSitios.get(j))) {
        switch (mes.get(i)) {
        case 10:
          transitionMes1[j][transition.get(i)]++;
          break;
        case 11:
          transitionMes2[j][transition.get(i)]++;
          break;
        case 12:
          transitionMes3[j][transition.get(i)]++;
          visitasMes3[j][dia.get(i)-1]++;
          break;
        default:
          print("E");
        }
      }
    }
  }
  println(" - Visitas Por Mes Calculadas (ACT 1)");
  /*for (int i=0; i<topSitios.size(); i++) {
   println(i+1+") "+topSitios.get(i)+"\t"+sumatoria(transitionMes1[i])+"\t"+sumatoria(transitionMes2[i])+"\t"+sumatoria(transitionMes3[i]));
   }*/
}



void limpiarUrls_CalcularFromVisitTotales() { //LISTO!!
  boolean ingresado=false;
  for (int i=0; i<fromVisitNoLimpios.size(); i++) {
    if (fromVisitNoLimpios.get(i)!=null) {
      String[] aux=match(fromVisitNoLimpios.get(i), regex);
      String fvisit;
      if (aux[2]=="" || aux[2].length()< 4 || aux[2].equals("google") ) {
        if (aux[2].equals("google") ) {
          aux[1]="Google "+aux[1];
        }
        fvisit=aux[1];
      }
      else {
        fvisit=aux[2];
      }
      for (int j=0; j<topSitios.size(); j++) {
        if (fvisit.equals(topSitios.get(j))) {
          for (int k=0; k<topSitios.size(); k++) {
            if (url.get(i).equals(topSitios.get(k))) {
              fromVisitTotales[j][k]++;
              ingresado = true;
              break;
            }
            else {
              ingresado=false;
            }
          }
          if (!ingresado) {
            fromVisitTotales[j][10]++;
          }
        }
      }
    }
  }
  //for (int i=0; i<10;i++) {
  //for (int j=0; j<11; j++) {
  //print(fromVisitTotales[i][j]+"\t");
  //}
  println();
  //}
  println(" - Urls Limpios");
  println(" - Visitas Calculadas");
  /*for (int i=0; i<url.size(); i++) {
   println(i+1+") "+url.get(i));
   }*/
}



void IMPRIMIRDATOS() { //LISTO!!
  println("URL \t DIA \t MES \t FROMVISIT \t TRANSITION" );
  for (int i=0; i<url.size(); i++) {
    println(url.get(i)+"\t"+ dia.get(i)+"\t"+mes.get(i)+"\t "+fromVisit.get(i)+"\t "+transition.get(i));
  }
}

int sumatoria(int Arreglo[]) { //Listo!!
  int suma=0;
  for (int i=0; i<Arreglo.length; i++) {
    suma=suma+Arreglo[i];
  }
  return suma;
}

int mapeo(int valorEntrada, int rangoMinE, int rangoMaxE, int rangoMinS, int rangoMaxS) {

  return valorEntrada;
}


int diaVisitaMaxima() {
  int aux=0;
  for (int i=0; i<10; i++) {
    for (int j=0; j<31; j++) {
      aux=int(max(aux, visitasMes3[i][j]));
    }
  }
  //println(aux);
  return aux;
}


int mesVisitaMaxima() {
  int aux=0;
  int suma=0;
  for (int i=0; i<10; i++) {
    for (int j=0; j<31; j++) {
      suma=suma+visitasMes3[i][j];
    }
    aux=int(max(aux, suma));
    suma=0;
  }
  //println(aux);
  return aux;
}

void inicializar() {
  for (int i=0; i<url.size(); i++) {  
    if (!urlComparar.hasValue(url.get(i))) {
      urlComparar.append(url.get(i));
    }
  }
}

