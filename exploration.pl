/* File untuk eksplorasi */
:- dynamic(inQuest/1).
:- dynamic(teleport/1).
:- dynamic(dungeon/1).

w :-
    running(_),
    \+round(_),
    posisi(A,B),
    isWall(A,B-1,A,B-1),
    write('Nabrak'),nl,
    !.

w :-
    running(_),
    \+round(_),
    posisi(A,B),
    isBorder(A,B-1),
    write('Nabrak'),nl,
    !.

w :-
    running(_),
    \+round(_),
    posisi(A,B),
    isStore(A,B-1),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    asserta(store(1)),
    write('Anda berada di Store'),
    !.

w :-
    running(_),
    \+round(_),
    posisi(A,B),
    isQuest(A,B-1),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    asserta(inQuest(1)),
    write('Anda berada di Quest'),
    !.

w :-
    running(_),
    \+round(_),
    posisi(A,B),
    isDungeon(A,B-1),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    asserta(dungeon(1)),
    write('Anda berada di Dungeon'),
    !.

w :-
    running(_),
    \+round(_),
    posisi(A,B),
    isTeleport(A,B-1),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    asserta(teleport(1)),
    write('Anda berada di Teleport'),
    !.

w :-
    running(_),
    \+round(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    randomEncounter.

a :-
    running(_),
    \+round(_),
    posisi(A,B),
    isBorder(A-1,B),
    write('Nabrak'),
    !.

a :-
    running(_),
    \+round(_),
    posisi(A,B),
    isWall(A-1,B,A-1,B),
    write('Nabrak'),nl,
    !.

a :-
    running(_),
    \+round(_),
    posisi(A,B),
    isStore(A-1,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    asserta(store(1)),
    write('Anda berada di Store'),
    !.

a :-
    running(_),
    \+round(_),
    posisi(A,B),
    isQuest(A-1,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    asserta(inQuest(1)),
    write('Anda berada di Quest'),
    !.

a :-
    running(_),
    \+round(_),
    posisi(A,B),
    isDungeon(A-1,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    asserta(dungeon(1)),
    write('Anda berada di Dungeon'),
    !.

a :-
    running(_),
    \+round(_),
    posisi(A,B),
    isTeleport(A-1,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    asserta(teleport(1)),
    write('Anda berada di Teleport'),
    !.

a :-
    running(_),
    \+round(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    randomEncounter.

s :-
    running(_),
    \+round(_),
    posisi(A,B),
    isBorder(A,B+1),
    write('Nabrak'),
    !.

s :-
    running(_),
    \+round(_),
    posisi(A,B),
    isWall(A,B+1,A,B+1),
    write('Nabrak'),nl,
    !.

s :-
    running(_),
    \+round(_),
    posisi(A,B),
    isStore(A,B+1),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    asserta(store(1)),
    write('Anda berada di Store'),
    !.

s :-
    running(_),
    \+round(_),
    posisi(A,B),
    isQuest(A,B+1),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    asserta(inQuest(1)),
    write('Anda berada di Quest'),
    !.

s :-
    running(_),
    \+round(_),
    posisi(A,B),
    isDungeon(A,B+1),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    asserta(dungeon(1)),
    write('Anda berada di Dungeon'),
    !.

s :-
    running(_),
    \+round(_),
    posisi(A,B),
    isTeleport(A,B+1),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    asserta(teleport(1)),
    write('Anda berada di Teleport'),
    !.

s :-
    running(_),
    \+round(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    randomEncounter.

d :-
    running(_),
    \+round(_),
    posisi(A,B),
    isBorder(A+1,B),
    write('Nabrak'),
    !.

d :-
    running(_),
    \+round(_),
    posisi(A,B),
    isWall(A+1,B,A+1,B),
    write('Nabrak'),nl,
    !.

d :-
    running(_),
    \+round(_),
    posisi(A,B),
    isStore(A+1,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    asserta(store(1)),
    write('Anda berada di Store'),
    !.

d :-
    running(_),
    \+round(_),
    posisi(A,B),
    isQuest(A+1,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    asserta(inQuest(1)),
    write('Anda berada di Quest'),
    !.

d :-
    running(_),
    \+round(_),
    posisi(A,B),
    isDungeon(A+1,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    asserta(inQuest(1)),
    write('Anda berada di Dungeon'),
    !.

d :-
    running(_),
    \+round(_),
    posisi(A,B),
    isTeleport(A+1,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    asserta(teleport(1)),
    write('Anda berada di Teleport'),
    !.

d :-
    running(_),
    \+round(_),
    posisi(A,B),
    cekArea(A,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    randomEncounter.

randomEncounter :-
    running(_),
    \+round(_),
    random(1,100,Encounter),
    (
        Encounter < 15 -> 
        randomEnemy
        ; !
    ).

randomEnemy :-
    random(1,6,EnemyID),
    (
        EnemyID =:= 1 -> 
        battle(slime)
    ;   EnemyID =:= 2 ->
        battle(goblin)
    ;   EnemyID =:= 3 ->
        battle(wolf)
    ;   EnemyID =:= 4 ->
        battle(golem)
    ;   EnemyID =:= 5 ->
        battle(wizard)
    ).

teleport :-
    running(_),
    \+teleport(_),
	write('Pemain tidak berada di tempat teleport.'),nl,
    !.

teleport :-
    running(_),
    teleport(_),
    panjang(P),
    lebar(L),
    write('Kemana kamu akan teleport? (Pemain hanya dapat Teleport ke area kosong)'),nl,
    write('Posisi X: '),
    read(TpX), TpX > -1, TpX < P,
    write('Posisi Y: '),
    read(TpY), TpY > -1, TpY < L,
    cekArea(TpX,TpY),
    retract(posisi(_,_)),
    asserta(posisi(TpX,TpY)),
    write('Anda telah diteleport ke koordinat ('), write(TpX), write(','), write(TpY), write(')'),
    retract(teleport(_)).

cekArea(X,Y) :-
    /* Mengecek posisi X,Y bukan area yang terisi dengan wall, dungeoon, store, quest, border, teleport */
    \+isWall(X,Y,X,Y),
    \+isDungeon(X,Y),
    \+isTeleport(X,Y),
    \+isStore(X,Y),
    \+isQuest(X,Y),
    \+isBorder(X,Y).