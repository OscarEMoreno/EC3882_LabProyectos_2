// Will Chacon
// Oscar Moreno
// G3


import processing.serial.*; // Libreria serial

Serial puerto; // Objeto de clase serial
IntList info; //Arreglo para almacenar los datos del serial
IntList info2; //Arreglo para almacenar los datos del serial
IntList info3; //Arreglo para almacenar los datos del serial
IntList info4; //Arreglo para almacenar los datos del serial
int x1,x2,y1,y2; //Variables para mostrar la senal
boolean sinc = false; //Variable para sincronizacion buffer
int state = 0; //Variable para maquina de estados
byte aux1, aux2, aux3, aux4, aux5; //Variables auxiliares 
int result1; //Resultado de la conversion del primer analogico
int result2; //Resultado  de la conversion del segundo analogico
int result3; //Resultado  de la conversion del segundo analogico
int result4; //Resultado  de la conversion del segundo analogico
int i;
int spaceW;
int spaceH;
int scaleAmp = 1;
int scaleTime = 1;
int posCeroSenal = 0;
int posCeroH = 0;
int muestras = 0;
float ScalaAmpSenal = 1;
boolean reboot=false;

/////////////////////////////////////////////////////////////////////////////////////


int rectPruebaX = 100, rectPruebaY = 100, rectPruebaSizeX = 100, rectPruebaSizeY = 100;
int botonSizeX = 70, botonSizeY = 30;
int botonUpX = 50,  botonUpY = 550;
int botonDownX = 150,  botonDownY = 550;
int botonSmallerX = 250,  botonSmallerY = 550;
int botonBiggerX = 350,  botonBiggerY = 550;
int botonFastX = 450,  botonFastY = 550;
int botonSlowX = 550,  botonSlowY = 550;
color botonUpColorHL = color(255,150,150), botonUpColor = color(255,0,0), botonDownColorHL = color(150,255,150), botonDownColor = color(0,255,0), botonSmallerColorHL = color(150,150,255), botonSmallerColor = color(0,0,255); 
color botonBiggerColorHL = color(255,150,255), botonBiggerColor = color(255,0,255), botonFastColorHL= color(150,255,255), botonFastColor = color(0,255,255), botonSlowColorHL = color(255,255,150), botonSlowColor = color(255,255,0);    
boolean botonUpOver = false, botonDownOver = false, botonSmallerOver = false;
boolean botonBiggerOver = false, botonFastOver = false, botonSlowOver = false;
int botonAnal1X = 650, botonAnal2X = 650, botonDig1X = 720, botonDig2X = 720;
int botonAnal1Y = 500, botonAnal2Y = 530, botonDig1Y = 500, botonDig2Y = 530;
color botonAnal1ColorHL = color(240,240,240), botonAnal1Color = color(150,150,150), botonAnal2ColorHL = color(240,240,240), botonAnal2Color = color(150,150,150);
color botonDig1ColorHL = color(240,240,240), botonDig1Color = color(150,150,150), botonDig2ColorHL = color(240,240,240), botonDig2Color = color(150,150,150);
boolean botonAnal1Over = false, botonAnal2Over = false, botonDig1Over = false, botonDig2Over = false;
boolean AnalFlag1 = false, AnalFlag2 = false, DigFlag1 = false, DigFlag2 = false;
int Anal1PosY = 50, Anal2PosY = 100, Dig1PosY = 150, Dig2PosY = 200;
int Anal1Amp = 1, Anal2Amp = 1, Dig1Amp = 1, Dig2Amp = 1;


/////////////////////////////////////////////////////////////////////////////////////



void setup(){
  
    size(800,600); // Tamano de la pantalla
    grid();
    puerto = new Serial(this, Serial.list()[1], 115200);
    puerto.buffer(5); //Se almacenaran 5 bytes en el buffer
    info = new IntList();
    info2 = new IntList();
    info3 = new IntList();
    info4 = new IntList();
    x1 = 0; // Coordenadas se inicializan 
    x2 = 1;
    y1 = height;
   
}

