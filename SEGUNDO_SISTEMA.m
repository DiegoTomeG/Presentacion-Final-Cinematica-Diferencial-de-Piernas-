%% Evaluación final
%% -------- Segundo sistema ----------------

%Limpieza de pantalla
clear all
close all
clc

%Calculamos las matrices de transformación homogénea
H0=SE3; %PUNTO DE ORIGEN
H1=SE3(rotz(pi), [3 0 0]); %Rotacion en z de 180 y traslacion en x
H2=SE3(roty(pi/2), [0 0 0]); %Rotacion en y de 90 y sin movimiento
H3=SE3(rotx(150*pi/180), [-5 0 0]); %Rotacion en x de 150 grados 

H20= H1*H2;
H30= H20*H3; %Matriz de transformación homogenea global de 3 a 0 

%Coordenadas de la estructura de translación y rotación
x=[0 3 3 0 0 0 0 0 0 3];
y=[0 0 0 0 0 5 5 0 5 0];
z=[0 0 5 5 0 0 5 5 5 5];

plot3(x, y, z,'LineWidth', 1.5); axis([-1 4 -1 6 -1 6]); grid on;
hold on;

%Graficamos la trama absoluta o global 
trplot(H0,'rgb','axis', [-1 4 -1 6 -1 6]);
% 
% %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H0, H1,'rgb','axis', [-1 4 -1 6 -1 6]);
% %Realizamos una animación para la siguiente trama
 pause;
 tranimate(H1, H20,'rgb','axis', [-1 4 -1 6 -1 6]);
% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H20, H30,'rgb','axis', [-1 4 -1 6 -1 6])
  disp('Matriz de transformación homogénea global T')
  disp(H30)