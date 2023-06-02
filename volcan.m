%Esteban Sierra Baccio
%Fernanda Tenorio Morales
%Nicolás Treviño Cuéllar
%Adolfo Humberto Gonzalez Gonzalez

% Inicialización
clc
clf

% Información del volcán.
base = (input("Base del volcán: "));
altura = (input("Altura del volcán: "));

x = [0 base/3 2*base/3 base];
y = [0 altura altura 0];
color = [102 51 0]/255;
patch(x,y,color)

lava_x = [base/3 2*base/3 (base/3)+(((2*base/3)-(base/3))/2)];
lava_y = [altura altura altura/1.5];
patch(lava_x,lava_y,"red")

% Variables iniciales
gravedad = -9.81;
velocidad_inicial = input("Velocidad inicial: ");
angulo = input("Ángulo del proyectil: ");
dt = 0.01;
masa = input("Masa del proyectil: ");
b = 0.033;

% Variables automáticas
velocidad_inicial_x = velocidad_inicial*cos(deg2rad(angulo));
velocidad_inicial_y = velocidad_inicial*sin(deg2rad(angulo));

velocidad_anterior_x = velocidad_inicial_x;
velocidad_anterior_y = velocidad_inicial_y;

max_height = (velocidad_inicial_y^2)/(2*-gravedad) + altura;
max_base = ((velocidad_inicial^2)/-gravedad)*sin((deg2rad(angulo))) + base + altura;

axis([0 max_base 0 max_height])

%Inicialización de variables
px_real = base/2;
py_real = altura;
px_ideal = 0;
py_ideal = 1;
tiempo = 0;
soyunavariable = 1;

hold on

while py_ideal >= 0

    %Valores Ideales
    px_ideal = base/2 + velocidad_inicial_x*tiempo;
    py_ideal = altura + (velocidad_inicial_y*tiempo) + (0.5*gravedad*tiempo^2);
    plot(px_ideal,py_ideal,".r")


    %Valores con arrastre

    velocidad_enx = velocidad_anterior_x + dt * ((-b/masa) * velocidad_anterior_x);
    velocidad_eny = velocidad_anterior_y + dt * (((-b / masa) * velocidad_anterior_y) + gravedad);

    px_real =  px_real + velocidad_enx*dt;
    py_real =  py_real + velocidad_eny*dt;

    plot(px_real, py_real, ".g")

    velocidad_anterior_y = velocidad_eny;
    velocidad_anterior_x = velocidad_enx;

    %Imprimir los valores
    if px_real < max_base && py_real > 0
        texto_real = text(px_real,py_real, round(px_real,2) + " , " + round(py_real,2));
        tr = 1;
    end

    if px_ideal < max_base && py_ideal > 0
        texto_ideal = text(px_ideal,py_ideal, round(px_ideal,2) + " , " + round(py_ideal,2));
        ti = 1;
    end

    tiempo = tiempo+dt;
    pause(dt)
    if tr == 1
        delete(texto_real)
        tr = 0;
    end
    if ti == 1
        delete(texto_ideal)
        ti = 0;
    end
end