% oblicza wartosci stanu systemu sys
% przypisuje wartosci poczatkowe do init

% s-funkcja dla modelu wahadla
% t - aktualna wartosc czasu
% state - wektor stanu
% u - wejscie obiektu
% flag - zmienna przechowujaca stan symulacji s-funkcji
% i teraz parametry dodatkowe
% state0 - wektor stanu poczatkowego
% params - parametry wahadla

function [ sys,init,str,ts ] = NonLinearSystem(t,state,u,flag,state0, params)
        
        switch flag
            case 0
                s = simsizes;
                s.NumContStates  = 4;  
                s.NumDiscStates  = 0;
                s.NumOutputs     = 4;   
                s.NumInputs      = 1;   
                s.DirFeedthrough = 0;
                s.NumSampleTimes = 1; 
                sys = simsizes(s);

                str = [];
                ts = [0 0]; 
                init = state0;
            case 1    
                stateDot = stateEquation(state,params,u);
                sys = stateDot;
            case 3
                sys = state; % wyjsciem jest pochodna stan     
            case {2,4,9}
                sys = []; 
            otherwise
                error(['unhandled flag = ',num2str(flag)]);
        end
         
end