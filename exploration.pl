/* File untuk eksplorasi */
w :-
    running(_),
    posisi(A,B),
    isWall(A,B-1,A,B-1,A,B-1,A,B-1,A,B-1,A,B-1,A,B-1,A,B-1,A,B-1,A,B-1),
    write('Nabrak'),nl,
    !.

w :-
    running(_),
    posisi(A,B),
    isBorder(A,B-1),
    write('Nabrak'),nl,
    !.

w :-
    running(_),
    posisi(A,B),
    isStore(A,B-1),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    write('Anda berada di Store'),
    !.

w :-
    running(_),
    posisi(A,B),
    isQuest(A,B-1),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    write('Anda berada di Quest'),
    !.

w :-
    running(_),
    posisi(A,B),
    isDungeon(A,B-1),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    write('Anda berada di Dungeon'),
    !.

w :-
    running(_),
    posisi(A,B),
    isTeleport(A,B-1),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)),
    write('Anda berada di Teleport'),
    !.

w :-
    running(_),
    posisi(A,B),
    retract(posisi(A,B)),
    asserta(posisi(A,B-1)).

a :-
    running(_),
    posisi(A,B),
    isBorder(A-1,B),
    write('Nabrak'),
    !.

a :-
    running(_),
    posisi(A,B),
    isWall(A-1,B,A-1,B,A-1,B,A-1,B,A-1,B,A-1,B,A-1,B,A-1,B,A-1,B,A-1,B),
    write('Nabrak'),nl,
    !.

a :-
    running(_),
    posisi(A,B),
    isStore(A-1,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    write('Anda berada di Store'),
    !.

a :-
    running(_),
    posisi(A,B),
    isQuest(A-1,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    map,nl,
    write('Anda berada di Quest'),
    !.

a :-
    running(_),
    posisi(A,B),
    isDungeon(A-1,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    write('Anda berada di Dungeon'),
    !.

a :-
    running(_),
    posisi(A,B),
    isTeleport(A-1,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)),
    write('Anda berada di Teleport'),
    !.

a :-
    running(_),
    posisi(A,B),
    retract(posisi(A,B)),
    asserta(posisi(A-1,B)).

s :-
    running(_),
    posisi(A,B),
    isBorder(A,B+1),
    write('Nabrak'),
    !.

s :-
    running(_),
    posisi(A,B),
    isWall(A,B+1,A,B+1,A,B+1,A,B+1,A,B+1,A,B+1,A,B+1,A,B+1,A,B+1,A,B+1),
    write('Nabrak'),nl,
    !.

s :-
    running(_),
    posisi(A,B),
    isStore(A,B+1),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    write('Anda berada di Store'),
    !.

s :-
    running(_),
    posisi(A,B),
    isQuest(A,B+1),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    write('Anda berada di Quest'),
    !.

s :-
    running(_),
    posisi(A,B),
    isDungeon(A,B+1),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    write('Anda berada di Dungeon'),
    !.

s :-
    running(_),
    posisi(A,B),
    isTeleport(A,B+1),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)),
    write('Anda berada di Teleport'),
    !.

s :-
    running(_),
    posisi(A,B),
    retract(posisi(A,B)),
    asserta(posisi(A,B+1)).

d :-
    running(_),
    posisi(A,B),
    isBorder(A+1,B),
    write('Nabrak'),
    !.

d :-
    running(_),
    posisi(A,B),
    isWall(A+1,B,A+1,B,A+1,B,A+1,B,A+1,B,A+1,B,A+1,B,A+1,B,A+1,B,A+1,B),
    write('Nabrak'),nl,
    !.

d :-
    running(_),
    posisi(A,B),
    isStore(A+1,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    write('Anda berada di Store'),
    !.

d :-
    running(_),
    posisi(A,B),
    isQuest(A+1,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    write('Anda berada di Quest'),
    !.

d :-
    running(_),
    posisi(A,B),
    isDungeon(A+1,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    write('Anda berada di Dungeon'),
    !.

d :-
    running(_),
    posisi(A,B),
    isTeleport(A+1,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)),
    write('Anda berada di Teleport'),
    !.

d :-
    running(_),
    posisi(A,B),
    retract(posisi(A,B)),
    asserta(posisi(A+1,B)).