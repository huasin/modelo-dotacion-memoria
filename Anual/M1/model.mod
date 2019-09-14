##############################
### SETS
##############################

# Temporalidad
#set Dias ;
#set Dias_0 ;
#set Dias = 1 .. 365;
#set Dias_0 = 0 .. 365;
set DiasIngreso ;
set DiasEgreso ;
set Bloques ;
set BloquesAbierto ;

# Cantidad de turnos segun horas jornada y horas diarias
set TFT09 ;
set TFT08 ;
set TMJ06 ;
set TMJ05 ;
set TPT10 ;
set TPT09 ;

# Rotaciones
set Sem ;

##############################
### PARAMETERS
##############################

# m grande
param M;

# Demandas
param Demanda{Dias,Bloques} >= 0;

# Dias que trabajan los turnos fijos
param LUVI{Dias} >= 0;
param VISA{Dias} >= 0;
param SADO{Dias} >= 0;
param DO  {Dias} >= 0;

# Turnos
param TURFT09 {TFT09 , Bloques} >= 0;
param TURFT08 {TFT08 , Bloques} >= 0;
param TURMJ06 {TMJ06 , Bloques} >= 0;
param TURMJ05 {TMJ05 , Bloques} >= 0;
param TURPT10 {TPT10 , Bloques} >= 0;
param TURPT09 {TPT09 , Bloques} >= 0;

# Rotaciones
param R4D{Sem,Dias} >= 0;
param R7D{Sem,Dias} >= 0;

# Costos
param CtoOver >= 0 ;
param CtoUnder >= 0 ;
param CtoIngresoFT >= 0 ;
param CtoIngresoMJ >= 0 ;
param CtoIngresoPT >= 0 ;
param CtoEgresoFT >= 0 ;
param CtoEgresoMJ >= 0 ;
param CtoEgresoPT >= 0 ;
param CtoEgresoRotativo >= 0 ; 

# Nivel de servicio
param NivServicio >= 0 ;

# Minimo rotativos (puede ser y no)
param MinRotativos >= 0 ;


##############################
### VARIBLES DE DECISION
##############################

# VD1.
var YmasFTLV45{DiasIngreso,TFT09} >= 0 integer ;
var YmasFTLV40{DiasIngreso,TFT08} >= 0 integer ;
var YmasMJLV30{DiasIngreso,TMJ06} >= 0 integer ;
var YmasMJLV25{DiasIngreso,TMJ05} >= 0 integer ;
var YmasPTVS20{DiasIngreso,TPT10} >= 0 integer ;
var YmasPTSD20{DiasIngreso,TPT10} >= 0 integer ;
var YmasPTVS18{DiasIngreso,TPT09} >= 0 integer ;
var YmasPTSD18{DiasIngreso,TPT09} >= 0 integer ;
var YmasPTD10 {DiasIngreso,TPT10} >= 0 integer ;

# VD2.
var YmenosFTLV45{DiasEgreso,TFT09} >= 0 integer ;
var YmenosFTLV40{DiasEgreso,TFT08} >= 0 integer ;
var YmenosMJLV30{DiasEgreso,TMJ06} >= 0 integer ;
var YmenosMJLV25{DiasEgreso,TMJ05} >= 0 integer ;
var YmenosPTVS20{DiasEgreso,TPT10} >= 0 integer ;
var YmenosPTSD20{DiasEgreso,TPT10} >= 0 integer ;
var YmenosPTVS18{DiasEgreso,TPT09} >= 0 integer ;
var YmenosPTSD18{DiasEgreso,TPT09} >= 0 integer ;
var YmenosPTD10 {DiasEgreso,TPT10} >= 0 integer ;

