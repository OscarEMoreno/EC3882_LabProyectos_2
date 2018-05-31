// Will Chacon
// Oscar Moreno
// G3


import processing.serial.*; // Libreria serial

Serial puerto; // Objeto de clase serial
IntList info; //Arreglo para almacenar los datos del serial
int x1,x2,y1,y2; //Variables para mostrar la senal
boolean sinc = false; //Variable para sincronizacion buffer
int state = 0; //Variable para maquina de estados
byte aux1, aux2, aux3, aux4, aux5; //Variables auxiliares 
int result1; //Resultado de la conversion del primer analogico
int result2; //Resultado  de la conversion del segundo analogico
int i;
int spaceW;
int spaceH;
int scaleAmp = 1;
int scaleTime = 1;
int posCeroSenal = 100;
int posCeroH = 100;
int muestras = 0;
float ScalaAmpSenal = 1;


void setup(){
  
    size(1000,620); // Tamano de la pantalla
    grid();
    puerto = new Serial(this, Serial.list()[0], 115200);
    puerto.buffer(5); //Se almacenaran 6 bytes en el buffer
    info = new IntList();
    x1 = 0; // Coordenadas se inicializan 
    x2 = 1;
    y1 = height;
 
    
}

void draw(){
         if(keyPressed){
        teclaPresionada();
       }
    if(info.size() > 20){ // Verificar si hay datos suficientes
    paint(info.remove(0)); //Se pintan
    }
}

void paint(int punto){
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
        stroke(255,0,0);
        strokeWeight(2);
        muestras++;
      }
    line(x1*scaleTime, round(y1 *260/500)*ScalaAmpSenal+posCeroSenal, x2*scaleTime, round(y2 *260/500)*ScalaAmpSenal+posCeroSenal);
    //point(x1*scaleTime, y1*scaleAmp+posCeroSenal);
    //point(x2*scaleTime, y2*scaleAmp+posCeroSenal);
    x1 = x1 + 1*scaleTime;
    x2 = x2 + 1*scaleTime;
    y1 = y2;
    if(x2 > width){ //Si se supera el tamano de la pantalla
      grid();
      x1 = 0; //Se empezara a pintar desde el principio de la pantalla otra vez
      x2 = 2 + 2*(scaleTime-1);
      info.clear(); //Se limpian los datos capturados, para obtener nuevos
    }
}

void serialEvent(Serial puerto){
    byte[] dato = new byte[5]; //Se crea una varibale tipo byte para guardar el dato del buffer
    dato = puerto.readBytes(); //Se lee y se guardan los datos
    for(int i = 0; i<4; i++){ //Bucle para leer los datos que vienen del buffer
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
    aux5 = dato[i]; //Se guarda el sexto byte recibido
    state = 6;
    break;
    case 6:
    result1 = conversion_analogica(aux1, aux2); //Se convierte
    result2 = conversion_analogica(aux3,aux4);
    result1 = (int) map(result1, 0, 4095, height, 0); //Se mapea para que se encuentre entre los valores de la pantalla
    info.append(result1); //Se almacenan los datos en el arreglo
    state = 0;
    sinc = false;
    break;
}
}
}
if(info.size() == 20){
println(info);
}
}
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


void grid(){
  background(255); //Se pinta la pantalla de blanco
  i=0;
  spaceW = 20*scaleTime;
  spaceH = 20*scaleAmp;
  stroke(0);
  strokeWeight(1);
  while(i<50){
     line(i*spaceW, 0, i*spaceW, height);
     fill(0);
     text((i+1)*spaceW, (i+1)*spaceW, height);
     line(0, i*spaceH, width, i*spaceH);
     fill(0);
     text((-i*spaceH+height/2-90+posCeroH)*10, 0, i*spaceH);
     i=i+1;
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
              break;
    case 's': scaleAmp--;
              if(scaleAmp<1){
                scaleAmp=1;
              }
              break;
    
    //solo variar la escala del eje X
    case 'q': scaleTime++;
              if(scaleTime>10){
                scaleTime=10;
              }
              break;
    case 'w': scaleTime--;
              if(scaleTime<1){
                scaleTime=1;
              }
              break;
    
    //cambiar la ubicacion de la grafica respecto al eje Y
    case 'z': posCeroSenal++;
              if(posCeroSenal>500){
                posCeroSenal=500;
              } 
              break;
    case 'x': posCeroSenal--;
              if(posCeroSenal<-500){
                posCeroSenal=-500;
              }
              break;
              
    //modificar el cero del eje Y
    case 'r': posCeroH++;
              if(posCeroH>500){
                posCeroH=500;
              } 
              break;
    case 't': posCeroH--;
              if(posCeroH<-500){
                posCeroH=-500;
              }
              break;
              
    //modificar la amplitud de la señal
    case 'f': ScalaAmpSenal+=0.1;
              if(ScalaAmpSenal>3){
                ScalaAmpSenal=3;
              } 
              break;
    case 'g': ScalaAmpSenal-=0.1;
              if(ScalaAmpSenal<0.1){
                ScalaAmpSenal=0.1;
              }
              break;
    
    default: break;
  
  
  }

}
