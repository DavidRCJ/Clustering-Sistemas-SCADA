%%%Cruz Juarez David Ricardo%%%
%%%Hernandez Lopez Oliver Edson%%%%
%%%Ramirez Peña Eli Antonio%%%%%
%%%%       1014-A          %%%%%
rng('default')
tiem=Altura1.time;

%Falla de altura en el tanque 1
Data1=[Altura1.signals(1).values Altura2.signals(1).values]
%Falla de altura en el tanque 2
Data2=[Altura1.signals(1).values Altura2.signals(1).values]
%Falla en la constante del tubo
Data3=[Altura1.signals(1).values Altura2.signals(1).values]

%Declaramos el numero de cluster 5
% X=Data;
% Signal=1;
% k=5;
% [idx,C,dis] = kmeans(X,k);
% scatter3(X(:,1),X(:,2),X(:,3),20,idx);
% subplot(3,1,2);
% gscatter(DosTanques.time,X(:,Signal),idx);
for i=1:7
    x1(:,i) = kmeans(Data1,i)
    x2(:,i) = kmeans(Data2,i)
    x3(:,i) = kmeans(Data3,i)
end

%Graficamos la Varianza y cluster
% var=0;
% for i=1:length(dis)
%     var = var+dis(i);
% end
% varT(k)= var
%  subplot(3,1,3)
%  plot(varT,idx) 
%Usamalos la funcion "evalcluster" This MATLAB function creates a clustering evaluation object containing data used
% to evaluate the optimal number of data clusters.
% eva = evalclusters(x,clust,criterion)
% eva = evalclusters(x,clust,criterion,Name,Value)
% See also CalinskiHarabaszEvaluation, DaviesBouldinEvaluation, GapEvaluation, 
% SilhouetteEvaluation
%%--------INCISO A, grafica de la varianza----------%%%%%%%%%%
figure(1)
    subplot(3,1,1)
    var1= evalclusters(Data1,x1,'CalinskiHarabasz');
    plot(var1)
    subplot(3,1,2)
    var2= evalclusters(Data2,x2,'CalinskiHarabasz');
    plot(var2)
   subplot(3,1,3)
    var3= evalclusters(Data3,x3,'CalinskiHarabasz');
    plot(var3)
suptitle('Inciso A, con 7 clusters')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%--------Incisiso B----------%%%%%%%%%%
%Calcular la distancia entre puntos
% Y= pdist(X);
    Y1= pdist(x1);
    Y2= pdist(x2);
    Y3= pdist(x3);
%Varion de la metrica y metodo para las fallas PARA 1
% Z= linkage(X,'ward','euclidean');
    Z11= linkage(Data1,'ward','seuclidean');
    Z21= linkage(Data1,'centroid','chebychev');
    Z31= linkage(Data1,'weighted','euclidean');
% c= cluster(Z,'maxclust',3);
    c1(1,1)= cophenet(Z11,Y1);
    c1(2,1)= cophenet(Z21,Y1);
    c1(3,1)= cophenet(Z31,Y1);

%Varion de la metrica y metodo para las fallas PARA 1
% Z= linkage(X,'ward','euclidean');
    Z12= linkage(Data2,'ward','seuclidean');
    Z22= linkage(Data2,'centroid','chebychev');
    Z32= linkage(Data2,'weighted','euclidean');
% c= cluster(Z,'maxclust',3);
    c2(1,1)= cophenet(Z12,Y2);
    c2(2,1)= cophenet(Z22,Y2);
    c2(3,1)= cophenet(Z32,Y2);

%Varion de la metrica y metodo para las fallas PARA 1
% Z= linkage(X,'ward','euclidean');
    Z13= linkage(Data3,'ward','seuclidean');
    Z23= linkage(Data3,'centroid','chebychev');
    Z33= linkage(Data3,'weighted','euclidean');
% c= cluster(Z,'maxclust',3);
    c3(1,1)= cophenet(Z13,Y1);
    c3(2,1)= cophenet(Z23,Y1);
    c3(3,1)= cophenet(Z33,Y1);
