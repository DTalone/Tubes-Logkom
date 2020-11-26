/* File : store.pl */

:-dynamic(store/1).
:-dynamic(gold/1).
:-dynamic(inStore/1).

gold(0).

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
	store(_),nl,nl,
	write('Kamu sudah berada di store.'),
	!.

store :-
	\+inStore(_),nl,nl,
	write('Kamu masih terlalu jauh dari store.'),
	!.

store :-
	\+store(_),nl,nl,
    	write('Apa yang ingin Anda beli?'),nl,
    	write('1. Gacha (1000 gold)'),nl,
    	write('2. Health Potion S (200 gold)'),nl,
    	write('3. Health Potion M (500 gold)'),nl,
    	write('4. Health Potion L (1000 gold) '),nl,
    	write('5. Enhancer Attack (750 gold)'),nl,	
    	write('6. Enhancer Defense (750 gold)'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,nl,
	write('Masukkan nama item yang ingin dibeli dengan huruf kecil semua dan spasi digantikan dengan \'_\', diakhiri titik'),nl,
	write('(mis : health_potion_s.) '),nl,
	asserta(store(1)),
	!.

gacha :- 
	store(_),
	gold(G),
	G >= 1000,
	Gnew is G - 1000,
	retractall(gold(_)),
	asserta(gold(Gnew)),
	random(1,8,R),
	random_equip(R,Equip),nl,nl,
	write('Pembelian berhasil'),nl,
	write('Kamu mendapatkan equipment : '),
	write(Equip),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	addInventory(Equip),
	!.

gacha :-
	store(_),
	gold(G),
	G < 1000,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	!.

gacha :- 
	\+store(_),nl,nl,
	write('Pemain tidak berada di dalam store.'),nl,
	!.	

health_potion_s :-
	store(_),
	gold(G),
	G >= 200,
	Gnew is G - 200,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	addInventory(health_potion_s),
	!.

health_potion_s :-
	store(_),
	gold(G),
	G < 200,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	!.

health_potion_s :- 
	\+store(_),nl,nl,
	write('Pemain tidak berada di dalam store.'),nl,
	!.

health_potion_m :-
	store(_),
	gold(G),
	G >= 500,
	Gnew is G - 500,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	addInventory(health_potion_m),
	!.

health_potion_m :-
	store(_),
	gold(G),
	G < 500,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,	
	!.

health_potion_m :- 
	\+store(_),nl,nl,
	write('Pemain tidak berada di dalam store.'),nl,
	!.

health_potion_l :-
	store(_),
	gold(G),
	G >= 1000,
	Gnew is G - 1000,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	addInventory(health_potion_l),
	!.

health_potion_l :-
	store(_),
	gold(G),
	G < 1000,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	!.

health_potion_l :- 
	\+store(_),nl,nl,
	write('Pemain tidak berada di dalam store.'),nl,
	!.

enhancer_attack :-
	store(_),
	gold(G),
	G >= 750,
	Gnew is G - 750,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	addInventory(enhancer_attack),
	!.

enhancer_attack :-
	store(_),
	gold(G),
	G < 750,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	!.

enhancer_attack :- 
	\+store(_),nl,nl,
	write('Pemain tidak berada di dalam store.'),nl,
	!.

enhancer_defense :-
	store(_),
	gold(G),
	G >= 750,
	Gnew is G - 750,
	retractall(gold(_)),
	asserta(gold(Gnew)),nl,nl,
	write('Pembelian berhasil'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	addInventory(enhancer_defense),
	!.

enhancer_defense :-
	store(_),
	gold(G),
	G < 750,nl,nl,
	write('Pembelian tidak berhasil, gold tidak cukup.'),nl,nl,
	write('Masukkan \'exitStore.\' untuk keluar dari store.'),nl,
	!.

enhancer_defense :- 
	\+store(_),nl,nl,
	write('Pemain tidak berada di dalam store.'),nl,
	!.

exitStore :-
	\+inStore(_),nl,nl,
	write('Pemain tidak berada di dalam store.'),nl,
	!.

exitStore :-
	store(_),nl,nl,
	write('Terimakasih atas kehadirannya.'),nl,
	retract(store(1)),
	!.