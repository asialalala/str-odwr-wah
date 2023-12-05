% oblicza wartosci stanu systemu sys
% przypisuje wartosci poczatkowe do init


function [ sys, init ] = MySystem(t, state, u, state0, params)
    
    % parametry
    M = params(1); % masa wozka
    m = params(2); % masa wahadla
    L = params(3); % dlugosc od mocowania do srodka ciezkosci wahadla
    b = params(4); % wspolczynnik tarcia wozka
    g = params(5); % przyspieszenie ziemskie
    I = params(7); % moment bezwladnosci wahadla

    % wejscie
    F = u(1);      % sila przylozona do wozka 

    % zainicjalizowanie wartosci stanow
    x = state(1);
    x1 = state(2);
    theta = state(3);
    theta1 = state(4);

    % potrzebne wartosci
    cT = cos(theta);
    sT = sin(theta);
    q = m^2 * L^2 * cT^2 - (M + m)*(I + m*L^2);

    % przypisanie wartosci poczatkowych
    init = state0;

    % oblizcenie wartosci stanow
    sys(1) = x;
    sys(2) = (F * m * L * cT - b * m * L * cT * x1 - (M + m) * m * L * g * sT + m^2 * L^2 * sT * cT * theta1^2) / q;
    sys(3) = theta;
    sys(4) = ((I + m * L^2) * (-F + b * x1 - m * L * sT * theta1^2) + m^2 * L^2 * g * sT * cT) / q;


end