# VD3.
var YmasFT4D45{DiasIngreso,TFT09,Sem} >= 0 integer ;
var YmasFT7D45{DiasIngreso,TFT09,Sem} >= 0 integer ;
var YmasFT4D40{DiasIngreso,TFT08,Sem} >= 0 integer ;
var YmasFT7D40{DiasIngreso,TFT08,Sem} >= 0 integer ;
var YmasMJ4D30{DiasIngreso,TMJ06,Sem} >= 0 integer ;
var YmasMJ7D30{DiasIngreso,TMJ06,Sem} >= 0 integer ;
var YmasMJ4D25{DiasIngreso,TMJ05,Sem} >= 0 integer ;
var YmasMJ7D25{DiasIngreso,TMJ05,Sem} >= 0 integer ;

# VD4.
var YmenosFT4D45{DiasEgreso,TFT09,Sem} >= 0 integer ;
var YmenosFT7D45{DiasEgreso,TFT09,Sem} >= 0 integer ;
var YmenosFT4D40{DiasEgreso,TFT08,Sem} >= 0 integer ;
var YmenosFT7D40{DiasEgreso,TFT08,Sem} >= 0 integer ;
var YmenosMJ4D30{DiasEgreso,TMJ06,Sem} >= 0 integer ;
var YmenosMJ7D30{DiasEgreso,TMJ06,Sem} >= 0 integer ;
var YmenosMJ4D25{DiasEgreso,TMJ05,Sem} >= 0 integer ;
var YmenosMJ7D25{DiasEgreso,TMJ05,Sem} >= 0 integer ;

##############################
### VARIBLES DE ESTADO
##############################

# yj_{tj,d} = cantidad de trabajadores de jornada j y turno tj en el dia d.
# VE1. Fijos
var YFTLV45{Dias_0,TFT09} >= 0 integer ;
var YFTLV40{Dias_0,TFT08} >= 0 integer ;
var YMJLV30{Dias_0,TMJ06} >= 0 integer ;
var YMJLV25{Dias_0,TMJ05} >= 0 integer ;
var YPTVS20{Dias_0,TPT10} >= 0 integer ;
var YPTSD20{Dias_0,TPT10} >= 0 integer ;
var YPTVS18{Dias_0,TPT09} >= 0 integer ;
var YPTSD18{Dias_0,TPT09} >= 0 integer ;
var YPTD10 {Dias_0,TPT10} >= 0 integer ;

# VE2. Rotativos
var YFT4D45{Dias_0,TFT09,Sem} >= 0 integer ;
var YFT7D45{Dias_0,TFT09,Sem} >= 0 integer ;
var YFT4D40{Dias_0,TFT08,Sem} >= 0 integer ;
var YFT7D40{Dias_0,TFT08,Sem} >= 0 integer ;
var YMJ4D30{Dias_0,TMJ06,Sem} >= 0 integer ;
var YMJ7D30{Dias_0,TMJ06,Sem} >= 0 integer ;
var YMJ4D25{Dias_0,TMJ05,Sem} >= 0 integer ;
var YMJ7D25{Dias_0,TMJ05,Sem} >= 0 integer ;

# VE3. Oferta_{s,d,h} horas en el bloque
var Oferta{Dias,Bloques} >= 0;

# VE4. VE5. MissMatch
var HrsOver {Dias,Bloques} >= 0 ;
var HrsUnder {Dias,Bloques} >= 0 ;



##############################
### FUNCION OBJETIVO
##############################

