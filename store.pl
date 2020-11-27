/* File : store.pl */

:-dynamic(inStore/1).

price(gacha,1000).
price(health_potion_s,200).
price(health_potion_m,500).
price(health_potion_l,1000).
price(enhancer_attack,750).
price(enhancer_defense,750).

random_equip(1,crossbow).
random_equip(2,longbow).
random_equip(3,haedonggum).
random_equip(4,flamberge).
random_equip(5,magic_staff).
random_equip(6,lighter_armor).
random_equip(7,heavy_armor).
random_equip(8,magic_robe).

store :-
	running(_),
	\+inStore(_),nl,nl,
	write('Kamu masih terlalu jauh dari store.'),
	!.

store :-
	running(_),
	inStore(_),
	nl,nl,
	write('##################  STORE  ##################'),nl,
    	write('# 1. Gacha (1000 gold)                      #'),nl,
    	write('# 2. Health Potion S (200 gold)             #'),nl,
    	write('# 3. Health Potion M (500 gold)             #'),nl,
    	write('# 4. Health Potion L (1000 gold)            #'),nl,
    	write('# 5. Enhancer Attack (750 gold)             #'),nl,
    	write('# 6. Enhancer Defense (750 gold)            #'),nl,
	write('# 7. Keluar                                 #'),nl,
	write('#                                           #'),nl,
	write('# Apa yang ingin Anda beli?                 #'),nl,
	write('#                                           #'),nl,
	write('#############################################'),nl,nl,
	write('Masukkan angka : '),read(X),
       	(X =:= 1 -> gacha
        ;X =:= 2 -> health_potion_s
        ;X =:= 3 -> health_potion_m
        ;X =:= 4 -> health_potion_l
        ;X =:= 5 -> enhancer_attack
        ;X =:= 6 -> enhancer_defense
	;X =:= 7 -> exitStore),
	!.

gacha :-
	gold(G),
	G >= 1000,
	Gnew is G - 1000,
	retractall(gold(_)),
	asserta(gold(Gnew)),
	random(1,8,R),
	random_equip(R,Equip),nl,nl,
	write('Pembelian berhasil'),nl,
	write('Kamu mendapatkan equipment : '),
	write(Equip),nl,
	addInventory(Equip),nl,nl,
	!.

gacha :-
	gold(G),
	G < 1000,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	!.

health_potion_s :-
	gold(G),
	G >= 200,
	Gnew is G - 200,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,
	addInventory(health_potion_s),nl,nl,
	!.

health_potion_s :-
	gold(G),
	G < 200,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	!.

health_potion_m :-
	gold(G),
	G >= 500,
	Gnew is G - 500,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,
	addInventory(health_potion_m),nl,nl,
	!.

health_potion_m :-
	gold(G),
	G < 500,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	!.

health_potion_l :-
	gold(G),
	G >= 1000,
	Gnew is G - 1000,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,
	addInventory(health_potion_l),nl,nl,
	!.

health_potion_l :-
	gold(G),
	G < 1000,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	!.

enhancer_attack :-
	gold(G),
	G >= 750,
	Gnew is G - 750,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,
	addInventory(enhancer_attack),nl,nl,
	!.

enhancer_attack :-
	gold(G),
	G < 750,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	!.

enhancer_defense :-
	gold(G),
	G >= 750,
	Gnew is G - 750,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,nl,
	addInventory(enhancer_defense),nl,nl,
	!.

enhancer_defense :-
	gold(G),
	G < 750,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	!.

exitStore :-
	\+inStore(_),nl,nl,
	write('Pemain tidak berada di dalam store.'),nl,
	!.

exitStore :-
	inStore(_),nl,nl,
	write('Terimakasih atas kehadirannya.'),nl,
	!.
