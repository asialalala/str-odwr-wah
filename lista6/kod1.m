% zakłócenia nieskorelowane

teta = [1,2,3,4];
a1 = teta(1);
a2 = teta(2);
b1 = teta(3);
b2 = teta(4);

lambda = 0.8; % współczynnik wazenia
var = 2;

N = 20; % ilosc prób 
U = rand(N,1);

% warunki poczatkowe
u0 = 0;
um1 = 0;
v0 = 0;
vm1 = 0;
z0 = 0;
y0 = v0 + z0;
ym1 = 0;
ym2 = 0;

P0 = diag([10^3, 10^3, 10^3, 10^3]);
Fi0 = [,ym1,ym2,u0,um1];
Theta0 = [0,0,0,0];

Z = randn(N,1)*var;


% dla n = 1
V(1) = a1*v0 + a2*vm1 + b1*U(1) + b2*u0 ;
Y(1) = V(1) + Z(1);

Fi(1,:) = [y0, ym1, U(1), u0];
P1 = 1/lambda*(P0-(P0*Fi(1,:)'*Fi(1,:)*P0)/(lambda+Fi(1,:)*P0*Fi(1,:)'));
Theta1 = Theta0' + (P1*Fi(1,:)')*(Y(1) - Fi(1,:)*Theta0'); % w wyniku pionowa theta



% dla n = 2
V(2) = a1*V(1) + a2*v0 + b1*U(2) + b2*U(1) ;
Y(2) = V(2) + Z(2);

Fi(2,:) = [Y(1), y0, U(2), U(1)];
P2 = 1/lambda*(P1-(P1*Fi(2,:)'*Fi(2,:)*P1)/(lambda+Fi(2,:)*P1*Fi(2,:)'));

Theta2 = Theta1 + (P1*Fi(1,:)')*(Y(1) - Fi(1,:)*Theta1); % tutaj bez transpozycji bo theta1 jest pionowa

Theta(:,1) = Theta1;
Theta(:,2) = Theta2;
Pstara = P2;
% Paktualna;

for n = 3:N
V(n) = a1*V(n-1) + a2*V(n-2) + b1*U(n) + b2*U(n-1) ;
Y(n) = V(n) + Z(n);

Fi(n,:) = [Y(n-2), Y(n-1), U(n), U(n-1)];

Paktualna = 1/lambda*(Pstara-(Pstara*Fi(2,:)'*Fi(2,:)*Pstara)/(lambda+Fi(2,:)*Pstara*Fi(2,:)'));
Theta(:,n) = Theta(:,n-1) + (Paktualna*Fi(n,:)')*(Y(n) - Fi(n,:)*Theta(:,n-1));
Pstara = Paktualna;
end


% teta 4,1 
% P 4,4 diagonalna macierz z duzymi wartoscimi na poczatku np 10^3

