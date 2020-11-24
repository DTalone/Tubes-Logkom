:- dynamic(lebar/1).
:- dynamic(panjang/1).
:- dynamic(wall/4).
:- dynamic(dungeon/2).

initMap:-
    asserta(panjang(11)), 
    asserta(lebar(11)),
    panjang(P),
    lebar(L),
    P1 is P-3,
    L1 is L-3,
    random(6,P1,DX),
    random(6,L1,DY),
    asserta(dungeon(DX,DY)),
    randomizeWall,
    initPlayer.

initPlayer :-
    asserta(posisi(1,1)).

isPlayer(X,Y) :-
    posisi(A,B),
    X =:= A,
    Y =:= B.

isStore(X,Y) :-
    X =:= 2,
    Y =:= 2.

isQuest(X,Y) :-
    X =:= 7,
    Y =:= 3.

isDungeon(X,Y) :-
    dungeon(A,B),
    X =:= A,
    Y =:= B.

isTeleport(X,Y) :-
    X =:= 4,
    Y =:= 8.

isWall(X1,Y1,_,_) :-
    wall(WX1, WY1, _, _),
    WX1 =:= X1,
    WY1 =:= Y1.

isWall(_,_,X2,Y2) :-
    wall(_, _, WX2, WY2),
    WX2 =:= X2,
    WY2 =:= Y2.
    
isBorder(X,_) :-
    X =:= 0.
isBorder(X,_) :-
    panjang(P),
    X =:= P.
isBorder(_,Y) :-
    Y =:= 0.
isBorder(_,Y) :-
    lebar(L),
    Y =:= L.

randomizeWall :-
    lebar(L),
    panjang(P),
    P1 is P-3,
    L1 is L-3,
    random(4,P1,WX1),
    random(4,P1,WX2),
    random(4,L1,WY1),
    random(4,L1,WY2),
    asserta(wall(WX1, WY1, WX2, WY2)).

printMap(X,Y) :-
    panjang(P),
    lebar(L),
    isBorder(X,Y),
    X =:= P,
    Y =:= L,
    write('#').

printMap(X,Y) :-
    panjang(P),
    isBorder(X,Y),
    X =:= P,
    write('#'),nl,
    NextX is 0,
    NextY is Y+1,
    printMap(NextX,NextY).

printMap(X,Y) :-
    isBorder(X,Y),
    write('#'),
    NextX is X+1,
    printMap(NextX,Y).

printMap(X,Y) :-
    isWall(X,Y,X,Y),
    write('#'),
    NextX is (X+1),
    printMap(NextX,Y).

printMap(X,Y) :-
    isPlayer(X,Y),
    write('P'),
    NextX is (X+1),
    printMap(NextX,Y).

printMap(X,Y) :-
    isStore(X,Y),
    write('S'),
    NextX is (X+1),
    printMap(NextX,Y).

printMap(X,Y) :-
    isQuest(X,Y),
    write('Q'),
    NextX is (X+1),
    printMap(NextX,Y).

printMap(X,Y) :-
    isDungeon(X,Y),
    write('D'),
    NextX is (X+1),
    printMap(NextX,Y).

printMap(X,Y) :-
    isTeleport(X,Y),
    write('T'),
    NextX is (X+1),
    printMap(NextX,Y).

printMap(X,Y) :-
    \+isBorder(X,Y),
    write('-'),
    NextX is (X+1),
    printMap(NextX,Y).

map :- 
    running(_),
    printMap(0,0),!.