# Se minimizan 3 costos diferentes
minimize fun_obj:
    (
        sum{d in Dias, h in Bloques} (HrsOver[d,h]*CtoOver+HrsUnder[d,h]*CtoUnder) #+
        #sum{d in DiasIngreso} (
        #    sum{t in TFT09} YmasFTLV45[d,t]*CtoIngresoFT +
        #    sum{t in TFT08} YmasFTLV40[d,t]*CtoIngresoFT +
        #    sum{t in TMJ06} YmasMJLV30[d,t]*CtoIngresoMJ +
        #    sum{t in TMJ05} YmasMJLV25[d,t]*CtoIngresoMJ +
        #    sum{t in TPT10} YmasPTVS20[d,t]*CtoIngresoPT +
        #    sum{t in TPT10} YmasPTSD20[d,t]*CtoIngresoPT +
        #    sum{t in TPT09} YmasPTVS18[d,t]*CtoIngresoPT +
        #    sum{t in TPT09} YmasPTSD18[d,t]*CtoIngresoPT +
        #    sum{t in TPT10} YmasPTD10 [d,t]*CtoIngresoPT +
        #    sum{t in TFT09, s in Sem} YmasFT4D45[d,t,s]*CtoIngresoFT +
        #    sum{t in TFT09, s in Sem} YmasFT7D45[d,t,s]*CtoIngresoFT +
        #    sum{t in TFT08, s in Sem} YmasFT4D40[d,t,s]*CtoIngresoFT +
        #    sum{t in TFT08, s in Sem} YmasFT7D40[d,t,s]*CtoIngresoFT +
        #    sum{t in TMJ06, s in Sem} YmasMJ4D30[d,t,s]*CtoIngresoFT +
        #    sum{t in TMJ06, s in Sem} YmasMJ7D30[d,t,s]*CtoIngresoFT +
        #    sum{t in TMJ05, s in Sem} YmasMJ4D25[d,t,s]*CtoIngresoFT +
        #    sum{t in TMJ05, s in Sem} YmasMJ7D25[d,t,s]*CtoIngresoFT
        #) +
        #sum{d in DiasEgreso} (
        #    sum{t in TFT09} YmenosFTLV45[d,t]*CtoIngresoFT +
        #    sum{t in TFT08} YmenosFTLV40[d,t]*CtoIngresoFT +
        #    sum{t in TMJ06} YmenosMJLV30[d,t]*CtoIngresoMJ +
        #    sum{t in TMJ05} YmenosMJLV25[d,t]*CtoIngresoMJ +
        #    sum{t in TPT10} YmenosPTVS20[d,t]*CtoIngresoPT +
        #    sum{t in TPT10} YmenosPTSD20[d,t]*CtoIngresoPT +
        #    sum{t in TPT09} YmenosPTVS18[d,t]*CtoIngresoPT +
        #    sum{t in TPT09} YmenosPTSD18[d,t]*CtoIngresoPT +
        #    sum{t in TPT10} YmenosPTD10 [d,t]*CtoIngresoPT +
        #    sum{t in TFT09, s in Sem} YmenosFT4D45[d,t,s]*CtoIngresoFT*CtoEgresoRotativo +
        #    sum{t in TFT09, s in Sem} YmenosFT7D45[d,t,s]*CtoIngresoFT*CtoEgresoRotativo +
        #    sum{t in TFT08, s in Sem} YmenosFT4D40[d,t,s]*CtoIngresoFT*CtoEgresoRotativo +
        #    sum{t in TFT08, s in Sem} YmenosFT7D40[d,t,s]*CtoIngresoFT*CtoEgresoRotativo +
        #    sum{t in TMJ06, s in Sem} YmenosMJ4D30[d,t,s]*CtoIngresoFT*CtoEgresoRotativo +
        #    sum{t in TMJ06, s in Sem} YmenosMJ7D30[d,t,s]*CtoIngresoFT*CtoEgresoRotativo +
        #    sum{t in TMJ05, s in Sem} YmenosMJ4D25[d,t,s]*CtoIngresoFT*CtoEgresoRotativo +
        #    sum{t in TMJ05, s in Sem} YmenosMJ7D25[d,t,s]*CtoIngresoFT*CtoEgresoRotativo
        #)
    ) ;

##############################
### RESTRICCIONES
##############################

# R1. - R9. Naturaleza de las variables

