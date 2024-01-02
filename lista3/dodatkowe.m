clear all

% ustawienie czasu symulacji
tSim = 10;
global h;
h = 0.01;
t = (0:h:tSim)';                        % czas wykonywania symulacji
tt = numel(t);                          % ilość iteracji

M = 0.5;                                % masa wózka
m = 0.2;                                % masa wahadła
L = 0.3;                                % długość wahadła
b = 0.1;                                % współczynnik tarcia
g = 9.8;                                % przyspieszenie ziemskie

A = [0,       1,             0, 0;
     0,    -b/M,      (-m*g)/M, 0;
     0,       0,             0, 1;
     0,-b/(M*L),-(m+M)*g/(M*L), 0];     % macierz układu stanu

b = [0, 1/M, 0, 1/(M*L)]';               % macierz sterowania

zero=[0,0,0,0];
C = [1,0,0,0;                        % macierz wyjscia,
    zero;                            % gdy y = x1
    zero;
    zero];                           % macierzy wyjścia
% C = eye(4);                        % w podstawowej wersji, gdy y=x

D = [0, 0, 0,0]';                       % macierz transmisyjna

system = ss(A, b, C, D);                % opis w przestrzeni stanów
S = ctrb(A,b);                          
RS = rank(S);                           % jeśli 4 to jest sterowalny                       
O = obsv(system);
RO = rank(O);                           % jeśli 4 to jest obserwowalny
wwA = eig(A);                           % wartości własne macierzy A


%%%%%%%% Obserwator stanu %%%%%%%%%%%

lambda = [-7; -8; -4; -10];


%%%%% te parametry możemy dobierać %%%%%%
R = 1;
Q = diag([10, 10, 10, 10]);
x0 = [0, 0, 0, 0]';                     % warunek poczatkowy
y = 100;                                  % składowa położenia wózka
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y = [y, 0, 0, 0]';                       % porządane połozenie wózka

K =  lqr(system, Q, R);                 % rozwiązanie

sim("dodatkowa.slx");


