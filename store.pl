/* File : store.pl */

price(gacha,1000).
price(health_potion_s,200).
price(health_potion_m,500).
price(health_potion_l,1000).
price(enhancer_attack,750).
price(enhancer_defense,750).
price(freeze_potion,1000).

store :-
	isStore(true),
	write('                                '),nl,
    	write('                                '),nl,
    	write('What do you want to buy?'),nl,
    	write('1. Gacha (1000 gold)'),nl,
    	write('2. Health Potion S (200 gold)'),nl,
    	write('3. Health Potion M (500 gold)'),nl,
    	write('4. Health Potion L (1000 gold) '),nl,
    	write('5. Enhancer Attack (750 gold)'),nl,
    	write('6. Enhancer Defense (750 gold)'),nl,
    	write('7. Freeze Potion (1000 gold)'),nl.

store :-
	isStore(false), !,
	write('Sorry, you are too far from the store.'),nl,
	write('Please go to the store.'),nl.

isEnough(Y) :-
	X is Y,
	price(X,P),
	P<=money.

gacha :- 
	isEnough(gacha),
	/*random*/
	
health_potion_s :- 
	isEnough(health_potion_s),
	addInventory(health_potion_s).	

health_potion_m :-
	isEnough(health_potion_m),
	addInventory(health_potion_m).

health_potion_l :-
	isEnough(health_potion_l),
	addInventory(health_potion_l).

enhancer_attack :-
	isEnough(enhancer_attack),
	addInventory(enhancer_attack).

enhancer_defense :-
	isEnough(enhancer_defense),
	addInventory(enhancer_defense).

freeze_potion :-
	isEnough(freeze_potion),
	addInventory(freeze_potion).

exitStore :-
	isStore(false),
	write('Player not in the store.'),nl.

exitStore :-
	isStore(true),
	write('Thanks for coming.'),nl.