# R10. Definicion de Oferta
subject to defB {d in Dias, h in Bloques}:
    (sum{t in TFT09} YFTLV45[d,t]*LUVI[d]*TURFT09[t,h]/2 +
     sum{t in TFT08} YFTLV40[d,t]*LUVI[d]*TURFT08[t,h]/2 +
     sum{t in TMJ06} YMJLV30[d,t]*LUVI[d]*TURMJ06[t,h]/2 +
     sum{t in TMJ05} YMJLV25[d,t]*LUVI[d]*TURMJ05[t,h]/2 +
     sum{t in TPT10} YPTVS20[d,t]*VISA[d]*TURPT10[t,h]/2 +
     sum{t in TPT10} YPTSD20[d,t]*SADO[d]*TURPT10[t,h]/2 +
     sum{t in TPT09} YPTVS18[d,t]*VISA[d]*TURPT09[t,h]/2 +
     sum{t in TPT09} YPTSD18[d,t]*SADO[d]*TURPT09[t,h]/2 +
     sum{t in TPT10} YPTD10 [d,t]*  DO[d]*TURPT10[t,h]/2 +
     sum{t in TFT09, r in Sem} YFT4D45[d,t,r]*R4D[r,d]*TURFT09[t,h]/2+
     sum{t in TFT09, r in Sem} YFT7D45[d,t,r]*R7D[r,d]*TURFT09[t,h]/2+
     sum{t in TFT08, r in Sem} YFT4D40[d,t,r]*R4D[r,d]*TURFT08[t,h]/2+
     sum{t in TFT08, r in Sem} YFT7D40[d,t,r]*R7D[r,d]*TURFT08[t,h]/2+
     sum{t in TMJ06, r in Sem} YMJ4D30[d,t,r]*R4D[r,d]*TURMJ06[t,h]/2+
     sum{t in TMJ06, r in Sem} YMJ7D30[d,t,r]*R7D[r,d]*TURMJ06[t,h]/2+
     sum{t in TMJ05, r in Sem} YMJ4D25[d,t,r]*R4D[r,d]*TURMJ05[t,h]/2+
     sum{t in TMJ05, r in Sem} YMJ7D25[d,t,r]*R7D[r,d]*TURMJ05[t,h]/2
    ) = Oferta[d,h] ;

# R11. Relacion oferta demanda
subject to relDemanda {d in Dias, h in Bloques}: 
    Oferta[d,h] + HrsUnder[d,h] - HrsOver[d,h] = Demanda[d,h] ;

# R12. Flujo de Personal
subject to flujo101 {d in DiasIngreso inter DiasEgreso, t in TFT09}: YFTLV45[d,t] = YFTLV45[d-1,t] + YmasFTLV45[d,t] - YmenosFTLV45[d,t] ;
subject to flujo102 {d in DiasIngreso inter DiasEgreso, t in TFT08}: YFTLV40[d,t] = YFTLV40[d-1,t] + YmasFTLV40[d,t] - YmenosFTLV40[d,t] ;
subject to flujo103 {d in DiasIngreso inter DiasEgreso, t in TMJ06}: YMJLV30[d,t] = YMJLV30[d-1,t] + YmasMJLV30[d,t] - YmenosMJLV30[d,t] ;
subject to flujo104 {d in DiasIngreso inter DiasEgreso, t in TMJ05}: YMJLV25[d,t] = YMJLV25[d-1,t] + YmasMJLV25[d,t] - YmenosMJLV25[d,t] ;
subject to flujo105 {d in DiasIngreso inter DiasEgreso, t in TPT10}: YPTVS20[d,t] = YPTVS20[d-1,t] + YmasPTVS20[d,t] - YmenosPTVS20[d,t] ;
subject to flujo106 {d in DiasIngreso inter DiasEgreso, t in TPT10}: YPTSD20[d,t] = YPTSD20[d-1,t] + YmasPTSD20[d,t] - YmenosPTSD20[d,t] ;
subject to flujo107 {d in DiasIngreso inter DiasEgreso, t in TPT09}: YPTVS18[d,t] = YPTVS18[d-1,t] + YmasPTVS18[d,t] - YmenosPTVS18[d,t] ;
subject to flujo108 {d in DiasIngreso inter DiasEgreso, t in TPT09}: YPTSD18[d,t] = YPTSD18[d-1,t] + YmasPTSD18[d,t] - YmenosPTSD18[d,t] ;
subject to flujo109 {d in DiasIngreso inter DiasEgreso, t in TPT10}: YPTD10 [d,t] = YPTD10 [d-1,t] + YmasPTD10 [d,t] - YmenosPTD10 [d,t] ;