void draw(){
      if(keyPressed){
        teclaPresionada();
      }
    
    ///////////////////////////////////////////////////
      
    //boton Anal1 Presionado
    if (botonAnal1Over  && AnalFlag1 == true) {
      AnalFlag2 = DigFlag1 = DigFlag2 = false;
      //grid();
      botonAnal1Color = color(255, 0, 0);
    } 
    
    //boton Anal2 Presionado
    if (botonAnal2Over  && AnalFlag2 == true) {
      AnalFlag1 = DigFlag1 = DigFlag2 = false;
      //grid();
      botonAnal2Color = color(0, 255, 0);
    } 
    
    //boton Dig1 Presionado
    if (botonDig1Over  && DigFlag1 == true) {
      AnalFlag1 = AnalFlag2 = DigFlag2 = false;
      //grid();
      botonDig1Color = color(0, 0, 255);
    } 
    
    //boton Dig2 Presionado
    if (botonDig2Over && DigFlag2 == true) {
      AnalFlag1 = AnalFlag2 = DigFlag1 = false;
      //grid();
      botonDig1Color = color(200, 100, 200);
    } 

    
    ///////////////////////////////////////////////////  
      
    //if(info.size() > 1){ // Verificar si hay datos suficientes
    //    
    //(info.remove(0)); //Se pintan
    //}
    //while (info != null || info2 != null || info3 != null || info4 != null ){
    //  paint(info.remove(0), 255, 0, 0, Anal1PosY, Anal1Amp);
    //  paint(info2.remove(0), 255, 0, 0, Anal1PosY, Anal1Amp);
    //  paint(info3.remove(0), 255, 0, 0, Anal1PosY, Anal1Amp);
    //  paint(info4.remove(0), 255, 0, 0, Anal1PosY, Anal1Amp);
    
    //}
    
    ///////////////////////////////////////
    //verificar señal a graficar
    if (AnalFlag1 == true) {
      for (i=1;i<info.size();i++){
        if(info != null){
          paint(info.remove(0), 255, 0, 0, Anal1PosY, Anal1Amp); //Se pintan
        }
      }  
    }  
    
    if (AnalFlag2 == true){
     for (i=1;i<info2.size();i++){
        if(info != null){
          paint(info2.remove(0), 0, 255, 0, Anal2PosY, Anal2Amp); //Se pintan
        }
      }   
    }

    if (DigFlag1 == true){
      for (i=1;i<info3.size();i++){
        if(info != null){
          paint(info3.remove(0), 0, 0, 255,   Dig1PosY, Dig1Amp); //Se pintan
        }
      } 
    }
   
    if (DigFlag2 == true){
      for (i=1;i<info4.size();i++){
        if(info != null){
          paint(info4.remove(0), 200, 100, 200, Dig2PosY, Dig2Amp); //Se pintan
        }
      }
    }
    ///////////////////////////////////////
    
    //for (i=1;i<info4.size();i++){
    //  if(info != null){
    //    paint(info.remove(0), 255, 0, 0, Anal1PosY, Anal1Amp); //Se pintan
    //  }
    //  if(info2 != null){
    //    paint(info2.remove(0), 0, 255, 0, Anal2PosY, Anal2Amp); //Se pintan
    //  }
    //  if(info3 != null){
    //    paint(info3.remove(0), 0, 0, 255, Dig1PosY, Dig1Amp); //Se pintan
    //  }
    //  if(info4 != null){
    //    paint(info4.remove(0), 200, 100, 200, Dig2PosY,  Dig2Amp); //Se pintan
    //  }
    //}
    
 /////////////////////////////////////////////////////////////////////////////////
 
update(mouseX, mouseY);
  //background(currentColor);

  //boton up
  if (botonUpOver) {
      fill(botonUpColorHL);
    } else {
      fill(botonUpColor);
  }
  stroke(0);
  rect(botonUpX,  botonUpY,  botonSizeX,  botonSizeY);
  fill(0);
  text("UP!", botonUpX+25, botonUpY+20);
  
  
  //boton down
  if (botonDownOver) {
    fill(botonDownColorHL);
  } else {
    fill(botonDownColor);
  }
  stroke(0);
  rect(botonDownX,  botonDownY,  botonSizeX,  botonSizeY);
  fill(0);
  text("DOWN!", botonDownX+15, botonDownY+20);
  
  
  //boton Smaller
  if (botonSmallerOver) {
    fill(botonSmallerColorHL);
  } else {
    fill(botonSmallerColor);
  }
  stroke(0);
  rect(botonSmallerX,  botonSmallerY,  botonSizeX,  botonSizeY);
  fill(0);
  text("SMALLER!", botonSmallerX+5, botonSmallerY+20);
  
  
  //boton Bigger
  if (botonBiggerOver) {
    fill(botonBiggerColorHL);
  } else {
    fill(botonBiggerColor);
  }
  stroke(0);
  rect(botonBiggerX,  botonBiggerY,  botonSizeX,  botonSizeY);
  fill(0);
  text("BIGGER!", botonBiggerX+10, botonBiggerY+20);
  
  //boton Fast
  if (botonFastOver) {
    fill(botonFastColorHL);
  } else {
    fill(botonFastColor);
  }
  stroke(0);
  rect(botonFastX,  botonFastY,  botonSizeX,  botonSizeY);
  fill(0);
  text("FASTER!", botonFastX+10, botonFastY+20);
  
  
  //boton Slow
  if (botonSlowOver) {
    fill(botonSlowColorHL);
  } else {
    fill(botonSlowColor);
  }
  stroke(0);
  rect(botonSlowX,  botonSlowY,  botonSizeX,  botonSizeY);
  fill(0);
  text("SLOWER!", botonSlowX+10, botonSlowY+20);



  //Analogico 1
  if (botonAnal1Over) {
    fill(botonAnal1ColorHL);
  } else {
    fill(botonAnal1Color);
  }
  stroke(0);
  rect(botonAnal1X,  botonAnal1Y,  botonSizeX,  botonSizeY);
  fill(0);
  text("Analg 1!", botonAnal1X+15, botonAnal1Y+20);

  //Analogico 2
  if (botonAnal2Over) {
    fill(botonAnal2ColorHL);
  } else {
    fill(botonAnal2Color);
  }
  stroke(0);
  rect(botonAnal2X,  botonAnal2Y,  botonSizeX,  botonSizeY);
  fill(0);
  text("Analg 2!", botonAnal2X+15, botonAnal2Y+20);
  
  //Digital 1
  if (botonDig1Over) {
    fill(botonDig1ColorHL);
  } else {
    fill(botonDig1Color);
  }
  stroke(0);
  rect(botonDig1X,  botonDig1Y,  botonSizeX,  botonSizeY);
  fill(0);
  text("Dig 1!", botonDig1X+20, botonDig1Y+20);
  
  //Digital 2
  if (botonDig2Over) {
    fill(botonDig2ColorHL);
  } else {
    fill(botonDig2Color);
  }
  stroke(0);
  rect(botonDig2X,  botonDig2Y,  botonSizeX,  botonSizeY);
  fill(0);
  text("Dig 2!", botonDig2X+20, botonDig2Y+20);
  
 
 /////////////////////////////////////////////////////////////////////////////////
    
}

