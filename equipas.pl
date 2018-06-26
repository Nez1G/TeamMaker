:-[funcoes,hillclimbing].

%Os valores de empatia e antipatia que se atribuem às relações são 1 e -1.5 respetivamente
%As pessoas disponiveis para serem criadas as duas equipas são: joao, matilde, tiago, hugo, ana, carlos, maria, antonio.

relacao(joao, matilde, -1.5).
relacao(matilde, joao, 1).
relacao(joao, tiago, -1.5).
relacao(tiago, joao, 1).
relacao(joao, hugo, -1.5).
relacao(hugo, joao, 1).
relacao(joao, ana, -1.5).
relacao(ana, joao, 1).
relacao(joao, carlos, -1.5).
relacao(carlos, joao, 1).
relacao(joao, maria, 1).
relacao(maria, joao, 1).
relacao(joao, antonio, 1).
relacao(antonio, joao, 1).
relacao(matilde, tiago, -1.5).
relacao(tiago, matilde, 1).
relacao(matilde, hugo, -1.5).
relacao(hugo, matilde, 1).
relacao(matilde, ana, -1.5).
relacao(ana, matilde, 1).
relacao(matilde, carlos, -1.5).
relacao(carlos, matilde, 1).
relacao(matilde, maria, 1).
relacao(maria, matilde, 1).
relacao(matilde, antonio, -1.5).
relacao(antonio, matilde, 1).
relacao(tiago, hugo, 1).
relacao(hugo, tiago, 1).
relacao(tiago, ana, 1).
relacao(ana, tiago, -1.5).
relacao(tiago, carlos, 1).
relacao(carlos, tiago, -1.5).
relacao(tiago, maria, 1).
relacao(maria, tiago, 1).
relacao(tiago, antonio, 1).
relacao(antonio, tiago, -1.5).
relacao(hugo, ana, 1).
relacao(ana, hugo, 1).
relacao(hugo, carlos, -1.5).
relacao(carlos, hugo, 1).
relacao(hugo, maria, -1.5).
relacao(maria, hugo, 1).
relacao(hugo, antonio, 1).
relacao(antonio, hugo, 1).
relacao(ana, carlos, 1).
relacao(carlos, ana, -1.5).
relacao(ana, maria, 1).
relacao(maria, ana, 1).
relacao(ana, antonio, -1.5).
relacao(antonio, ana, 1).
relacao(carlos, maria, -1.5).
relacao(maria, carlos, 1).
relacao(carlos, antonio, 1).
relacao(antonio, carlos, 1).
relacao(maria, antonio, 1).
relacao(antonio, maria, -1.5).

relacao(X,Y,D):- relacao(Y,X,D),!.

eval(S1,Res):-
	deconcat(S1,V1,V2),
	calcTeam(V1,F1),
	calcTeam(V2,F2),
	sum_list([F1,F2], Result),
	(Res = Result).

change(S1,S2):-
length(S1,L),
random_between(1,L,P1),
change(S1,P1,L,S2).

change(S1,P1,L,S2):- 
P1>2, P1<L, 
nth1(P1,S1,Rel1),
P2 is P1-1,
nth1(P2,S1,Rel2),
replace_list(S1,P1,Rel2,S11),
replace_list(S11,P2,Rel1,S2).

change(S1,1,L,S2):- 
P2 is L-1, 
nth1(1,S1,Rel1),
nth1(P2,S1,Rel2),
replace_list(S1,1,Rel2,S11),
replace_list(S11,P2,Rel1,S12),
replace_list(S12,L,Rel2,S2). 

change(S1,2,L,S2):- 
P2 is 1, 
nth1(2,S1,Rel1),
nth1(P2,S1,Rel2),
replace_list(S1,2,Rel2,S11),
replace_list(S11,P2,Rel1,S12),
replace_list(S12,L,Rel1,S2).

change(S1,L,L,S2):- 
P2 is L-1,
nth1(L,S1,Rel1),
nth1(P2,S1,Rel2),
replace_list(S1,L,Rel2,S11),
replace_list(S11,P2,Rel1,S12),
replace_list(S12,1,Rel2,S2). 

:- set_random(seed(12345)).

concat([W,X,Y,Z],[A,B,C,D],S):-
	(S = ([W,X,Y,Z,A,B,C,D,X])). 

deconcat([W,X,Y,Z,A,B,C,D,K],S1,S2):-
	(S1 = [W,X,Y,Z]),
	(S2 = [A,B,C,D]).

calcTeam([W,X,Y,Z],RES):-
	( relacao(X,Y,W1) -> Var1 = W1),
	( relacao(X,Z,W2) -> Var2 = W2),
	( relacao(Y,X,W3) -> Var3 = W3),
	( relacao(Y,Z,W4) -> Var4 = W4),
	( relacao(Z,Y,W5) -> Var5 = W5),
	( relacao(Z,X,W6) -> Var6 = W6),
    ( relacao(W,X,W7) -> Var7 = W7),
    ( relacao(W,Y,W8) -> Var8 = W8),
    ( relacao(W,Z,W9) -> Var9 = W9),
    ( relacao(X,W,W10) -> Var10 = W10),
    ( relacao(Y,W,W11) -> Var11 = W11),
    ( relacao(Z,W,W12) -> Var12 = W12),
	( sum_list([Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8,Var9,Var10,Var11,Var12],VarF)),
	( RES = VarF ).

i1([joao,matilde,tiago,hugo]).
i2([ana,carlos,maria,antonio]).

gerarEquipas(S,Rel):- 
i1(I1),
i2(I2), 
concat(I1,I2,S0),
time(hill_climbing(S0,[10000,200,0,max],S)),
eval(S,Rel). 

gerarEquipasTeste(S,Rel):- 
i1(I1),
i2(I2), 
concat(I1,I2,S0),
time(hill_climbing(S0,[20,1,3,max],S)),
eval(S,Rel).