# R13.
subject to flujo201 {d in DiasIngreso diff DiasEgreso, t in TFT09}: YFTLV45[d,t] = YFTLV45[d-1,t] + YmasFTLV45[d,t] ;
subject to flujo202 {d in DiasIngreso diff DiasEgreso, t in TFT08}: YFTLV40[d,t] = YFTLV40[d-1,t] + YmasFTLV40[d,t] ;
subject to flujo203 {d in DiasIngreso diff DiasEgreso, t in TMJ06}: YMJLV30[d,t] = YMJLV30[d-1,t] + YmasMJLV30[d,t] ;
subject to flujo204 {d in DiasIngreso diff DiasEgreso, t in TMJ05}: YMJLV25[d,t] = YMJLV25[d-1,t] + YmasMJLV25[d,t] ;
subject to flujo205 {d in DiasIngreso diff DiasEgreso, t in TPT10}: YPTVS20[d,t] = YPTVS20[d-1,t] + YmasPTVS20[d,t] ;
subject to flujo206 {d in DiasIngreso diff DiasEgreso, t in TPT10}: YPTSD20[d,t] = YPTSD20[d-1,t] + YmasPTSD20[d,t] ;
subject to flujo207 {d in DiasIngreso diff DiasEgreso, t in TPT09}: YPTVS18[d,t] = YPTVS18[d-1,t] + YmasPTVS18[d,t] ;
subject to flujo208 {d in DiasIngreso diff DiasEgreso, t in TPT09}: YPTSD18[d,t] = YPTSD18[d-1,t] + YmasPTSD18[d,t] ;
subject to flujo209 {d in DiasIngreso diff DiasEgreso, t in TPT10}: YPTD10 [d,t] = YPTD10 [d-1,t] + YmasPTD10 [d,t] ;

# R14.
subject to flujo301 {d in DiasEgreso diff DiasIngreso, t in TFT09}: YFTLV45[d,t] = YFTLV45[d-1,t] - YmenosFTLV45[d,t] ;
subject to flujo302 {d in DiasEgreso diff DiasIngreso, t in TFT08}: YFTLV40[d,t] = YFTLV40[d-1,t] - YmenosFTLV40[d,t] ;
subject to flujo303 {d in DiasEgreso diff DiasIngreso, t in TMJ06}: YMJLV30[d,t] = YMJLV30[d-1,t] - YmenosMJLV30[d,t] ;
subject to flujo304 {d in DiasEgreso diff DiasIngreso, t in TMJ05}: YMJLV25[d,t] = YMJLV25[d-1,t] - YmenosMJLV25[d,t] ;
subject to flujo305 {d in DiasEgreso diff DiasIngreso, t in TPT10}: YPTVS20[d,t] = YPTVS20[d-1,t] - YmenosPTVS20[d,t] ;
subject to flujo306 {d in DiasEgreso diff DiasIngreso, t in TPT10}: YPTSD20[d,t] = YPTSD20[d-1,t] - YmenosPTSD20[d,t] ;
subject to flujo307 {d in DiasEgreso diff DiasIngreso, t in TPT09}: YPTVS18[d,t] = YPTVS18[d-1,t] - YmenosPTVS18[d,t] ;
subject to flujo308 {d in DiasEgreso diff DiasIngreso, t in TPT09}: YPTSD18[d,t] = YPTSD18[d-1,t] - YmenosPTSD18[d,t] ;
subject to flujo309 {d in DiasEgreso diff DiasIngreso, t in TPT10}: YPTD10 [d,t] = YPTD10 [d-1,t] - YmenosPTD10 [d,t] ;

