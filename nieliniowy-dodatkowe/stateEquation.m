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
     cTheta = cos(theta);
     sTheta = sin(theta);
     q = m^2 * L^2 * cTheta^2 - (I + m * L^2) * (M + m);

     % oblizcenie wartosci stanow
     stateDot(1) = x;
     stateDot(2) = (F * m * L * cTheta - b * m * L * cTheta * xDot - (M + m) * m * L * g * sTheta + m^2 * L^2 * sTheta * cTheta * thetaDot^2) / q;
     stateDot(3) = theta;
     stateDot(4) = ((I + m * L^2) * (-F + b * xDot - m * L * sTheta * thetaDot^2) + m^2 * L^2 * g * sTheta * cTheta) / q % gdy tu damy srednik - przestaje dzialac, czy to dobrze liczy?
end