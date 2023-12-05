
% ustawienie czasu symulacji
tSim = 10;
global h;
h = 0.01;
t = (0:h:tSim)';

M = 0.5;                                % masa wózka
m = 0.2;                                % masa wahadła
L = 0.3;                                % długość wahadła
b = 0.1;                                % współczynnik tarcia
g = 9.80665;                            % przyspieszenie ziemskie
I = 0.006;                              % moment bezwładności

params = [M, m, L, b, g, I];            % parametry

x0 = 0;                                 % poczatkowe polozenia
x10 = 0;                                % poczatkowa predkosc liniowa
theta0 = 0;                             % poczatkowy kat odchylenia
theta10 = 0;                            % poczatkowa predkosc katowa

state0 = [x0, x10, theta0, theta10];    % warunki poczatkowe


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
O = obsv(system);
RO = rank(O);                           % jeśli 4 to jest obserwowalny
wwA = eig(A);                           % wartości własne macierzy A


%%%%%%%% Obserwator stanu %%%%%%%%%%%


% lambda = [-7; -8; -4; -10];


%%%%% te parametry możemy dobierać %%%%%%
R = 10;
Q = diag([1, 0, 0, 0]);
y = 100;                                  % składowa położenia wózka
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y = [y, 0, 0, 0]';                       % porządane połozenie wózka

% K =  lqr(system, Q, R);                 % rozwiązanie

K = [-6.6845,-51.6047,-9.6527,-10]; % oni podali na sztywno, czy my tez mozemy?
                                    % czy mamy to wyliczac recznie

sim("schemat.slx");


