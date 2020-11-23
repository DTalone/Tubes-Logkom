:- dynamic(lebar/1).
:- dynamic(panjang/1).
:- dynamic(wall/20).
:- dynamic(dungeon/2).

initMap:-
    asserta(panjang(19)),
    asserta(lebar(19)),
    panjang(P),
    lebar(L),
    P1 is P-3,
    L1 is L-3,
    random(10,P1,DX),
    random(10,L1,DY),
    asserta(dungeon(DX,DY)).

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
    Y =:= 9.

isWall(X1,Y1,X2,Y2,X3,Y3,X4,Y4,X5,Y5,X6,Y6,X7,Y7,X8,Y8,X9,Y9,X10,Y10) :-
    wall(WX1, WY1, WX2, WY2, WX3, WY3, WX4, WY4, WX5, WY5, WX6, WY6, WX7, WY7, WX8, WY8, WX9, WY9, WX10, WY10),
    (
        (
            X1 == WX1,
            Y1 == WY1
        );
        (
            X2 == WX2,
            Y2 == WY2
        );
        (
            X3 == WX3,
            Y3 == WY3
        );
        (
            X4 == WX4,
            Y4 == WY4
        ); 
        (   
            X5 == WX5,
            Y5 == WY5
        );
        (
            X6 == WX6,
            Y6 == WY6
        );
        (   
            X7 == WX7,
            Y7 == WY7
        );
        (   
            X8 == WX8,
            Y8 == WY8
        );
        (   
            X9 == WX9,
            Y9 == WY9
        );
        (   
            X10 == WX10,
            Y10 == WY10
        )
    ).

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
    P1 is P-2,
    L1 is L-2,
    random(4,P1,WX1),
    random(4,P1,WX2),
    random(4,P1,WX3),
    random(4,P1,WX4),
    random(4,P1,WX5),
    random(4,P1,WX6),
    random(4,P1,WX7),
    random(4,P1,WX8),
    random(4,P1,WX9),
    random(4,P1,WX10),
    random(4,L1,WY1),
    random(4,L1,WY2),
    random(4,L1,WY3),
    random(4,L1,WY4),
    random(4,L1,WY5),
    random(4,L1,WY6),
    random(4,L1,WY7),
    random(4,L1,WY8),
    random(4,L1,WY9),
    random(4,L1,WY10),
    asserta(wall(WX1, WY1, WX2, WY2, WX3, WY3, WX4, WY4, WX5, WY5, WX6, WY6, WX7, WY7, WX8, WY8, WX9, WY9, WX10, WY10)).

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
    isWall(X,Y,X,Y,X,Y,X,Y,X,Y,X,Y,X,Y,X,Y,X,Y,X,Y),
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