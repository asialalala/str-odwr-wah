% Obliczenie pochodnej stanów z równań nieliniowych

function [stateDot] = stateEquation (state, params, u)

     % parametry
     M = params(1); % masa wozka
     m = params(2); % masa wahadla
     L = params(3); % dlugosc od mocowania do srodka ciezkosci wahadla
     b = params(4); % wspolczynnik tarcia wozka
     g = params(5); % przyspieszenie ziemskie
     I = params(6); % moment bezwladnosci wahadla

     % wejscie
     F = u(1);      % sila przylozona do wozka    

     % zainicjalizowanie wartosci stanow
     x = state(1);
     xDot = state(2);
     theta = state(3);
     thetaDot = state(4);


     % potrzebne wartosci
     cT = cos(theta);
     sT = sin(theta);
     q = m^2 * L^2 * cT^2 - (M + m)*(I + m*L^2);

     % oblizcenie wartosci stanow
     stateDot(1) = x;
     stateDot(2) = (F * m * L * cT - b * m * L * cT * xDot - (M + m) * m * L * g * sT + m^2 * L^2 * sT * cT * thetaDot^2) / q;
     stateDot(3) = theta;
     stateDot(4) = ((I + m * L^2) * (-F + b * xDot - m * L * sT * thetaDot^2) + m^2 * L^2 * g * sT * cT) / q;

end