# R15.
subject to flujo401 {d in Dias diff DiasIngreso diff DiasEgreso, t in TFT09}: YFTLV45[d,t] = YFTLV45[d-1,t] ;
subject to flujo402 {d in Dias diff DiasIngreso diff DiasEgreso, t in TFT08}: YFTLV40[d,t] = YFTLV40[d-1,t] ;
subject to flujo403 {d in Dias diff DiasIngreso diff DiasEgreso, t in TMJ06}: YMJLV30[d,t] = YMJLV30[d-1,t] ;
subject to flujo404 {d in Dias diff DiasIngreso diff DiasEgreso, t in TMJ05}: YMJLV25[d,t] = YMJLV25[d-1,t] ;
subject to flujo405 {d in Dias diff DiasIngreso diff DiasEgreso, t in TPT10}: YPTVS20[d,t] = YPTVS20[d-1,t] ;
subject to flujo406 {d in Dias diff DiasIngreso diff DiasEgreso, t in TPT10}: YPTSD20[d,t] = YPTSD20[d-1,t] ;
subject to flujo407 {d in Dias diff DiasIngreso diff DiasEgreso, t in TPT09}: YPTVS18[d,t] = YPTVS18[d-1,t] ;
subject to flujo408 {d in Dias diff DiasIngreso diff DiasEgreso, t in TPT09}: YPTSD18[d,t] = YPTSD18[d-1,t] ;
subject to flujo409 {d in Dias diff DiasIngreso diff DiasEgreso, t in TPT10}: YPTD10 [d,t] = YPTD10 [d-1,t] ;

# R16. Rotativo
subject to flujo501 {d in DiasIngreso inter DiasEgreso, t in TFT09, s in Sem}: YFT4D45[d,t,s] = YFT4D45[d-1,t,s] + YmasFT4D45[d,t,s] - YmenosFT4D45[d,t,s] ;
subject to flujo502 {d in DiasIngreso inter DiasEgreso, t in TFT09, s in Sem}: YFT7D45[d,t,s] = YFT7D45[d-1,t,s] + YmasFT7D45[d,t,s] - YmenosFT7D45[d,t,s] ;
subject to flujo503 {d in DiasIngreso inter DiasEgreso, t in TFT08, s in Sem}: YFT4D40[d,t,s] = YFT4D40[d-1,t,s] + YmasFT4D40[d,t,s] - YmenosFT4D40[d,t,s] ;
subject to flujo504 {d in DiasIngreso inter DiasEgreso, t in TFT08, s in Sem}: YFT7D40[d,t,s] = YFT7D40[d-1,t,s] + YmasFT7D40[d,t,s] - YmenosFT7D40[d,t,s] ;
subject to flujo505 {d in DiasIngreso inter DiasEgreso, t in TMJ06, s in Sem}: YMJ4D30[d,t,s] = YMJ4D30[d-1,t,s] + YmasMJ4D30[d,t,s] - YmenosMJ4D30[d,t,s] ;
subject to flujo506 {d in DiasIngreso inter DiasEgreso, t in TMJ06, s in Sem}: YMJ7D30[d,t,s] = YMJ7D30[d-1,t,s] + YmasMJ7D30[d,t,s] - YmenosMJ7D30[d,t,s] ;
subject to flujo507 {d in DiasIngreso inter DiasEgreso, t in TMJ05, s in Sem}: YMJ4D25[d,t,s] = YMJ4D25[d-1,t,s] + YmasMJ4D25[d,t,s] - YmenosMJ4D25[d,t,s] ;
subject to flujo508 {d in DiasIngreso inter DiasEgreso, t in TMJ05, s in Sem}: YMJ7D25[d,t,s] = YMJ7D25[d-1,t,s] + YmasMJ7D25[d,t,s] - YmenosMJ7D25[d,t,s] ;