void paint(int punto, int r, int g, int b, int Ysignal, int Amp){
    if(keyPressed){
        teclaPresionada();
    }
    y2 = punto; 
    if(x1 == 0){
        stroke(255); // Primera linea de blanco
        text("número de muestras: "+muestras, width-245,15);
        println(muestras);
        muestras = 0;
     }
      else{
        stroke(r,g,b);
        strokeWeight(2);
        muestras++;
      }
    line(x1, y1 *ScalaAmpSenal *Amp/10 + posCeroSenal + Ysignal, x2, y2 *ScalaAmpSenal *Amp/10 + posCeroSenal + Ysignal);
    
    //point(x1*scaleTime, y1*scaleAmp+posCeroSenal);
    //point(x2*scaleTime, y2*scaleAmp+posCeroSenal);
    x1 = x2;// + 1*scaleTime;
    x2 = x2 + 1*scaleTime;
    //x1=x2;
    y1 = y2;
    if(reboot==true){
      reboot = false;
      x2 = width+1;
    }
    if(x2 > width){ //Si se supera el tamano de la pantalla
      grid();
      x1 = 0; //Se empezara a pintar desde el principio de la pantalla otra vez
      x2 = 1 + (scaleTime-1);
      info.clear(); //Se limpian los datos capturados, para obtener nuevos
    }
      //info.clear(); //Se limpian los datos capturados, para obtener nuevos
}