%%----INCISO B, Graficamos la relacionm cofenetica
   figure(2)
    subplot(1,3,1)
    plot(1:3,c1,'LineWidth',3)
    subplot(1,3,2)
    plot(1:3,c2,'LineWidth',3)
    subplot(1,3,3)
    plot(1:3,c3,'LineWidth',3)
  suptitle('Inciso B,Clasificacion Cofenetica')    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%--------------INCISO C----------------------
%%-----Varaicion de metodo K-medias 
%%%%Tanque 1
figure(3)
subplot(3,1,1)
    [idx1,C1,dis1] = kmeans(Data1,2);
    gscatter(Data1(:,1),Data1(:,2),idx1);
    title('K=2')
subplot(3,1,2)
    [idx2,C3,dis3] = kmeans(Data1,5);
    gscatter(Data1(:,1),Data1(:,2),idx2);
    title('K=5')
subplot(3,1,3)
    [idx3,C3,dis3] = kmeans(Data1,7);
    gscatter(Data1(:,1),Data1(:,2),idx3);
    title('K=7')

suptitle('Falla en sensor nivel tanque 1 con diferentes K')

%%%%Tanque 2
figure(4)
subplot(3,1,1)
    [idx11,C11,dis11] = kmeans(Data2,2);
    gscatter(Data2(:,1),Data2(:,2),idx11);
    title('K=2')
subplot(3,1,2)
    [idx22,C22,dis22] = kmeans(Data2,5);
    gscatter(Data2(:,1),Data2(:,2),idx22);
    title('K=5')
subplot(3,1,3)
    [idx33,C33,dis33] = kmeans(Data2,7);
    gscatter(Data2(:,1),Data1(:,2),idx33);
    title('K=7')

suptitle('Falla en sensor nivel tanque 2 con diferentes K')
%%%%    Falla en el el tubo de paso 1-2
figure(5)
subplot(3,1,1)
    [idx111,C111,dis111] = kmeans(Data3,2);
    gscatter(Data3(:,1),Data3(:,2),idx111);
    title('K=2')
subplot(3,1,2)
    [idx222,C222,dis222] = kmeans(Data3,5);
    gscatter(Data3(:,1),Data3(:,2),idx222);
    title('K=5')
subplot(3,1,3)
    [idx333,C333,dis333] = kmeans(Data3,7);
    gscatter(Data3(:,1),Data3(:,2),idx333);
    title('K=7')

suptitle('Falla en la constante del tubo con diferentes K')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%-------INCISO 4--------------
%%%%-----Variacion de metodo Jerarquico 

%%%%Tanque 1
figure(6)
subplot(3,1,1)
   cc1=cluster(Z11,'maxclust',2);
   gscatter(Data1(:,1),Data2(:,2),cc1);
   title('k=2');
subplot(3,1,2)
   cc2=cluster(Z12,'maxclust',5);
   gscatter(Data1(:,1),Data2(:,2),cc2);
   title('k=5');
subplot(3,1,3)
   cc3=cluster(Z13,'maxclust',7);
   gscatter(Data1(:,1),Data2(:,2),cc3);
   title('k=7');
   suptitle('Falla en tanque 1 K Jerarquico')
%%%%Tanque 2
figure(7)
subplot(3,1,1)
   cc11=cluster(Z21,'maxclust',2);
   gscatter(Data1(:,1),Data2(:,2),cc11);
   title('k=2');
subplot(3,1,2)
   cc22=cluster(Z22,'maxclust',5);
   gscatter(Data1(:,1),Data2(:,2),cc22);
   title('k=5');
subplot(3,1,3)
   cc33=cluster(Z23,'maxclust',7);
   gscatter(Data1(:,1),Data2(:,2),cc33);
   title('k=7');
   suptitle('Falla en tanque 2 K Jerarquico')
%%%%Tanque tubo
figure(8)
subplot(3,1,1)
   cc111=cluster(Z31,'maxclust',2);
   gscatter(Data1(:,1),Data2(:,2),cc111);
   title('k=2');
subplot(3,1,2)
   cc222=cluster(Z32,'maxclust',5);
   gscatter(Data1(:,1),Data2(:,2),cc222);
   title('k=5');
subplot(3,1,3)
   cc333=cluster(Z33,'maxclust',7);
   gscatter(Data1(:,1),Data2(:,2),cc333);
   title('k=7');
   suptitle('Falla en el tubno de interconeccion en tanque 1-2 K Jerarquico')
