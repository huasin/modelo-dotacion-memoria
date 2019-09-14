########################################################
###
### C1
### + CtoOver: 1
### + CtoUnder: 0
### + Apoyos: MJ6x1
### + Rotaciones: lunes - miercoles
### + Turnos: 9 -> MJ6X1
### + Nivel de Servicio: .74
###
########################################################



###################### Conjuntos #######################
#Cantidad de turnos segun horas jornada y horas diarias
set TFT9 ;
set TFT8 ;
set TMJ6 ;
set TMJ5 ;
set TPT10;
set TPT9 ;
# Turnos eventos
set TMJ6X1 ;

# Dia, mes
set D ;
set D2;
set H ;

# rotacion
set R;
set REV;

###################### Parametros #######################

param M;
param CtoOver = 1;
param CtoUnder = 0;
param NivServicio = 0.74;

# Dias que trabajan los turnos fijos
param LUVI{D} >= 0;
param VISA{D} >= 0;
param SADO{D} >= 0;
param DO  {D} >= 0;

# Turnos
param TURFT9 {TFT9 , H} >= 0;
param TURFT8 {TFT8 , H} >= 0;
param TURMJ6 {TMJ6 , H} >= 0;
param TURMJ5 {TMJ5 , H} >= 0;
param TURPT10{TPT10, H} >= 0;
param TURPT9 {TPT9 , H} >= 0;
# Turnos eventos
param TURMJ6X1{TMJ6X1,H} >= 0;

# Rotaciones
param R4D{R,D} >= 0;
param R7D{R,D} >= 0;
# Rot eventos
param ROTMJ6X1{REV,D} >= 0 ;
param INGRESO{D} ;
param SALIDA {D} ;

# Demanada
param DEM{D,H} >= 0;

###################### Variables #######################

# yj_{tj,d} = cantidad de trabajadores de jornada j y turno tj en el dia d.
# Fijos
var YFTLV45{D,TFT9 } >= 0 integer ;
var YFTLV40{D,TFT8 } >= 0 integer ;
var YMJLV30{D,TMJ6 } >= 0 integer ;
var YMJLV25{D,TMJ5 } >= 0 integer ;
var YPTVS20{D,TPT10} >= 0 integer ;
var YPTSD20{D,TPT10} >= 0 integer ;
var YPTVS18{D,TPT9 } >= 0 integer ;
var YPTSD18{D,TPT9 } >= 0 integer ;
var YPTD10 {D,TPT10} >= 0 integer ;

# Rotativos
var YFT4D45{D,TFT9,R} >= 0 integer ;
var YFT7D45{D,TFT9,R} >= 0 integer ;
var YFT4D40{D,TFT8,R} >= 0 integer ;
var YFT7D40{D,TFT8,R} >= 0 integer ;
var YMJ4D30{D,TMJ6,R} >= 0 integer ;
var YMJ7D30{D,TMJ6,R} >= 0 integer ;
var YMJ4D25{D,TMJ5,R} >= 0 integer ;
var YMJ7D25{D,TMJ5,R} >= 0 integer ;

# Eventos
var YMJ6X1{D2,TMJ6X1,REV} >= 0 integer ;
var MASMJ6X1{D,TMJ6X1,REV} >= 0 integer ;
var MENMJ6X1{D,TMJ6X1,REV} >= 0 integer ;

# B_{s,d,h} horas en el bloque
var B{D,H} >= 0;
# Saber cuanto estoy por arriba o por abajo
var HOVER{D,H} >= 0 ;
var HUNDER{D,H} >= 0 ;

###################### Fun Objetivo #######################

minimize fun_obj: sum{d in D, h in H}(CtoOver*HOVER[d,h] + CtoUnder*HUNDER[d,h]);

###################### Restricciones #######################

# Definicion de B
subject to defB {d in D, h in H}:
    (sum{t in TFT9 } YFTLV45[d,t]*LUVI[d]*TURFT9 [t,h]/2 +
     sum{t in TFT8 } YFTLV40[d,t]*LUVI[d]*TURFT8 [t,h]/2 +
     sum{t in TMJ6 } YMJLV30[d,t]*LUVI[d]*TURMJ6 [t,h]/2 +
     sum{t in TMJ5 } YMJLV25[d,t]*LUVI[d]*TURMJ5 [t,h]/2 +
     sum{t in TPT10} YPTVS20[d,t]*VISA[d]*TURPT10[t,h]/2 +
     sum{t in TPT10} YPTSD20[d,t]*SADO[d]*TURPT10[t,h]/2 +
     sum{t in TPT9 } YPTVS18[d,t]*VISA[d]*TURPT9 [t,h]/2 +
     sum{t in TPT9 } YPTSD18[d,t]*SADO[d]*TURPT9 [t,h]/2 +
     sum{t in TPT10} YPTD10 [d,t]*  DO[d]*TURPT10[t,h]/2 +
     sum{t in TFT9, r in R} YFT4D45[d,t,r]*R4D[r,d]*TURFT9[t,h]/2+
     sum{t in TFT9, r in R} YFT7D45[d,t,r]*R7D[r,d]*TURFT9[t,h]/2+
     sum{t in TFT8, r in R} YFT4D40[d,t,r]*R4D[r,d]*TURFT8[t,h]/2+
     sum{t in TFT8, r in R} YFT7D40[d,t,r]*R7D[r,d]*TURFT8[t,h]/2+
     sum{t in TMJ6, r in R} YMJ4D30[d,t,r]*R4D[r,d]*TURMJ6[t,h]/2+
     sum{t in TMJ6, r in R} YMJ7D30[d,t,r]*R7D[r,d]*TURMJ6[t,h]/2+
     sum{t in TMJ5, r in R} YMJ4D25[d,t,r]*R4D[r,d]*TURMJ5[t,h]/2+
     sum{t in TMJ5, r in R} YMJ7D25[d,t,r]*R7D[r,d]*TURMJ5[t,h]/2+
     sum{t in TMJ6X1, r in REV} YMJ6X1[d,t,r]*TURMJ6X1[t,h]*ROTMJ6X1[r,d]/2
    ) == B[d,h] ;