//////////////////////////////////////////////////////////////////////////////////

void update(int x, int y) {
   //actualización del estado de los botones
  if ( overButton(botonUpX, botonUpY, botonSizeX, botonSizeY) ) {
    //boton up
    botonUpOver = true;
    botonDownOver = botonSmallerOver = botonBiggerOver = botonFastOver = botonSlowOver = botonAnal1Over = botonAnal2Over = botonDig1Over = botonDig2Over = false;
  } else if ( overButton(botonDownX, botonDownY, botonSizeX, botonSizeY) ) {
    //botton down
    botonDownOver = true;
    botonUpOver = botonSmallerOver = botonBiggerOver = botonFastOver = botonSlowOver = botonAnal1Over = botonAnal2Over = botonDig1Over = botonDig2Over = false;
  } else if ( overButton(botonSmallerX, botonSmallerY, botonSizeX, botonSizeY) ) {
    //botton Sameller
    botonSmallerOver = true;
    botonUpOver = botonDownOver = botonBiggerOver = botonFastOver = botonSlowOver = botonAnal1Over = botonAnal2Over = botonDig1Over = botonDig2Over = false;
  } else if ( overButton(botonBiggerX, botonBiggerY, botonSizeX, botonSizeY) ) {
    //botton Bigger
    botonBiggerOver = true;
    botonUpOver = botonDownOver = botonSmallerOver = botonFastOver = botonSlowOver = botonAnal1Over = botonAnal2Over = botonDig1Over = botonDig2Over = false;
  } else if ( overButton(botonFastX, botonFastY, botonSizeX, botonSizeY) ) {
    //botton Fast
    botonFastOver = true;
    botonUpOver = botonDownOver = botonSmallerOver = botonBiggerOver = botonSlowOver = botonAnal1Over = botonAnal2Over = botonDig1Over = botonDig2Over = false;
  } else if ( overButton(botonSlowX, botonSlowY, botonSizeX, botonSizeY) ) {
    //botton Slow
    botonSlowOver = true;
    botonUpOver = botonDownOver = botonSmallerOver = botonBiggerOver = botonFastOver = botonAnal1Over = botonAnal2Over = botonDig1Over = botonDig2Over = false;
  } else if ( overButton(botonAnal1X,  botonAnal1Y, botonSizeX, botonSizeY) ) {
    //botton Aux1
    botonAnal1Over = true;
    botonUpOver = botonDownOver = botonSmallerOver = botonBiggerOver = botonFastOver = botonSlowOver = botonAnal2Over = botonDig1Over = botonDig2Over = false;
  } else if ( overButton(botonAnal2X,  botonAnal2Y, botonSizeX, botonSizeY) ) {
    //botton Aux2
    botonAnal2Over = true;
    botonUpOver = botonDownOver = botonSmallerOver = botonBiggerOver = botonFastOver = botonSlowOver = botonAnal1Over = botonDig1Over = botonDig2Over = false;
  } else if ( overButton(botonDig1X,  botonDig1Y, botonSizeX, botonSizeY) ) {
    //botton Dig1
    botonDig1Over = true;
    botonUpOver = botonDownOver = botonSmallerOver = botonBiggerOver = botonFastOver = botonSlowOver = botonAnal1Over = botonAnal2Over = botonDig2Over = false;
  } else if ( overButton(botonDig2X,  botonDig2Y, botonSizeX, botonSizeY) ) {
    //botton Dig2
    botonDig2Over = true;
    botonUpOver = botonDownOver = botonSmallerOver = botonBiggerOver = botonFastOver = botonSlowOver = botonAnal1Over = botonAnal2Over = botonDig1Over = false;
  } else {
    //retorna al estado original todos los botones
    botonUpOver = botonDownOver = botonSmallerOver = botonBiggerOver = botonFastOver = botonSlowOver = botonAnal1Over = botonAnal2Over = botonDig1Over = false;
  }
}

