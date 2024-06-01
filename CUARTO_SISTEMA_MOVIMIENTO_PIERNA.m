%% Evaluación final
% Sistema de movimiento de piernas
%% -------- Cuarto sistema ----------------

%Limpieza de pantalla
clear all
close all
clc

%Calculamos las matrices de transformación homogénea

%------- PUNTO ORIGEN ---------------
%Declaramos el punto de origen inicial del sistema tomando en cuenta
% que comenzara desde aqui hasta el punto final de (2,2,-2)
H0=SE3([3 2 7]);%PUNTO DE ORIGEN

% ROTACION PARA ACOMODAR HACIA X0,Y0,Z0 --- X1,Y1,Z1
%Seguimos en el punto de origen y hacemos una rotacion para los tres ejes
% para poder acomodar correctamente al inicio del sistema
%rotacion en y de -180 grados
%rotacion en z de -90 grados
%rotacion en x de -22.5 grados
H1=SE3(roty(-pi)*rotz(-pi/2)*rotx(-pi/8), [3 2 7]);

% X2,Y2,Z2
% Hacemos una rotacion de x de -60 grados junto con una rotacion de y de 90
% grados sin hacer traslaciones 
H2=SE3(rotx(-pi/3)*roty(pi/2), [0 0 0]);

% X3,Y3,Z3
% Rotar en z -120.8 grados para podernos ajustar al sistema y sobre todo al
% eje inclinado de la estructura y una rotacion de 90 grados en x para
% confirmar y llegar al sistema de X3,Y3,Z3 que el eje x coincide con la
% estructura para hacer la traslacion en el siguiente paso
H3=SE3(rotz(-151/225*pi), [0 0 0]); 
H4=SE3(rotx(pi/2), [0 0 0]);


% X4,Y4,Z4
%Traslacion en x de tres unidades 
H5=SE3([3 0 0]);

% X5,Y5,Z5
%declaramos una nueva rotacion para hacer rotacion de z en 90 grados y 
%rotacion de y en 90 grados y a eso añadimos la rotacion de -23/180pi para
%acomodarlo al sistema correctamente junto con una traslacion de 4.588 para
%llegar al talon de la pierna coordenada (0,2,0)
rotarz= rotz(-23/180*pi);
H6=SE3((rotz(pi/2)*roty(pi/2))*rotarz, [4.588 0 0]);

% X6,Y6,Z6
%Hacemos una rotacion de z de 90 grados y una rotacion en x de 90 grados
%sin traslaciones, nos mantenemos en el mismo punto
H7=SE3(rotz(pi/2)*rotx(pi/2), [0 0 0]);

% X7,Y7,Z7
%Finalmente hacemos una traslacion en z de esa unidad con ayuda del teorema
%de pitagoras, podemos sacar la hipotenusa que es la linea inclinada hacia
%la coordenada final de (2,2,-2)
H8=SE3([0 0 2.8284]);

H20= H1*H2;
H30= H20*H3; %Matriz de transformación homogenea global de 3 a 0 
H40= H30*H4;
H50= H40*H5;
H60= H50*H6;
H70= H60*H7;
H80= H70*H8;

%Coordenadas de la estructura de translación y rotación
x=[ 2  0  3];
y=[ 2  2  2];
z=[-2  0  7];

plot3(x, y, z,'LineWidth', 1.5); axis([-1 7 -1 7 -3 9]); grid on;
hold on;

%Graficamos la trama absoluta o global 
trplot(H0,'rgb','axis', [-1 7 -1 7 -3 9])
% 
% %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H0, H1,'rgb','axis', [-1 7 -1 7 -3 9])
% %Realizamos una animación para la siguiente trama
 pause;
 tranimate(H1, H20,'rgb','axis', [-1 7 -1 7 -3 9])
% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H20, H30,'rgb','axis', [-1 7 -1 7 -3 9]);

% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H30, H40,'rgb','axis', [-1 7 -1 7 -3 9]);

% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H40, H50,'rgb','axis', [-1 7 -1 7 -3 9]);

% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H50, H60,'rgb','axis', [-1 7 -1 7 -3 9]);

% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H60, H70,'rgb','axis', [-1 7 -1 7 -3 9]);

% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H70, H80,'rgb','axis', [-1 7 -1 7 -3 9]);
  disp('Matriz de transformación homogénea global T')
  disp(H80)