# Agregar restriccion de presupuestooooo
subject to ppto2: sum{d in D, h in H} B[d,h] <= 4550 ;

# Satisfacer la demanda
subject to CumplirDemanda{d in D, h in H}: B[d,h] >= NivServicio*DEM[d,h] ;

# relacion de demanda
subject to relDemanda {d in D, h in H}: B[d,h] + HUNDER[d,h] - HOVER[d,h] = DEM[d,h] ;

############################ Restricciones de evento  ###############################

subject to ingresoApoyos1{d in D, t in TMJ6X1, r in REV}: YMJ6X1[d,t,r] = YMJ6X1[d-1,t,r] + MASMJ6X1[d,t,r] - MENMJ6X1[d,t,r] ;

subject to condicionInicial1{t in TMJ6X1, r in REV}: YMJ6X1[0,t,r] = 0 ;

subject to ingresoDiasHabiles{d in D, t in TMJ6X1, r in REV}: MASMJ6X1[d,t,r] <= INGRESO[d]*M ;

subject to salidaDiasHabiles{d in D, t in TMJ6X1, r in REV}: MENMJ6X1[d,t,r] <= SALIDA[d]*M ;

############################ Restricciones Dotacion Actual ###############################

#Turnos Fijos
subject to resTurFijo1{d in D}: YMJLV30[d,14] = 4 ;
subject to resTurFijo2{d in D}: YFTLV45[d,2] = 3 ;
subject to resTurFijo3{d in D}: YFTLV45[d,4] = 3 ;
subject to resTurFijo4{d in D}: YMJLV30[d,6] = 2 ;
subject to resTurFijo5{d in D}: YPTSD20[d,2] = 3 ;
subject to resTurFijo6{d in D}: YPTSD20[d,4] = 3 ;
subject to resTurFijo7{d in D}: YPTSD20[d,6] = 6 ;

#Turnos Rotativos

#Turnos Fijos Acumulado
subject to resTurFijoAc1{d in D}: sum{t in TFT9} YFTLV45[d,t] = 6 ;
subject to resTurFijoAc2{d in D}: sum{t in TFT8} YFTLV40[d,t] = 0 ;
subject to resTurFijoAc3{d in D}: sum{t in TMJ6} YMJLV30[d,t] = 6 ;
subject to resTurFijoAc4{d in D}: sum{t in TMJ5} YMJLV25[d,t] = 0 ;
subject to resTurFijoAc5{d in D}: sum{t in TPT10} YPTVS20[d,t] = 0 ;
subject to resTurFijoAc6{d in D}: sum{t in TPT10} YPTSD20[d,t] = 12 ;
subject to resTurFijoAc7{d in D}: sum{t in TPT9} YPTVS18[d,t] = 0 ;
subject to resTurFijoAc8{d in D}: sum{t in TPT9} YPTSD18[d,t] = 0 ;
subject to resTurFijoAc9{d in D}: sum{t in TPT10} YPTD10 [d,t] = 0 ;

#Turnos Rotativos Acumulado
subject to resTurRotAc1{d in D}: sum{t in TFT9, r in R} YFT4D45[d,t,r] = 0 ;
subject to resTurRotAc2{d in D}: sum{t in TFT9, r in R} YFT7D45[d,t,r] = 0 ;
subject to resTurRotAc3{d in D}: sum{t in TFT8, r in R} YFT4D40[d,t,r] = 0 ;
subject to resTurRotAc4{d in D}: sum{t in TFT8, r in R} YFT7D40[d,t,r] = 0 ;
subject to resTurRotAc5{d in D}: sum{t in TMJ6, r in R} YMJ4D30[d,t,r] = 0 ;
subject to resTurRotAc6{d in D}: sum{t in TMJ6, r in R} YMJ7D30[d,t,r] = 0 ;
subject to resTurRotAc7{d in D}: sum{t in TMJ5, r in R} YMJ4D25[d,t,r] = 0 ;
subject to resTurRotAc8{d in D}: sum{t in TMJ5, r in R} YMJ7D25[d,t,r] = 0 ;