boolean overButton(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mousePressed() {
  //presionar boton up
  if (botonUpOver) {
    botonUpColorHL = botonUpColor;
    MoveUp(AnalFlag1, AnalFlag2, DigFlag1, DigFlag2);
  } 
  //presionar boton down
  if (botonDownOver) {
    botonDownColorHL = botonDownColor;
    MoveDown(AnalFlag1, AnalFlag2, DigFlag1, DigFlag2);
  } 
  //presionar boton smaller
  if (botonSmallerOver) {
    botonSmallerColorHL = botonSmallerColor;
    MakeSmaller(AnalFlag1, AnalFlag2, DigFlag1, DigFlag2);
  } 
  //presionar boton bigger
  if (botonBiggerOver) {
    botonBiggerColorHL = botonBiggerColor;
    MakeBigger(AnalFlag1, AnalFlag2, DigFlag1, DigFlag2);
  } 
  //presionar boton fast
  if (botonFastOver) {
    botonFastColorHL = botonFastColor;
    MoveFast();
  } 
  //presionar boton slow
  if (botonSlowOver) {
    botonSlowColorHL = botonSlowColor;
    MoveSlow();
  } 
  //presionar boton Anal1
  if (botonAnal1Over) {
    botonAnal1ColorHL = botonAnal1Color;
    if (AnalFlag1 == false){
      AnalFlag1 = true;
    } else {
      AnalFlag1 = false;
    }
  } 
  //presionar boton Anal2
  if (botonAnal2Over) {
    botonAnal2ColorHL = botonAnal2Color;
    if (AnalFlag2 == false){
      AnalFlag2 = true;
      grid();
    } else {
      AnalFlag2 = false;
    }
  } 
  //presionar boton Dig1
  if (botonDig1Over) {
    botonDig1ColorHL = botonDig1Color;
    if (DigFlag1 == false){
      DigFlag1 = true;
      grid();
    } else {
      DigFlag1 = false;
    }
  } 
  //presionar boton Dig2
  if (botonDig2Over) {
    botonDig2ColorHL = botonDig2Color;
    if (DigFlag2 == false){
      DigFlag2 = true;
      grid();
    } else {
      DigFlag2 = false;
    }
  } 
}

void mouseReleased(){
  //soltar boton up
  if (botonUpOver) {
    botonUpColorHL = color(255,150,150);
  } 
  //soltar boton down
  if (botonDownOver) {
    botonDownColorHL = color(150,255,150);
  } 
  //soltar boton smaller
  if (botonSmallerOver) {
    botonSmallerColorHL = color(150,150,255);
  } 
  //soltar boton bigger
  if (botonBiggerOver) {
    botonBiggerColorHL = color(255,150,255);
  } 
  //soltar boton fast
  if (botonFastOver) {
    botonFastColorHL = color(150,255,255);
  } 
  //soltar boton slow
  if (botonSlowOver) {
    botonSlowColorHL = color(255,255,150);
  } 
  //soltar boton Anal1
  if (botonAnal1Over  && AnalFlag1 == false) {
    botonAnal1ColorHL = color(240, 240, 240);
      botonAnal1Color = color(150, 150, 150);
  } 
  if (botonAnal1Over  && AnalFlag1 == true) {
    botonAnal1ColorHL = color(240, 240, 240);
    botonAnal1Color = color(255, 0, 0);
      AnalFlag2 = DigFlag1 = DigFlag2 = false;
  } 
  //soltar boton Anal2
  if (botonAnal2Over  && AnalFlag2 == false) {
    botonAnal2ColorHL = color(240, 240, 240);
      botonAnal2Color = color(150, 150, 150);
  } 
  if (botonAnal2Over  && AnalFlag2 == true) {
    botonAnal2ColorHL = color(240, 240, 240);
    botonAnal2Color = color(0, 255, 0);
      AnalFlag1 = DigFlag1 = DigFlag2 = false;
  } 
  //soltar boton Dig1
  if (botonDig1Over  && DigFlag1 == false) {
    botonDig1ColorHL = color(240, 240, 240);
      botonDig1Color = color(150, 150, 150);
  } 
  if (botonDig1Over  && DigFlag1 == true) {
    botonDig1ColorHL = color(240, 240, 240);
    botonDig1Color = color(0, 0, 255);
      AnalFlag1 = AnalFlag2 = DigFlag2 = false;
  } 
  //soltar boton Dig2
  if (botonDig2Over && DigFlag2 == false) {
    botonDig2ColorHL = color(240, 240, 240);
      botonDig2Color = color(150, 150, 150);
  } 
  if (botonDig2Over && DigFlag2 == true) {
    botonDig2ColorHL = color(240, 240, 240);
    botonDig2Color = color(200, 100, 200);
      AnalFlag1 = AnalFlag2 = DigFlag1 = false;
  } 
}

////////////////////////////////////////////////////////////////////////////////////


void serialEvent(Serial puerto){
    byte[] dato = new byte[5]; //Se crea una varibale tipo byte para guardar el dato del buffer
    dato = puerto.readBytes(); //Se lee y se guardan los datos
    for(int i = 0; i<5; i++){ //Bucle para leer los datos que vienen del buffer
    if(dato[i] == -14){ //Si se lee la cabecera (etiqueta), correspondiente a F2
    sinc = true; //Entonces se esta sincronizado
}
    if(sinc){
    switch(state){
        case 0:
        state = 1;
        break;
        case 1:
        aux1 = dato[i]; //Se guarda el segundo byte recibido
        state = 2;
        break;
        case 2:
        aux2 = dato[i]; //Se guarda el tercer byte recibido
        state = 3;
        break;
        case 3:
        aux3 = dato[i]; //Se guarda el cuarto byte recibido
        state = 4;
        break;
        case 4:
        aux4 = dato[i]; //Se guarda el quinto byte recibido
        state = 5;
        break;
        case 5:
        //se convierte en analógico
        result1 = conversion_analogica(aux1, aux2); //Se convierte
        result2 = conversion_analogica(aux3, aux4);
        //se convierte a digital
        result3 = conversion_digital(aux1);
        result4 = conversion_digital(aux3);
        result1 = (int) map(result1, 0, 4095, height, 0); //Se mapea para que se ubique entre los valores de la pantalla  
        result2 = (int) map(result2, 0, 4095, height, 0); //Se mapea para que se ubique entre los valores de la pantalla  
        result3 = (int) map(result3, 0, 1, int(0.65*height), 0); //Se mapea para que se ubique entre los valores de la pantalla  
        result4 = (int) map(result4, 0, 1, int(0.5*height), 0); //Se mapea para que se ubique entre los valores de la pantalla  
        info.append(result1); //Se almacenan los datos en el arreglo
        info2.append(result2); //Se almacenan los datos en el arreglo
        info3.append(result3); //Se almacenan los datos en el arreglo
        info4.append(result4); //Se almacenan los datos en el arreglo
        state = 0;
        sinc = false;
        break;
    }
  }
}
  if(info.size() == 1000){
    //println(info);
    //println(info2);
    //println(info3);
    //println(info4);
    info.clear(); //Se limpian los datos capturados, para obtener nuevos
    info2.clear(); //Se limpian los datos capturados, para obtener nuevos
    info3.clear(); //Se limpian los datos capturados, para obtener nuevos
    info4.clear(); //Se limpian los datos capturados, para obtener nuevos
  }
}

//conversión analógica
int conversion_analogica(byte auxi1, byte auxi2){
    int r;
    int b,c;
    int auxi3, auxi4;
    b = (auxi1 & 0x1F); //Elimino los tres primeros bits, que corresponden al cero y los dos digitales
    c = (auxi2 << 1); //Elimino el cero del principio y queda al final
    auxi3 = (b << 8); //Para concatenar, se shiftea 8 veces a la izquierda, y quedan ocho ceros a la derecha
    auxi4 = c & 0x00FF; //Paso de 11111111c a 00000000c para concatenar
    auxi4 = (auxi3 | auxi4); //Se concatenan
    r = (auxi4 >> 1); //Se elimina el ultimo cero
    return r;
}

//conversión digital
int conversion_digital(byte auxi1){
    int c ,R;
    c = (auxi1 & 0x20); 
    //c = (c >> 6);
    if( auxi1 == 0x3F){
      R = 1;
    }else{
      R = 0;
    }
    return R;
}


void grid(){
    background(255); //Se pinta la pantalla de blanco
    i=0;
    spaceW = 15*scaleTime;
    spaceH = 10*scaleAmp;
    stroke(0);
    strokeWeight(1);
    while(i<100){
       line(i*spaceW, 0, i*spaceW, height);
       //fill(0);
       //text((i+1)*spaceW, (i+1)*spaceW, height);
       line(0, i*spaceH, width, i*spaceH);
       //fill(0);
       //text(round(3.5714*(-i*spaceH+height+posCeroH)), 0, i*spaceH);
       i+=2;
  }
}

     //if(keyPressed){
     //   teclaPresionada();
     //}


void teclaPresionada(){
  switch(key){
    //solo variar la escala del eje Y
    case 'a': scaleAmp++;
              if(scaleAmp>5){
                scaleAmp=5;
              }
              reboot = true;
              break;
    case 's': scaleAmp--;
              if(scaleAmp<1){
                scaleAmp=1;
              }
              reboot = true;
              break;
    
    //solo variar la escala del eje X
    case 'q': scaleTime++;
              if(scaleTime>10){
                scaleTime=10;
              }
              reboot = true;
              break;
    case 'w': scaleTime--;
              if(scaleTime<1){
                scaleTime=1;
              }
              reboot = true;
              break;
    
    //cambiar la ubicacion de la grafica respecto al eje Y
    case 'z': posCeroSenal++;
              if(posCeroSenal>200){
                posCeroSenal=200;
              } 
              break;
    case 'x': posCeroSenal--;
              if(posCeroSenal<100){
                posCeroSenal=100;
              }
              break;
              
    //modificar el cero del eje Y
    case 'r': posCeroH++;
              if(posCeroH>100){
                posCeroH=100;
              } 
              reboot = true;
              break;
    case 't': posCeroH--;
              if(posCeroH<-100){
                posCeroH=-5100;
              }
              reboot = true;
              break;
              
    //modificar la amplitud de la señal
    case 'f': ScalaAmpSenal+=1;
              if(ScalaAmpSenal>20){
                ScalaAmpSenal=20;
                //posCeroSenal=posCeroSenal-height;
              } 
              break;
    case 'g': ScalaAmpSenal-=1;
              if(ScalaAmpSenal<1){
                ScalaAmpSenal=1;
                //posCeroSenal=posCeroSenal-height;
              }
              break;
    
    default: break;
  
  }

}


/////////////////////////////////////////////////////////////////////////////

void MoveUp(boolean AnalFlag1, boolean AnalFlag2, boolean DigFlag1, boolean DigFlag2){
  if (AnalFlag1 == true){
      Anal1PosY = Anal1PosY -1;
      if (Anal1PosY < 300){
          Anal1PosY = 300;
      }
  }
  if (AnalFlag2 == true){
      Anal2PosY = Anal2PosY -1;
      if (Anal2PosY < 300){
          Anal2PosY = 300;
      }
  }
  if (DigFlag1 == true){
      Dig1PosY = Dig1PosY -1;
      if (Dig1PosY < 300){
          Dig1PosY = 300;
      }
  }
  if (DigFlag2 == true){
      Dig2PosY = Dig2PosY -1;
      if (Dig2PosY < 300){
          Dig2PosY = 300;
      }
  }
  
}

void MoveDown(boolean AnalFlag1, boolean AnalFlag2, boolean DigFlag1, boolean DigFlag2){
  if (AnalFlag1 == true){
      Anal1PosY = Anal1PosY +1;
      if (Anal1PosY > 1000){
          Anal1PosY = 1000;
      }
  }
  if (AnalFlag2 == true){
      Anal2PosY = Anal2PosY +1;
      if (Anal2PosY > 1000){
          Anal2PosY = 1000;
      }
  }
  if (DigFlag1 == true){
      Dig1PosY = Dig1PosY +1;
      if (Dig1PosY > 1000){
          Dig1PosY = 1000;
      }
  }
  if (DigFlag2 == true){
      Dig2PosY = Dig2PosY +1;
      if (Dig2PosY > 1000){
          Dig2PosY = 1000;
      }
  }
  
}


void MakeBigger(boolean AnalFlag1, boolean AnalFlag2, boolean DigFlag1, boolean DigFlag2){
  if (AnalFlag1 == true){
      Anal1Amp = Anal1Amp +1;
      if (Anal1Amp > 10){
          Anal1Amp = 10;
      }
  }
  if (AnalFlag2 == true){
      Anal2Amp = Anal2Amp +1;
      if (Anal2Amp > 10){
          Anal2Amp = 10;
      }
  }
  if (DigFlag1 == true){
      Dig1Amp = Dig1Amp +1;
      if (Dig1Amp > 10){
          Dig1Amp = 10;
      }
  }
  if (DigFlag2 == true){
      Dig2Amp = Dig2Amp +1;
      if (Dig2Amp > 10){
          Dig2Amp = 10;
      }
  }
  
}


void MakeSmaller(boolean AnalFlag1, boolean AnalFlag2, boolean DigFlag1, boolean DigFlag2){
  if (AnalFlag1 == true){
      Anal1Amp--;
      if (Anal1PosY < 1){
          Anal1PosY = 1;
      }
  }
  if (AnalFlag2 == true){
      Anal2Amp--;
      if (Anal2Amp < 1){
          Anal2Amp = 1;
      }
  }
  if (DigFlag1 == true){
      Dig1Amp--;
      if (Dig1Amp < 1){
          Dig1Amp = 1;
      }
  }
  if (DigFlag2 == true){
      Dig2Amp--;
      if (Dig2Amp < 1){
          Dig2Amp = 1;
      }
  }
  
}


void MoveFast(){
      scaleTime++;
      if(scaleTime>10){
        scaleTime=10;
      }
}

void MoveSlow(){
   scaleTime--;
   if(scaleTime<1){
      scaleTime=1;
   }

}


/////////////////////////////////////////////////////////////////////////////
