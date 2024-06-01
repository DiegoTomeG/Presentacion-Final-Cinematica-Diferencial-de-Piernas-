%% Evaluación final
%% -------- Tercer sistema ----------------

%Limpieza de pantalla
clear all
close all
clc

%Calculamos las matrices de transformación homogénea

% ------ Tercer sistema --------

% ------- Operaciones para punto de origen ---------
% Punto de origen primeramente lo posicionamos en el inicio del sistema
% segun la imagen propuesta
H0=SE3([0 0 8]);
% Seguimos en el punto de origen pero tenemos que hacer una rotación de z 
% de -90 grados y una traslación de posición en la coordenada (x,y,z) de (0,0,8) 
% para posicionarlo como la imagen propuesta sin mover el sistema
Rotacion = roty(pi/2)*rotx(pi/2); %Rotacion de y 90 grados junto con rotacion de 90 grados de x
H1=SE3(Rotacion, [0 0 8]); 

% ------- Traslaciones ---------
H2=SE3(rotx(-pi/2), [0 0 0]); %Rotacion en x de -90 grados sin traslacion
H3=SE3([4 0 0]);  %Traslacion de 4 en x
H4=SE3(rotz(-pi/2), [4 0 0]); %Rotacion de -90 grados en z y traslacion en x de 4
H5=SE3(rotx(pi/2), [0 0 0]); %Rotacion de 90 grados en x sin traslacion


H20= H1*H2;
H30= H20*H3; %Matriz de transformación homogenea global de 3 a 0 
H40= H30*H4;
H50= H40*H5;


%Coordenadas de la estructura de translación y rotación
x=[4 0 0];
y=[0 0 0];
z=[8 8 0];

plot3(x, y, z,'LineWidth', 1.5); axis([-1 9 -1 9 -1 9]); grid on;
hold on;

%Graficamos la trama absoluta o global 
trplot(H0,'rgb','axis', [-1 9 -1 9 -1 9]);
% 
% %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H0, H1,'rgb','axis', [-1 9 -1 9 -1 9]);

% %Realizamos una animación para la siguiente trama
 pause;
 tranimate(H1, H20,'rgb','axis', [-1 9 -1 9 -1 9]);

% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H20, H30,'rgb','axis', [-1 9 -1 9 -1 9]);

% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H30, H40,'rgb','axis', [-1 9 -1 9 -1 9]);

% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H40, H50,'rgb','axis', [-1 9 -1 9 -1 9])
  disp('Matriz de transformación homogénea global T') 
  disp(H50)

