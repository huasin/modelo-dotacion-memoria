########################################################
###
### C1
### + CtoOver: 1
### + CtoUnder: 0
### + Apoyos: MJ6x1
### + Rotaciones: lunes - miercoles
### + Turnos: 9 -> MJ6X1
### + Nivel de Servicio: .8
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

# Dia, mes
set D = 1..365;
set D2 = 0..365;
set H ;
set DLUVI;
set DSADO;

# rotacion
set R;

###################### Parametros #######################

param M;
param CtoOver = 1;
param CtoUnder = 0;
param NivServicio = 0.8;

param CtoIngresoFT =  48;
param CtoIngresoMJ =  60;
param CtoIngresoPT =  30;
param CtoEgresoFT  =  90;
param CtoEgresoMJ  =  60;
param CtoEgresoPT  =  30;


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

# Rotaciones
param R4D{R,D} >= 0;
param R7D{R,D} >= 0;

param INGRESO{D} ;
param SALIDA {D} ;

# Demanada
param DEM{D,H} >= 0;

###################### Variables #######################

# yj_{tj,d} = cantidad de trabajadores de jornada j y turno tj en el dia d.
# Fijos
var YFTLV45{D2,TFT9 } >= 0 integer ;
var YFTLV40{D2,TFT8 } >= 0 integer ;
var YMJLV30{D2,TMJ6 } >= 0 integer ;
var YMJLV25{D2,TMJ5 } >= 0 integer ;
var YPTVS20{D2,TPT10} >= 0 integer ;
var YPTSD20{D2,TPT10} >= 0 integer ;
var YPTVS18{D2,TPT9 } >= 0 integer ;
var YPTSD18{D2,TPT9 } >= 0 integer ;
var YPTD10 {D2,TPT10} >= 0 integer ;

# Rotativos
var YFT4D45{D2,TFT9,R} >= 0 integer ;
var YFT7D45{D2,TFT9,R} >= 0 integer ;
var YFT4D40{D2,TFT8,R} >= 0 integer ;
var YFT7D40{D2,TFT8,R} >= 0 integer ;
var YMJ4D30{D2,TMJ6,R} >= 0 integer ;
var YMJ7D30{D2,TMJ6,R} >= 0 integer ;
var YMJ4D25{D2,TMJ5,R} >= 0 integer ;
var YMJ7D25{D2,TMJ5,R} >= 0 integer ;

# Eventos
#var MASMJ6X1{D,TMJ6X1,REV} >= 0 integer ;
#var MENMJ6X1{D,TMJ6X1,REV} >= 0 integer ;
# Fijos
var YmasFTLV45{D,TFT9 } >= 0 integer ;
var YmasFTLV40{D,TFT8 } >= 0 integer ;
var YmasMJLV30{D,TMJ6 } >= 0 integer ;
var YmasMJLV25{D,TMJ5 } >= 0 integer ;
var YmasPTVS20{D,TPT10} >= 0 integer ;
var YmasPTSD20{D,TPT10} >= 0 integer ;
var YmasPTVS18{D,TPT9 } >= 0 integer ;
var YmasPTSD18{D,TPT9 } >= 0 integer ;
var YmasPTD10 {D,TPT10} >= 0 integer ;
# --
var YmenFTLV45{D,TFT9 } >= 0 integer ;
var YmenFTLV40{D,TFT8 } >= 0 integer ;
var YmenMJLV30{D,TMJ6 } >= 0 integer ;
var YmenMJLV25{D,TMJ5 } >= 0 integer ;
var YmenPTVS20{D,TPT10} >= 0 integer ;
var YmenPTSD20{D,TPT10} >= 0 integer ;
var YmenPTVS18{D,TPT9 } >= 0 integer ;
var YmenPTSD18{D,TPT9 } >= 0 integer ;
var YmenPTD10 {D,TPT10} >= 0 integer ;



# B_{s,d,h} horas en el bloque
var B{D,H} >= 0;
# Saber cuanto estoy por arriba o por abajo
var HOVER{D,H} >= 0 ;
var HUNDER{D,H} >= 0 ;

###################### Fun Objetivo #######################

