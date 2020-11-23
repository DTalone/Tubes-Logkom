/* File : store.pl */

:- dynamic(store/1).

price(gacha,1000).
price(health_potion_s,200).
price(health_potion_m,500).
price(health_potion_l,1000).
price(enhancer_attack,750).
price(enhancer_defense,750).
price(freeze_potion,1000).

random_equip(1,crossbow).
random_equip(2,longbow).
random_equip(3,haedonggum).
random_equip(4,flamberge).
random_equip(5,magic_staff).
random_equip(6,lighter_armor).
random_equip(7,heavy_armor).
random_equip(8,magic_robe).

store :-
	store(_),
	/*isStore(true),*/
	write('Kamu sudah berada di store.'),
	!.

store :-
	\+store(_),
	/*isStore(true),*/
	write('                                '),nl,
    	write('                                '),nl,
    	write('Apa yang ingin Anda beli?'),nl,
    	write('1. Gacha (1000 gold)'),nl,
    	write('2. Health Potion S (200 gold)'),nl,
    	write('3. Health Potion M (500 gold)'),nl,
    	write('4. Health Potion L (1000 gold) '),nl,
    	write('5. Enhancer Attack (750 gold)'),nl,	
    	write('6. Enhancer Defense (750 gold)'),nl,
    	write('7. Freeze Potion (1000 gold)'),nl,
	asserta(store(1)),
	!.

gacha :- 
	store(_),
	random(1,8,R),
	random_equip(R,Equip),
	write('Kamu mendapatkan equipment : '),
	write(Equip),nl,
	!.

gacha :- 
	\+store(_),
	write('Pemain tidak berada di dalam store.'),nl,
	!.	

exitStore :-
	\+store(_),
	write('Pemain tidak berada di dalam store.'),nl,
	!.

exitStore :-
	store(_),
	write('Terimakasih atas kehadirannya.'),nl,
	retract(store(1)),
	!.