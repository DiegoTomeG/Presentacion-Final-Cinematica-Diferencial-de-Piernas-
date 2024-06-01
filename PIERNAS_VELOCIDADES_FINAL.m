% Evaluación - Piernas velocidades
% José Diego Tomé Guardado A01733345

% Limpieza de pantalla
clear all
close all
clc

% Declaración de variables simbólicas
syms th1(t) th2(t) th3(t) a1 l1 t % esferica
syms th4(t) a2 l2 % rotacional
syms th5(t) a3 l3
syms th6(t) a4 l4 % semi esferica

% Configuración del robot, 0 para junta rotacional, 1 para junta prismática
RP = [0 0 0 0];

% Creamos el vector de coordenadas articulares
Q = [th1, th4, th5, th6];

% Creamos el vector de velocidades generalizadas
Qp = diff(Q, t);

% Número de grado de libertad del robot
GDL = size(RP, 2);

% Inicialización de matrices de transformación
% Articulación 1 (esférica: tres ángulos) ------------ MUSLO
R1_rotax = [1      0               0;
            0 cos(th1) -sin(th1);
            0 sin(th1) cos(th1)];

R2_rotay = [cos(th2)   0  sin(th2);
        0            1           0;
        -sin(th2)  0  cos(th2)];

R3_rotaz = [cos(th3)  -sin(th3)  0;
        sin(th3)   cos(th3)  0;
        0               0        1];

R(:,:,1) = R3_rotaz.* R2_rotay.* R1_rotax.*(R1_rotax*(-pi/2)).*(R3_rotaz(-pi/2));

P(:,:,1) = [0; 0; l1];

% Articulación 2 (rotacional: un ángulo) ------------ RODILLA
R4_rotaz = [cos(th4) -sin(th4) 0;
        sin(th4) cos(th4) 0;
        0 0 1];

R(:,:,2) = R4_rotaz.*(R4_rotaz*(-pi/2));

P(:,:,2) = [l2; 0; 0];

% Articulación 3 ------------ TALON

R5_rotaz = [cos(th5) -sin(th5) 0;
            sin(th5) cos(th5) 0;
                              0 0 1];

R(:,:,3) = R5_rotaz.* (R5_rotaz*(pi/2));
P(:,:,3) = [l3; 0; 0];

% Articulación 4 ---------------- empeine

R4_rotaz = [cos(th6) -sin(th6) 0;
            sin(th6) cos(th6) 0;
                              0 0 1];

P(:,:,4) = [0; 0; l4];
R(:,:,4) = R4_rotaz;


% Creamos un vector de ceros
Vector_Zeros = zeros(1, 3);

% Inicializamos las matrices de transformación Homogénea locales
A(:,:,GDL)=simplify([R(:,:,GDL) P(:,:,GDL); Vector_Zeros 1]);
% Inicializamos las matrices de transformación Homogénea globales
T(:,:,GDL)=simplify([R(:,:,GDL) P(:,:,GDL); Vector_Zeros 1]);
% Inicializamos las posiciones vistas desde el marco de referencia inercial
PO(:,:,GDL)= P(:,:,GDL); 
% Inicializamos las matrices de rotación vistas desde el marco de referencia inercial
RO(:,:,GDL)= R(:,:,GDL); 

for i = 1:GDL
    i_str= num2str(i);
   %disp(strcat('Matriz de Transformación local A', i_str));
    A(:,:,i)=simplify([R(:,:,i) P(:,:,i); Vector_Zeros 1]);
   %pretty (A(:,:,i));

   %Globales
    try
       T(:,:,i)= T(:,:,i-1)*A(:,:,i);
    catch
       T(:,:,i)= A(:,:,i);
    end
    disp(strcat('Matriz de Transformación global T', i_str));
    T(:,:,i)= simplify(T(:,:,i));
    pretty(T(:,:,i))

    RO(:,:,i)= T(1:3,1:3,i);
    PO(:,:,i)= T(1:3,4,i);
    %pretty(RO(:,:,i));
    %pretty(PO(:,:,i));
end

%Calculamos el jacobiano lineal de forma analítica
Jv_a(:,GDL)=PO(:,:,GDL);
Jw_a(:,GDL)=PO(:,:,GDL);

for k= 1:GDL
    if RP(k)==0 
       %Para las juntas de revolución
        try
            Jv_a(:,k)= cross(RO(:,3,k-1), PO(:,:,GDL)-PO(:,:,k-1));
            Jw_a(:,k)= RO(:,3,k-1);
        catch
            Jv_a(:,k)= cross([0,0,1], PO(:,:,GDL));%Matriz de rotación de 0 con respecto a 0 es la Matriz Identidad, la posición previa tambien será 0
            Jw_a(:,k)=[0,0,1];%Si no hay matriz de rotación previa se obtiene la Matriz identidad
         end
     else
%         %Para las juntas prismáticas
        try
            Jv_a(:,k)= RO(:,3,k-1);
        catch
            Jv_a(:,k)=[0,0,1];
        end
            Jw_a(:,k)=[0,0,0];
     end
 end    

Jv_a= simplify (Jv_a);
Jw_a= simplify (Jw_a);
disp('Jacobiano lineal obtenido de forma analítica');
pretty (Jv_a);
disp('Jacobiano ángular obtenido de forma analítica');
pretty (Jw_a);


disp('Velocidad lineal obtenida mediante el Jacobiano lineal');
V=simplify (Jv_a*Qp');
pretty(V);
disp('Velocidad angular obtenida mediante el Jacobiano angular');
W=simplify (Jw_a*Qp');
    pretty(W);