minimize fun_obj:
    sum{d in D} (
        sum{h in H}(CtoOver*HOVER[d,h] + CtoUnder*HUNDER[d,h]) +
        sum{t in TFT9 }(YmasFTLV45[d,t])*CtoIngresoFT +
        sum{t in TFT8 }(YmasFTLV40[d,t])*CtoIngresoFT +
        sum{t in TMJ6 }(YmasMJLV30[d,t])*CtoIngresoMJ +
        sum{t in TMJ5 }(YmasMJLV25[d,t])*CtoIngresoMJ +
        sum{t in TPT10}(YmasPTVS20[d,t])*CtoIngresoPT +
        sum{t in TPT10}(YmasPTSD20[d,t])*CtoIngresoPT +
        sum{t in TPT9 }(YmasPTVS18[d,t])*CtoIngresoPT +
        sum{t in TPT9 }(YmasPTSD18[d,t])*CtoIngresoPT +
        sum{t in TPT10}(YmasPTD10 [d,t])*CtoIngresoPT +
        sum{t in TFT9 }(YmenFTLV45[d,t])*CtoEgresoFT  +
        sum{t in TFT8 }(YmenFTLV40[d,t])*CtoEgresoFT  +
        sum{t in TMJ6 }(YmenMJLV30[d,t])*CtoEgresoMJ  +
        sum{t in TMJ5 }(YmenMJLV25[d,t])*CtoEgresoMJ  +
        sum{t in TPT10}(YmenPTVS20[d,t])*CtoEgresoPT  +
        sum{t in TPT10}(YmenPTSD20[d,t])*CtoEgresoPT  +
        sum{t in TPT9 }(YmenPTVS18[d,t])*CtoEgresoPT  +
        sum{t in TPT9 }(YmenPTSD18[d,t])*CtoEgresoPT  +
        sum{t in TPT10}(YmenPTD10 [d,t])*CtoEgresoPT 
    )
;

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
     sum{t in TMJ5, r in R} YMJ7D25[d,t,r]*R7D[r,d]*TURMJ5[t,h]/2
    ) == B[d,h] ;


# Satisfacer la demanda
subject to CumplirDemanda{d in D, h in H}: B[d,h] >= NivServicio*DEM[d,h] ;

# relacion de demanda
subject to relDemanda {d in D, h in H}: B[d,h] + HUNDER[d,h] - HOVER[d,h] = DEM[d,h] ;

############################ Restricciones de Flujo  ###############################

subject to ingresoApoyos01{d in D, t in TFT9 }: YFTLV45[d,t] = YFTLV45[d-1,t] + YmasFTLV45[d,t] - YmenFTLV45[d,t] ;
subject to ingresoApoyos02{d in D, t in TFT8 }: YFTLV40[d,t] = YFTLV40[d-1,t] + YmasFTLV40[d,t] - YmenFTLV40[d,t] ;
subject to ingresoApoyos03{d in D, t in TMJ6 }: YMJLV30[d,t] = YMJLV30[d-1,t] + YmasMJLV30[d,t] - YmenMJLV30[d,t] ;
subject to ingresoApoyos04{d in D, t in TMJ5 }: YMJLV25[d,t] = YMJLV25[d-1,t] + YmasMJLV25[d,t] - YmenMJLV25[d,t] ;
subject to ingresoApoyos05{d in D, t in TPT10}: YPTVS20[d,t] = YPTVS20[d-1,t] + YmasPTVS20[d,t] - YmenPTVS20[d,t] ;
subject to ingresoApoyos06{d in D, t in TPT10}: YPTSD20[d,t] = YPTSD20[d-1,t] + YmasPTSD20[d,t] - YmenPTSD20[d,t] ;
subject to ingresoApoyos07{d in D, t in TPT9 }: YPTVS18[d,t] = YPTVS18[d-1,t] + YmasPTVS18[d,t] - YmenPTVS18[d,t] ;
subject to ingresoApoyos08{d in D, t in TPT9 }: YPTSD18[d,t] = YPTSD18[d-1,t] + YmasPTSD18[d,t] - YmenPTSD18[d,t] ;
subject to ingresoApoyos09{d in D, t in TPT10}: YPTD10 [d,t] = YPTD10 [d-1,t] + YmasPTD10 [d,t] - YmenPTD10 [d,t] ;

#subject to condicionInicial1{t in TMJ6X1, r in REV}: YMJ6X1[0,t,r] = 0 ;
subject to condicionInicial01{t in TFT9 }: YFTLV45[0,t] = 0 ;
subject to condicionInicial02{t in TFT8 }: YFTLV40[0,t] = 0 ;
subject to condicionInicial03{t in TMJ6 }: YMJLV30[0,t] = 0 ;
subject to condicionInicial04{t in TMJ5 }: YMJLV25[0,t] = 0 ;
subject to condicionInicial05{t in TPT10}: YPTVS20[0,t] = 0 ;
subject to condicionInicial06{t in TPT10}: YPTSD20[0,t] = 0 ;
subject to condicionInicial07{t in TPT9 }: YPTVS18[0,t] = 0 ;
subject to condicionInicial08{t in TPT9 }: YPTSD18[0,t] = 0 ;
subject to condicionInicial09{t in TPT10}: YPTD10 [0,t] = 0 ;

# subject to ingresoDiasHabiles{d in D, t in TMJ6X1, r in REV}: MASMJ6X1[d,t,r] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles01{d in D, t in TFT9 }: YmasFTLV45[d,t] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles02{d in D, t in TFT8 }: YmasFTLV40[d,t] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles03{d in D, t in TMJ6 }: YmasMJLV30[d,t] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles04{d in D, t in TMJ5 }: YmasMJLV25[d,t] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles05{d in D, t in TPT10}: YmasPTVS20[d,t] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles06{d in D, t in TPT10}: YmasPTSD20[d,t] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles07{d in D, t in TPT9 }: YmasPTVS18[d,t] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles08{d in D, t in TPT9 }: YmasPTSD18[d,t] <= INGRESO[d]*M ;
subject to ingresoDiasHabiles09{d in D, t in TPT10}: YmasPTD10 [d,t] <= INGRESO[d]*M ;

