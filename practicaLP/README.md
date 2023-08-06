
# Pràctica de GEI-LP (edició 2021-2022 Q2): Dobe intèrpret de JSBach
L'objectiu d'aquesta pràctica és la implementació d'un doble intèrpret pel llenguatge 
de programació musical i orientat a la composició algorísmica JSBach. 

S'anomena doble intèrpret ja que funciona tant en el sentit informàtic (interpreta
un programa) com en el sentit musical (interpreta una peça de música). 

Genera com a sortida una partitura i uns fitxers de so que reproduiràn la melodia
descrita pel compositor.



## Instalació
Per tal que funcioni el programa, s'ha de tenir instalats els següents programes:

- Python3

- ANTLR4 (pip3 install antlr4-python3-runtime)

- Lilipond

- Timidity++

- ffmpeg





## Compilació
Compilació de la gramàtica:

- antlr4 -Dlanguage=Python3 -no-listener -visitor jsbach.g4
## Execució
Execució del programa:

- python3 jsbach.py musica.jsb 

Execució del programa per una funció arbitrària (per defecte executa main())

- python3 jsbach.py musica.jsb funcio param1 param2

Si el programa no té errors i s'executa correctament, llavors es generaràn els fitxers
musica.pdf amb la partitura en format PED, musica.midi amb la música en format MIDI,
musica.wav amb la música en format WAV, i musica.mp3 amb la música en format MP3.

I al final del programa, es reprodueix la música

## Descripció
Els programes en JSBach es troben constituïts per procediments (sense importar
l'ordre) i, per defecte, es comença pel procediment Main. Si es vol començar per 
un altre procediment, s'ha d'inidicar el nom del procediment juntament amb els seus
paràmetres (si en té) a la hora d'executar el programa.

Els noms dels procediments comencen per una lletra majúscula i es troben entre
|: i :|, els dels variables comencen per una lletra minúscula i les notes comencen 
per una lletra majúscula entre A-G i pot ser seguit d'un número entre 0-8.

L'intèrpret suporta les següents instruccions:
- Assignació (<-): la part dreta és una variable i la part esquerra l'expressió
    que se li vol assignar. 
    Exemple: a <- 2 - 1, a la variable "a" se li assigna
    l'expressió 2 - 1, és a dir, 1.
- Lectura (<?>): aquesta instrucció llegeix un valor enter del canal d'entrada
    i l'emmagatzema a la variable a la dreta de <?>. Exemple: <?> x, llegeix un
    enter del canal d'entrada i l'emmagatzema a la variable "x".
- Escriptura (<!>): rep com a paràmetre una expressió o una llista i l'escriu pel
    canal de sortida. Exemple: <!> "HALLO BACH", escriu pel canal de sortida
    HALLO BACH.
- Reproducció (<:>): rep com a paràmetre una variable o una llista de notes i els 
    afegeix una variable que al final del programa s'obté la partitura i la melodia.
- Condicional if: té la semàntica habitual d'un if.
- Iteració amb while: té la semàntica habitual d'un while.
- Invocació de procediments: s'escriu els nom del procediment seguit dels seus
    paràmetres. Si el procediment no existeix o el nombre de paràmetres no corresponen
    a les del procediment, llavors salta una excepció. Les variables es passen per valor,
    però les llistes per paràmetre.
- Llistes: admet només elements enters i soporta operacions com: la creació de llistes, 
    llargada d'una llista, consulta de l'i-èssim element d'una llista, afegir element al
    final d'una llista i eliminació de l'i-èsim element d'una llista.

De cara a les expressions, poden ser notes, variables o números i admet les operacions 
aritmètics habituals (+, -, *, /, %) i operacions relacionals (=, /=, <, >, <=, >=), que retorna 0
si es fals i 1 si es vertader.

Una variable sense inicialitzar, pren com a valor 0.

Finalment de cara a les notes, només soporta les notes blanques d'un piano.


## Exemples
Programa que reprodueix les notes Hanoi:
~~~ 
Hanoi |:
    src <- {C D E F G}
    dst <- {}
    aux <- {}
    HanoiRec #src src dst aux
:|

HanoiRec n src dst aux |:
    if n > 0 |:
        HanoiRec (n - 1) src aux dst
        note <- src[#src]
        8< src[#src]
        dst << note
        <:> note
        HanoiRec (n - 1) aux dst src
    :|
:|
~~~

Programa que llegeix dos enters i n'escriu el seu maxim comu divisor: 
~~~ 
Main |:
    <!> "Escriu dos nombres"
    <?> a
    <?> b
    Euclides a b
:|

Euclides a b |:
    while a /= b |:
        if a > b |:
            a <- a - b
        :| else |:
            b <- b - a
        :|
    :|
    <!> "El seu MCD es" a
:|
~~~
Procediment que tocaria totes les tecles blanques del piano de més greu a més aguda (d'esquerra a dreta):
~~~
Alle_Schlüssel |:
    note <- A0
    while note <= C8 |:
        <:> note
        note <- note + 1
    :|
:|
~~~ 
## Autor
Jiabo Wang
- email: jiabo.wang@estudiantat.upc.edu 
