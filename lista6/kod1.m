% zakłócenia nieskorelowane

teta = [1,2,3,4];
a1 = teta(1);
a2 = teta(2);
b1 = teta(3);
b2 = teta(4);

lambd = 0.8; % współczynnik wazenia
var = 2;

N = 20; % ilosc prób 
U = rand(N,1);
u0 = 0;
v0 = 0;
vm1 = 0;

Z = randn(N,1)*var;

% dla n = 1
V(1) = a1*v0 + a2*vm1 + b1*U(1) + b2*u0 ;
Y(1) = V(1) + Z(1);

% dla n = 2
V(2) = a1*V(1) + a2*v0 + b1*U(2) + b2*U(1) ;
Y(2) = V(2) + Z(2);


for n = 3:N
V(n) = a1*V(n-1) + a2*V(n-2) + b1*U(n) + b2*U(n-1) ;
Y(n) = V(n) + Z(n);
end