#subject to salidaDiasHabiles{d in D, t in TMJ6X1, r in REV}: MENMJ6X1[d,t,r] <= SALIDA[d]*M ;
subject to salidaDiasHabiles01{d in D, t in TFT9 }: YmenFTLV45[d,t] <= SALIDA[d]*M ;
subject to salidaDiasHabiles02{d in D, t in TFT8 }: YmenFTLV40[d,t] <= SALIDA[d]*M ;
subject to salidaDiasHabiles03{d in D, t in TMJ6 }: YmenMJLV30[d,t] <= SALIDA[d]*M ;
subject to salidaDiasHabiles04{d in D, t in TMJ5 }: YmenMJLV25[d,t] <= SALIDA[d]*M ;
subject to salidaDiasHabiles05{d in D, t in TPT10}: YmenPTVS20[d,t] <= SALIDA[d]*M ;
subject to salidaDiasHabiles06{d in D, t in TPT10}: YmenPTSD20[d,t] <= SALIDA[d]*M ;
subject to salidaDiasHabiles07{d in D, t in TPT9 }: YmenPTVS18[d,t] <= SALIDA[d]*M ;
subject to salidaDiasHabiles08{d in D, t in TPT9 }: YmenPTSD18[d,t] <= SALIDA[d]*M ;
subject to salidaDiasHabiles09{d in D, t in TPT10}: YmenPTD10 [d,t] <= SALIDA[d]*M ;



############################ Restricciones Dotacion Actual ###############################

# Tengo que tener un minimo de Rotativos todos los dias, pongamosle 2
subject to minRotativos{d in D}:
   (sum{t in TFT9, r in R} YFT4D45[d,t,r] + 
    sum{t in TFT9, r in R} YFT7D45[d,t,r] + 
    sum{t in TFT8, r in R} YFT4D40[d,t,r] + 
    sum{t in TFT8, r in R} YFT7D40[d,t,r] + 
    sum{t in TMJ6, r in R} YMJ4D30[d,t,r] + 
    sum{t in TMJ6, r in R} YMJ7D30[d,t,r] + 
    sum{t in TMJ5, r in R} YMJ4D25[d,t,r] + 
    sum{t in TMJ5, r in R} YMJ7D25[d,t,r] ) >= 2 ;


# Restriccion de flujoooooooo
##subject to restFlujo01{d in D, t in TFT9 }: YFTLV45[d,t] = YFTLV45[d-1,t];
#subject to restFlujo02{d in D, t in TFT8 }: YFTLV40[d,t] = YFTLV40[d-1,t];
##subject to restFlujo03{d in D, t in TMJ6 }: YMJLV30[d,t] = YMJLV30[d-1,t];
#subject to restFlujo04{d in D, t in TMJ5 }: YMJLV25[d,t] = YMJLV25[d-1,t];
#subject to restFlujo05{d in D, t in TPT10}: YPTVS20[d,t] = YPTVS20[d-1,t];
#subject to restFlujo06{d in D, t in TPT10}: YPTSD20[d,t] = YPTSD20[d-1,t];
#subject to restFlujo07{d in D, t in TPT9 }: YPTVS18[d,t] = YPTVS18[d-1,t];
##subject to restFlujo08{d in D, t in TPT9 }: YPTSD18[d,t] = YPTSD18[d-1,t];
#subject to restFlujo09{d in D, t in TPT10}: YPTD10 [d,t] = YPTD10 [d-1,t];

subject to restFlujo10{d in D, t in TFT9, r in R}: YFT4D45[d,t,r] = YFT4D45[d-1,t,r];
subject to restFlujo11{d in D, t in TFT9, r in R}: YFT7D45[d,t,r] = YFT7D45[d-1,t,r];
subject to restFlujo12{d in D, t in TFT8, r in R}: YFT4D40[d,t,r] = YFT4D40[d-1,t,r];
subject to restFlujo13{d in D, t in TFT8, r in R}: YFT7D40[d,t,r] = YFT7D40[d-1,t,r];
subject to restFlujo14{d in D, t in TMJ6, r in R}: YMJ4D30[d,t,r] = YMJ4D30[d-1,t,r];
subject to restFlujo15{d in D, t in TMJ6, r in R}: YMJ7D30[d,t,r] = YMJ7D30[d-1,t,r];
subject to restFlujo16{d in D, t in TMJ5, r in R}: YMJ4D25[d,t,r] = YMJ4D25[d-1,t,r];
subject to restFlujo17{d in D, t in TMJ5, r in R}: YMJ7D25[d,t,r] = YMJ7D25[d-1,t,r];


