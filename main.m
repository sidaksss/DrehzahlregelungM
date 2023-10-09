%Kommentar
clc;                   % Kommandozeile löschen
clear all;             % alle Parameter löschen
close all;             % alle Fenster schließen

% Gegebene Parameter
params.a0 = 0.125;
params.a1 = 8;
params.K0 = 0.125;
params.K1 = 6;
params.Kp = 1.1;
params.Kv = 4.2;

% -------------------------------------------------------------------------
% Teilaufgaben b) + c)

% Zeitspanne
tspan = [0 5];

% Anfangswerte
y0 = [0; 0];

disp('Berechnungsdauer mit ode15s, Aufgabe b,c:')
tic
% Lösen der DGL mit ode15s
[t1, y1] = ode15s(@(t, y) Innerer_Regelkreis(t, y, params, @Isoll, @Isolldot), tspan, y0);
toc 
fprintf('\n')

disp('Berechnungsdauer mit dem Euler-Verfahren, Aufgabe b,c:')
tic
% Lösen der DGL mit Euler-Verfahren (Nutzung des gleichen Zeitvektors wie bei ode15s)
[t2, y2] = Vorwaerts_Euler(@(t, y) Innerer_Regelkreis(t, y, params, @Isoll, @Isolldot), t1, y0);
toc
fprintf('\n')

% Plotten der Ergebnisse
figure();
sgtitle("Innerer Regelkreis");
ylabels = {"Stromstaerke I in mA", "Stromstaerkeaenderungsrate I' in mA/s"};
for k=1:2
    subplot(1,2,k)
    xlabel('Zeit t in s');
    ylabel(ylabels{k});
    hold on
    plot(t1, y1(:, k),'r');
    plot(t2, y2(:, k),'b');
    legend('ode15s', 'Euler-Verfahren');
    hold off
end


% -------------------------------------------------------------------------
% Teilaufgabe d) 
% Trapezregel

I_b = y2(:, 1);      % Funktion I_b,  y2(:, 1) -> Nutzung der gesammten 
                     % Werte der ersten Zeile der y2 Funktion (152)
                     % 2 Zeilen gegeben, brauchen nur die erste Zeile und alle Spalten dieser
                                              
I_c = y1(:, 1);      % gleiches gillt für I_c

% Funktion: 
E = (I_b - I_c).^2;  % Bildung der quadratischen Differenz der Ergebnisse von Aufgabe b und c

% Integration mit Trapezregel
Differenz_mit_Trapez_d = trapz(t1,E);  % Ermittlung des Integrals der quadratischen Differenz mit Hilfe der Trapezregel

disp(['Die quadratische integrale Differenz des Euler-Verfahrens und ode15s in Aufgabe d betraegt ', num2str(Differenz_mit_Trapez_d)])
fprintf('\n')



% -------------------------------------------------------------------------
% Teilaufgabe e)

% Anfangswerte
y0 = [0; 0];

% Löse die DGL
[t3, y3] = ode15s(@(t,y) Erweitertes_System(t, y, params, @Isoll, @Isolldot), tspan, y0);

% Plotten der Ergebnisse
figure();
sgtitle("Erweitertes System");
ylabels = {"Drehzahlaenderungsrate V' in U/min^2", "V'' in U/min^3"};
for k=1:2
    subplot(1,2,k)
    xlabel('Zeit t in s');
    ylabel(ylabels{k});
    hold on
    plot(t3, y3(:, k),'r');
    hold off
end




% -------------------------------------------------------------------------
% Teilaufgabe h)

% Anfangswerte
y0 = [0; 0; 0];

disp('Berechnungsdauer mit ode15s, Aufgabe h:')
tic
% Löse die DGL
[t4, y4] = ode15s(@(t, y) Komplettes_System(t, y, params, @Vsoll, @Vsolldot), tspan, y0);
toc
fprintf('\n')

disp('Berechnungsdauer mit dem Euler-Verfahren, Aufgabe h:')
tic
% Löse die DGL mit Vorwaertseuler (in den gleichen Zeitpunkten wie ode15s)
[t5, y5] = Vorwaerts_Euler(@(t, y) Komplettes_System(t, y, params, @Vsoll, @Vsolldot), t4, y0);
toc
fprintf('\n')

% Trapezregel vergleich:
V_h_euler = y5(:, 1);                                                    
V_h_ode15s = y4(:, 1);    

% Funktion: 
V = (V_h_euler - V_h_ode15s).^2;   % Funktion, mit der Zwischen ode15s und Euler-Verfahren verglichen werden soll

% Integration mit Trapezregel
Differenz_mit_Trapez_h = trapz(t4,V);  % Ergebnis der Differenz 

disp(['Die quadratische integrale Differenz des Euler-Verfahrens und ode15s in Aufgabe h betraegt ', num2str(Differenz_mit_Trapez_h)])


% Plotten der Ergebnisse
figure();
sgtitle("komplettes System");
ylabels = {"Drehzahl V in U/min", "Drehzahlaenderungsrate V' in U/min^2", "V'' in U/min^3", "Sollstrom Isoll in mA","Vsoll"};
for k=1:4
    subplot(1,4,k)
    xlabel('Zeit t in s');
    ylabel(ylabels{k});
    hold on
    switch k
       case 1
            plot(t4, y4(:, 1),'r');
            plot(t5, y5(:, 1),'b');
            Vsoll = 1500*(1-exp(-2.5*t1));
            plot(t1,Vsoll,'gr')
            clear Vsoll
            legend('ode15s', 'Euler-Verfahren','Vsoll');
        case 2
            plot(t4, y4(:, 2),'r');
            plot(t5, y5(:, 2),'b');
            legend('ode15s', 'Euler-Verfahren');
        case 3
            plot(t4, y4(:, 3),'r');
            plot(t5, y5(:, 3),'b');
            legend('ode15s', 'Euler-Verfahren');
        case 4
            Isoll_neu4 = params.Kp * (Vsoll(t4) - y4(:, 1)); 
            Isoll_neu5 = params.Kp * (Vsoll(t5) - y5(:, 1)); 
            plot(t4, Isoll_neu4,'r');
            plot(t4, Isoll_neu5,'b');
            legend('ode15s', 'Euler-Verfahren');
        
    end
       hold off
end