# R17. Rotativo
subject to flujo601 {d in DiasIngreso diff DiasEgreso, t in TFT09, s in Sem}: YFT4D45[d,t,s] = YFT4D45[d-1,t,s] + YmasFT4D45[d,t,s] ;
subject to flujo602 {d in DiasIngreso diff DiasEgreso, t in TFT09, s in Sem}: YFT7D45[d,t,s] = YFT7D45[d-1,t,s] + YmasFT7D45[d,t,s] ;
subject to flujo603 {d in DiasIngreso diff DiasEgreso, t in TFT08, s in Sem}: YFT4D40[d,t,s] = YFT4D40[d-1,t,s] + YmasFT4D40[d,t,s] ;
subject to flujo604 {d in DiasIngreso diff DiasEgreso, t in TFT08, s in Sem}: YFT7D40[d,t,s] = YFT7D40[d-1,t,s] + YmasFT7D40[d,t,s] ;
subject to flujo605 {d in DiasIngreso diff DiasEgreso, t in TMJ06, s in Sem}: YMJ4D30[d,t,s] = YMJ4D30[d-1,t,s] + YmasMJ4D30[d,t,s] ;
subject to flujo606 {d in DiasIngreso diff DiasEgreso, t in TMJ06, s in Sem}: YMJ7D30[d,t,s] = YMJ7D30[d-1,t,s] + YmasMJ7D30[d,t,s] ;
subject to flujo607 {d in DiasIngreso diff DiasEgreso, t in TMJ05, s in Sem}: YMJ4D25[d,t,s] = YMJ4D25[d-1,t,s] + YmasMJ4D25[d,t,s] ;
subject to flujo608 {d in DiasIngreso diff DiasEgreso, t in TMJ05, s in Sem}: YMJ7D25[d,t,s] = YMJ7D25[d-1,t,s] + YmasMJ7D25[d,t,s] ;

# R18. Rotativo
subject to flujo701 {d in DiasEgreso diff DiasIngreso, t in TFT09, s in Sem}: YFT4D45[d,t,s] = YFT4D45[d-1,t,s] - YmenosFT4D45[d,t,s] ;
subject to flujo702 {d in DiasEgreso diff DiasIngreso, t in TFT09, s in Sem}: YFT7D45[d,t,s] = YFT7D45[d-1,t,s] - YmenosFT7D45[d,t,s] ;
subject to flujo703 {d in DiasEgreso diff DiasIngreso, t in TFT08, s in Sem}: YFT4D40[d,t,s] = YFT4D40[d-1,t,s] - YmenosFT4D40[d,t,s] ;
subject to flujo704 {d in DiasEgreso diff DiasIngreso, t in TFT08, s in Sem}: YFT7D40[d,t,s] = YFT7D40[d-1,t,s] - YmenosFT7D40[d,t,s] ;
subject to flujo705 {d in DiasEgreso diff DiasIngreso, t in TMJ06, s in Sem}: YMJ4D30[d,t,s] = YMJ4D30[d-1,t,s] - YmenosMJ4D30[d,t,s] ;
subject to flujo706 {d in DiasEgreso diff DiasIngreso, t in TMJ06, s in Sem}: YMJ7D30[d,t,s] = YMJ7D30[d-1,t,s] - YmenosMJ7D30[d,t,s] ;
subject to flujo707 {d in DiasEgreso diff DiasIngreso, t in TMJ05, s in Sem}: YMJ4D25[d,t,s] = YMJ4D25[d-1,t,s] - YmenosMJ4D25[d,t,s] ;
subject to flujo708 {d in DiasEgreso diff DiasIngreso, t in TMJ05, s in Sem}: YMJ7D25[d,t,s] = YMJ7D25[d-1,t,s] - YmenosMJ7D25[d,t,s] ;

