%%CRUZ JUAREZ DAVID RICARDO
%%HERNANDEZ LOPEZ OLIVER EDSON
%%RAMIREZ PEÑA ELIA ANTONIO

rng('default') % Para que se repita el programa
%% Valores del sistema (Parámetros)
   A1=95.5200;
   A2=64;
   k1=0.95800;
   k2=1.363500;
% SISTEMA DE PRUEBA

%Modificar los valores de perturbación a gusto
   ErrorS1=1; %Sensor de nivel tanque 1
   ErrorS2=0; %Sensor de nivel tanque 2
   Perturbacion=0; % Constante de la tubería 
   
% SISTEMA DE ENTRENAMIENTO
   
%Modificar los valores de perturbación a gusto
   Error2S1=0; %Sensor de nivel tanque 1
   Error2S2=0; %Sensor de nivel tanque 2
   Perturbacion2=0;% Constante de la tubería 
%% CLUSTERING Y ANÁLISIS DISCRIMINANTE

tiempo=out.TanquesCl.time;
tiempo2=out.TanquesCl2.time;
Data=[out.TanquesCl.signals(1).values out.TanquesCl.signals(2).values out.TanquesCl.signals(3).values];
Data2=[out.TanquesCl2.signals(1).values out.TanquesCl2.signals(2).values out.TanquesCl2.signals(3).values];

X=Data;
XX=Data2;
%% K-Means
% De la práctica anterior, fue posible ver como con k=4 se alcanzan a
% Para distinguir las fallas es necessario poner un cluester de 7. 
k=7;
Signal=2;
[idx,C,dis]=kmeans(X,k);

figure(1)
subplot(2,2,1);
scatter(X(:,1),X(:,2),20,idx);
subplot(2,2,2);
gscatter(tiempo,X(:,Signal),idx);


%% Método Jerárquico

%Y = pdist(X);

% Distintos métodos y métricas

%     [c1,d1] = cophenet(Z11,Y);
%     [c2,d2] = cophenet(Z21,Y);
%     [c3,d3] = cophenet(Z31,Y);
    % Gráficas clustering Método Jerárquico 
    
%  for p=2:5   
% figure(19)
% %Inciso 4 para valores de k de 2 a 5 
% subplot(2,2,p-1)
%    cc1=cluster(Z11,'maxclust',p);
%    gscatter(X(:,1),X(:,2),cc1);
%subplot(3,2,2)
   %cc2=cluster(Z21,'maxclust',p);
   %gscatter(X(:,1),X(:,2),cc2);
%subplot(3,2,3)
   %cc3=cluster(Z31,'maxclust',4);
  % gscatter(X(:,1),X(:,2),cc3);
%subplot(3,2,4)
   %cc3=cluster(Z31,'maxclust',5);
  % gscatter(X(:,1),X(:,2),cc3);
   
%end
% 

  Z11= linkage(X,'ward','seuclidean');
  Z21= linkage(X,'centroid','chebychev');
  Z31= linkage(X,'weighted','euclidean');
  
Z = linkage(X,'ward','euclidean');
c = cluster(Z,'maxclust',k);

subplot(2,2,3);
scatter(X(:,1),X(:,2),20,c);
subplot(2,2,4);
gscatter(tiempo,X(:,Signal),c);


 

%%  Funciónes discriminantes 

 Z1= linkage(XX,'ward','seuclidean');
 Z2= linkage(XX,'centroid','chebychev');
 Z3= linkage(XX,'weighted','euclidean');
  
Z0 = linkage(XX,'ward','euclidean');
ce = cluster(Z0,'maxclust',k);
figure(2)
subplot(3,2,1);
gscatter(out.TanquesCl2.time,XX(:,1),ce);
title(" Sin falla en el  sensor de nivel del tanque 1 ");
subplot(3,2,3);
gscatter(out.TanquesCl2.time,XX(:,2),ce);
title("Sin falla en el  sensor de nivel del tanque 2 ");
subplot(3,2,5);
gscatter(out.TanquesCl2.time,XX(:,3),ce);
title("Sin falla en la tubería");


P=X;
E1=XX;
grupo=ce;
[clase,error]=classify(P,E1,grupo,'diaglinear');
subplot(3,2,2);
gscatter(out.TanquesCl.time,X(:,1),clase);
title("Falla en el  sensor de nivel del tanque 1 ");
k=0;
k=find(clase==1);
if k~=0;
    fprintf('Error de sensor de nivel del tanque 1.\n');
else
    fprintf('Sensor de nivel del tanque 1 normal.\n');
end

P=X;
E2=XX;
grupo2=ce;
[clase,error]=classify(P,E2,grupo2,'diaglinear');
subplot(3,2,4);
gscatter(out.TanquesCl.time,X(:,2),clase);
title("Falla en el sensor de  nivel del tanque 2");
k=0;
k=find(clase==2);
if k~=0;
    fprintf('Error de sensor de nivel del tanque 2.\n');
else
    fprintf('Sensor de nivel del tanque 2 normal.\n');
end
P=X;
E3=XX;
grupo3=ce;
[clase,error]=classify(P,E3,grupo3,'diaglinear');
subplot(3,2,6);
gscatter(out.TanquesCl.time,X(:,3),clase);
title("Falla en la tubería");

k=0;
k=find(clase==3);
if k~=0;
    fprintf('Error en la tuberia.\n');
else
    fprintf('Sensor en la tuberia normal.\n');
end