# R19. Rotativo
subject to flujo801 {d in Dias diff DiasIngreso diff DiasEgreso, t in TFT09, s in Sem}: YFT4D45[d,t,s] = YFT4D45[d-1,t,s] ;
subject to flujo802 {d in Dias diff DiasIngreso diff DiasEgreso, t in TFT09, s in Sem}: YFT7D45[d,t,s] = YFT7D45[d-1,t,s] ;
subject to flujo803 {d in Dias diff DiasIngreso diff DiasEgreso, t in TFT08, s in Sem}: YFT4D40[d,t,s] = YFT4D40[d-1,t,s] ;
subject to flujo804 {d in Dias diff DiasIngreso diff DiasEgreso, t in TFT08, s in Sem}: YFT7D40[d,t,s] = YFT7D40[d-1,t,s] ;
subject to flujo805 {d in Dias diff DiasIngreso diff DiasEgreso, t in TMJ06, s in Sem}: YMJ4D30[d,t,s] = YMJ4D30[d-1,t,s] ;
subject to flujo806 {d in Dias diff DiasIngreso diff DiasEgreso, t in TMJ06, s in Sem}: YMJ7D30[d,t,s] = YMJ7D30[d-1,t,s] ;
subject to flujo807 {d in Dias diff DiasIngreso diff DiasEgreso, t in TMJ05, s in Sem}: YMJ4D25[d,t,s] = YMJ4D25[d-1,t,s] ;
subject to flujo808 {d in Dias diff DiasIngreso diff DiasEgreso, t in TMJ05, s in Sem}: YMJ7D25[d,t,s] = YMJ7D25[d-1,t,s] ;

# R20. Condicion inicial personal Fijo
subject to condicionInicialFijo01 {t in TFT09}: YFTLV45[0,t] = 0 ;
subject to condicionInicialFijo02 {t in TFT08}: YFTLV40[0,t] = 0 ;
subject to condicionInicialFijo03 {t in TMJ06}: YMJLV30[0,t] = 0 ;
subject to condicionInicialFijo04 {t in TMJ05}: YMJLV25[0,t] = 0 ;
subject to condicionInicialFijo05 {t in TPT10}: YPTVS20[0,t] = 0 ;
subject to condicionInicialFijo06 {t in TPT10}: YPTSD20[0,t] = 0 ;
subject to condicionInicialFijo07 {t in TPT09}: YPTVS18[0,t] = 0 ;
subject to condicionInicialFijo08 {t in TPT09}: YPTSD18[0,t] = 0 ;
subject to condicionInicialFijo09 {t in TPT10}: YPTD10 [0,t] = 0 ;

# R21. Condicion inicial personal Rotativo
subject to condicionInicialRot01 {t in TFT09, s in Sem}: YFT4D45[0,t,s] = 0 ;
subject to condicionInicialRot02 {t in TFT09, s in Sem}: YFT7D45[0,t,s] = 0 ;
subject to condicionInicialRot03 {t in TFT08, s in Sem}: YFT4D40[0,t,s] = 0 ;
subject to condicionInicialRot04 {t in TFT08, s in Sem}: YFT7D40[0,t,s] = 0 ;
subject to condicionInicialRot05 {t in TMJ06, s in Sem}: YMJ4D30[0,t,s] = 0 ;
subject to condicionInicialRot06 {t in TMJ06, s in Sem}: YMJ7D30[0,t,s] = 0 ;
subject to condicionInicialRot07 {t in TMJ05, s in Sem}: YMJ4D25[0,t,s] = 0 ;
subject to condicionInicialRot08 {t in TMJ05, s in Sem}: YMJ7D25[0,t,s] = 0 ;

# R22. Minimo nivel del servicio
subject to minimoNivelServicio {d in Dias, h in Bloques}: Oferta[d,h] >= NivServicio*Demanda[d,h] ;

# R23. Minimo de Rotativos
#subject to minimoRotativos {d in Dias}:
#    sum{s in Sem} (
#        sum{t in TFT09} YFT4D45[d,t,s] +
#        sum{t in TFT09} YFT7D45[d,t,s] +
#        sum{t in TFT08} YFT4D40[d,t,s] +
#        sum{t in TFT08} YFT7D40[d,t,s] +
#        sum{t in TMJ06} YMJ4D30[d,t,s] +
#        sum{t in TMJ06} YMJ7D30[d,t,s] +
#        sum{t in TMJ05} YMJ4D25[d,t,s] +
#        sum{t in TMJ05} YMJ7D25[d,t,s] 
#    ) >= MinRotativos ;

# R24. Minimo de personal mientras la tienda esta abierta
#subject to minimoPersonal {d in Dias, h in Bloques}: Oferta[d,h] >= 1 ;



